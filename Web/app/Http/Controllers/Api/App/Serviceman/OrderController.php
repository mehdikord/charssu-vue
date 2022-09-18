<?php

namespace App\Http\Controllers\Api\App\Serviceman;

use App\Http\Controllers\Controller;
use App\Models\Order;
use App\Models\Order_Note;
use App\Models\Order_Product;
use App\Models\Order_Serviceman;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class OrderController extends Controller
{
    public function new()
    {
        $serviceman = api_serviceman_get_user();
        $data = $serviceman->orders()
            ->where('accepted',false)
            ->where('canceled',false)
            ->first();
        return response()->json($data);
    }

    public function accept(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'order_serviceman_id' => 'required|exists:order_servicemans,id',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors'=>$validator->errors(),'status'=>422],422);
        }
        $order = Order_Serviceman::find($request->order_serviceman_id);
        if ($order->serviceman_id !== api_serviceman_get_id()){
            return response()->json(['error' => 'forbidden'],403);
        }
        if ($order->order->is_done){
            return response()->json(['error' => 'این سفارش قبلا به پایان رسیده است'],409);
        }
        if ($order->order->servicemans()->where('accepted',true)->exists()){
            return response()->json(['error' => 'این سفارش توسط سرویس کار دیگری درحال انجام است'],409);
        }
        if ($order->canceled){
            return response()->json(['error' => 'این سفارش قبلا رد شده است'],409);
        }

        $order->update([
            'accepted' => true,
            'accepted_at' => Carbon::now(),
        ]);
        $order->order()->update([
            'start_at' => Carbon::now(),
        ]);
        return response()->json(['message' => 'سفارش باموفقیت پذیرفته شد']);
    }

    public function cancel(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'order_serviceman_id' => 'required|exists:order_servicemans,id',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors'=>$validator->errors(),'status'=>422],422);
        }
        $order = Order_Serviceman::find($request->order_serviceman_id);
        if ($order->serviceman_id !== api_serviceman_get_id()){
            return response()->json(['error' => 'forbidden'],403);
        }
        if ($order->order->is_done){
            return response()->json(['error' => 'این سفارش قبلا به پایان رسیده است'],409);
        }
        $order->update([
            'accepted' => false,
            'canceled' => true,
            'canceled_at' => Carbon::now(),
        ]);

        return response()->json(['message' => 'سفارش باموفقیت کنسل شد']);

    }

    public function cancel_reason(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'order_serviceman_id' => 'required|exists:order_servicemans,id',
            'cancel_reason' => 'required',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors'=>$validator->errors(),'status'=>422],422);
        }
        $order = Order_Serviceman::find($request->order_serviceman_id);
        if ($order->serviceman_id !== api_serviceman_get_id()){
            return response()->json('forbidden',403);
        }
        if ($order->order->is_done){
            return response()->json(['error' => 'این سفارش قبلا به پایان رسیده است'],409);
        }
        if ($order->accepted){
            return response()->json(['error' => 'این سفارش توسط شما درحال انجام است !'],409);
        }
        $order->update(['cancel_reason' => $request->cancel_reason]);
        return response()->json(['message' => 'دلیل رد شدن سفارش باموفقیت ثبت شد']);
    }

    public function single(Order $order)
    {
        if (!$order->servicemans()->where('serviceman_id',api_serviceman_get_id())->exists()){
            return response()->json(['error' => 'forbidden'],403);
        }
         $order->load(['customer' => function($customer){
             $customer->select(['id','name','phone','tel','address'])->get();
         }]);
        $order->load([
            'problem',
            'province',
            'city',
            'zone',
            'device_brand',
            'device',
        ]);
        return response()->json($order);

    }

    public function done()
    {
        $result = Order::where('is_done',true)->whereHas('servicemans',function ($serviceman){
            $serviceman->where('serviceman_id',api_serviceman_get_id())->where('accepted',true)->where('canceled',false);
        })->with('customer')->get();

        return response()->json($result);
    }

    public function active()
    {
        $result = api_serviceman_get_user()->orders()->where('accepted',true)->where("canceled",false)->whereHas('order',function ($order){
            $order->where('is_done',false);
        })->with('order', function ($order) {
            $order->with('customer');
        })->get();
        return response()->json($result);
    }

    public function set_notes(Order $order,Request $request)
    {
        if (!$order->servicemans()->where('serviceman_id',api_serviceman_get_id())->exists()){
            return response()->json(['error' => 'forbidden'],403);
        }
        $validator = Validator::make($request->all(), [
            'note' => 'required',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors'=>$validator->errors(),'status'=>422],422);
        }
        $order->notes()->create([
            'serviceman_id' => api_serviceman_get_id(),
            'note' => $request->note,
        ]);

        return response()->json(['message' => 'گزارش باموفقیت ثبت گردید']);
    }

    public function get_notes(Order $order)
    {
        if (!$order->servicemans()->where('serviceman_id',api_serviceman_get_id())->exists()){
            return response()->json(['error' => 'forbidden'],403);
        }
        return response()->json($order->notes);
    }

    public function delete_note(Order_Note $note)
    {
        if (!$note->order->servicemans()->where('serviceman_id',api_serviceman_get_id())->exists()){
            return response()->json(['error' => 'forbidden'],403);
        }
        $note->delete();
        return response()->json(['message' => 'گزارش باموفقیت حذف گردید']);
    }

    public function get_products(Order $order)
    {
        if (!$order->servicemans()->where('serviceman_id',api_serviceman_get_id())->exists()){
            return response()->json(['error' => 'forbidden'],403);
        }
        $result = $order->products()
            ->with('products.category')
            ->with('products.brand')
            ->with(['products' => function ($product){
                $product->select(['id','product_category_id','device_brand_id','name','code','product_code','price','sale','serviceman_price'])->get();
            }])
            ->with(['serviceman' => function($serviceman){
                $serviceman->select('id','name','phone','email','profile','code')->get();
            }])
            ->get();

        return response()->json($result);

    }

    public function set_products(Order $order,Request $request)
    {
        $validator = Validator::make($request->all(), [
            'product_id' => 'required|exists:products,id',
            'paid' => 'required|string',
            'quantity' => 'required|numeric',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors'=>$validator->errors(),'status'=>422],422);
        }
        if (!$order->servicemans()->where('serviceman_id',api_serviceman_get_id())->where('accepted',true)->exists()){
            return response()->json(['error' => 'forbidden'],403);
        }
        //check order active
        if ($order->is_done && !$order->is_active){
            return response()->json(['error' => 'این سفارش به پایان رسیده  است'],409);
        }
        $is_paid = 0;
        if ($request->paid == 'nobody'){
            $is_paid = 1;
        }
        $order->products()->create([
            'serviceman_id' => api_serviceman_get_id(),
            'product_id' => $request->product_id,
            'paid' => $request->paid,
            'quantity' => $request->quantity,
            'is_paid' => $is_paid,
        ]);
        return response()->json(['message' => 'محصول مورد نظر باموفقیت به سفارش اضافه شد']);
    }

    public function delete_product(Order_Product $product)
    {
        if (!$product->order->servicemans()->where('serviceman_id',api_serviceman_get_id())->exists()){
            return response()->json(['error' => 'forbidden'],403);
        }
        $product->delete();
        return response()->json(['message' => 'قطعه باموفقیت حذف گردید']);

    }







}
