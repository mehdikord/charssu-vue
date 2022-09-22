<?php

namespace App\Http\Controllers\Api\App\Serviceman;

use App\Http\Controllers\Controller;
use App\Models\Order_Invoice;
use Carbon\Carbon;
use Illuminate\Http\Request;

class PaymentController extends Controller
{
    public function start(Order_Invoice $invoice)
    {
        if ($invoice->is_pay){
            return response()->json(['error' => 'این فاکتور قبلا پرداخت شده است'],409);
        }
        if ($invoice->type !== 'serviceman'){
            return response()->json(['error' => 'این فاکتور باید توسط مشتری پرداخت شود'],409);
        }
        $amount = $invoice->price;

        //send request for payment #TODO


        $url = 'aaaaaaaaa';

        return response()->json($url);
    }

    /**
     * @throws \Exception
     */
    public function callback(Request $request)
    {
        $invoice = Order_Invoice::findorfail($request->invoice_id);

        $ref_id = random_int(1000000000,9999999999);
        $gateway = 'IDpay';
        $method = 'online';
        $pay_id = random_int(1000000000,9999999999);
        if ($request->pay == 1){

            //update invoice
            $invoice->update([
                'is_pay' => true,
                'ref_id' => $ref_id,
                'pay_id' => $pay_id,
                'method' => $method,
                'gateway' => $gateway,
                'paid_at' => Carbon::now(),
            ]);

            return response()->json('invoice paid successful');

        }
        return response()->json(['error' => 'payment failed'],409);
    }


}
