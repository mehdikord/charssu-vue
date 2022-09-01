<?php

namespace App\Http\Controllers\Api\App\Serviceman;

use App\Http\Controllers\Controller;
use App\Models\Order;
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
            ->get();
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

        return response()->json(['message' => 'سفارش باموفقیت رد شد']);

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
            'province',
            'city',
            'zone',
            'device_brand',
            'device'
        ]);
        return response()->json($order);

    }

    public function done()
    {
        $result = Order::where('is_done',true)->whereHas('servicemans',function ($serviceman){
            $serviceman->where('serviceman_id',api_serviceman_get_id())->where('accepted',true)->where('canceled',false);
        })->get();

        return response()->json($result);
    }

    public function active()
    {
        $result = api_serviceman_get_user()->orders()->where('accepted',true)->where("canceled",false)->whereHas('order',function ($order){
            $order->where('is_done',false);
        })->with('order')->get();
        return response()->json($result);
    }

}
