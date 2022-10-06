<?php

namespace App\Http\Controllers\Api\Customer;

use App\Http\Controllers\Controller;
use App\Models\Order_Invoice;
use Carbon\Carbon;
use GuzzleHttp\Client;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Validator;

class InvoiceController extends Controller
{

    public function all()
    {
        $invoices = Order_Invoice::query();
        $invoices->where('type','customer');
        $invoices->whereHas('order',function ($order){
            $order->where('customer_id',customer_auth_get()->id);
        });
        $invoices->with('order');
        return response()->json($invoices->get());
    }

    public function show(Order_Invoice $invoice)
    {
        if ($invoice->order->customer_id != customer_auth_get()->id || $invoice->type != 'customer'){
            return response()->json(['error' => 'forbidden'],403);
        }
        $invoice->load('order');
        return response()->json($invoice);
    }

    public function start_payment(Request $request)
    {
        $validation = Validator::make($request->all(),[
            'invoice_id' => 'required|numeric|exists:order_invoices,id',

        ]);
        if ($validation->fails()){
            return response()->json($validation->errors(),421);
        }
        $invoice = Order_Invoice::find($request->invoice_id);
        if ($invoice->is_pay){
            return response()->json('این فاکتور قلا پرداخت شده است',409);
        }
        //Payment Data
        $bank_url = "https://api.idpay.ir/v1.1/payment";
        $header = [
            'Content-Type' => 'application/json',
            "X-API-KEY" => "52020244-1b5d-4ea2-bac2-e2d6936cb5cc",
            'X-SANDBOX' => 1,
        ];
        $data = [
            'order_id' =>$invoice->id,
            'amount' => $invoice->price,
            'name' => customer_auth_get()->name,
            'phone' => customer_auth_get()->phone,
            'description' => 'پرداخت فاکتور سفارش در چارسو',
            'callback' => "http://localhost:8000/api/customer/invoices/payment/callback"
        ];
        $client = new Client();
        $response = $client->post( $bank_url,
            [
                'json' => $data,
                'headers' => $header,
                'http_errors' => false
            ]);
        $response = json_decode($response->getBody(), false, 512, JSON_THROW_ON_ERROR);
        //Upgrade invoice
        $invoice->update([
            'idpay_id' => $response->id
        ]);
        return response()->json($response);

    }

    public function callback_payment(Request $request)
    {
        $status = $request->status;
        $track_id = $request->track_id;
        $id = $request->id;
        $order_id = $request->order_id;
        $amount = $request->amount;
        $card_no = $request->card_no;
        $hashed_card_no = $request->hashed_card_no;
        $date = $request->date;
        $invoice = Order_Invoice::where('id',$order_id)->where('idpay_id',$id)->first();

        if (!empty($invoice)){
            $verify_url = "https://api.idpay.ir/v1.1/payment/verify";
            $header = [
                'Content-Type' => 'application/json',
                "X-API-KEY" => "52020244-1b5d-4ea2-bac2-e2d6936cb5cc",
                'X-SANDBOX' => 1,
            ];
            $data = [
                'id' => $invoice->idpay_id,
                'order_id' => (string) $invoice->id,
            ];
            $client = new Client();
            $response = $client->post($verify_url,
                [
                    'json' => $data,
                    'headers' => $header,
                    'http_errors' => false
                ]);
            $response = json_decode($response->getBody(), false, 512, JSON_THROW_ON_ERROR);
            if (isset($response->status) && $response->status == 100){
                if (Order_Invoice::where('ref_id',$response->payment->track_id)->exists()){
                    return view('errors.customer_payment',['error' => 'به دلیل تکراری بودن کد رهگیری بانکی ، پرداخت شما مورد تايید نمیباشد . ']);
                }
                //update invoice
                $invoice->update([
                    'ref_id' => $response->payment->track_id,
                    'pay_id' => $response->track_id,
                    'is_pay' => true,
                    'card_number' => $response->payment->card_no,
                    'paid_at' => Carbon::now(),
                    'gateway' => 'IDPay',
                    'method' => 'online'
                ]);
                return redirect('/panel/invoices/details/'.$invoice->id);
            }
            return view('errors.customer_payment',['error' => 'تاییدیه پرداخت از سمت بانک امکان پذیر نیست']);
        }

        return view('errors.customer_payment',['error' => 'تراکنش مورد نظر در سیستم یافت نشد !']);


    }
}
