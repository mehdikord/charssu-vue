<?php

namespace App\Http\Controllers\Api\Customer;

use App\Http\Controllers\Controller;
use App\Models\Order;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;

class OrderController extends Controller
{
    public function new(Request $request)
    {
        $validation = Validator::make($request->all(),[
            'device_brand_id' =>'required|exists:device_brands,id',
            'device_id' =>'required|exists:devices,id',
            'problem_id' =>'required|exists:problems,id',
            'warranty' =>'required|boolean',
            'warranty_date' =>'nullable|required_if:warranty,1',
            'image' => 'nullable|image',
            'name' => 'required|max:225',
            'province_id' =>'required|exists:provinces,id',
            'city_id' =>'required|exists:cities,id',
            'zone_id' =>'required|exists:zones,id',
            'address' =>'required',
        ]);
        if ($validation->fails()){
            return response()->json($validation->errors(),421);
        }
        $image=null;
        if ($request->hasFile('image')){
            $image = Storage::put('private/orders/images/',$request->file('image'));
        }

        $customer = customer_auth_get();

        $order = $customer->orders()->create([
            'device_brand_id' => $request->device_brand_id,
            'device_id' => $request->device_id,
            'problem_id' => $request->problem_id,
            'warranty' => $request->warranty,
            'warranty_date' => $request->warranty_date,
            'image' => $image,
            'province_id' => $request->province_id,
            'city_id' => $request->city_id,
            'zone_id' => $request->zone_id,
            'description' => $request->description,
        ]);

        //generate order code
        $order->update(['code' => engine_random_code($order->id)]);

        //update Customer information
        $customer->update([
            'name' => $request->name,
            'province_id' => $request->province_id,
            'city_id' => $request->city_id,
            'zone_id' => $request->zone_id,
            'address' => $request->address,
        ]);

        //find serviceman for order
        api_order_set_serviceman($order->id);

        return response()->json('done');

    }

    //get running customer order
    public function running()
    {
        $result = customer_auth_get()->orders()->where('is_done',false)->with('device_brand')->with('device')

            ->with(['servicemans.serviceman' => function($serviceman){
                $serviceman->select(['id','name'])->get();
            }])
            ->with(['servicemans' => function($servicemans){
                $servicemans->where('accepted',true)->select(['id','order_id','serviceman_id'])->first();
            }])
            ->get();
        return response()->json($result);
    }

    public function details($code)
    {
        $order = Order::where('code',$code)->where('customer_id',customer_auth_get()->id)
            ->with('device_brand')
            ->with('device')
            ->with('problem')
            ->with(['servicemans.serviceman' => function($serviceman){
                $serviceman->select(['id','name','phone','profile','code'])->get();
            }])
            ->with(['servicemans' => function($servicemans){
                $servicemans->where('accepted',true)->select(['id','order_id','serviceman_id'])->first();
            }])
            ->with(['products.products' => function($product){
                $product->select(['id','name','price','sale','code'])->get();
            }])
            ->with('products')
            ->with('invoices.details')
            ->with(['invoices' => function($invoice){
//                $invoice->where('type','customer')->get();
            }])
            ->firstorfail();
        return response()->json($order);

    }

}
