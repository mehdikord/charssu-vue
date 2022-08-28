<?php

namespace App\Http\Controllers\Api\Customer;

use App\Http\Controllers\Controller;
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
        $order->update(['code' => engine_random_code($order->id,14)]);
        //update Customer information
        $customer->update([
            'name' => $request->name,
            'province_id' => $request->province_id,
            'city_id' => $request->city_id,
            'zone_id' => $request->zone_id,
            'address' => $request->address,
        ]);


        return response()->json('done');

    }
}
