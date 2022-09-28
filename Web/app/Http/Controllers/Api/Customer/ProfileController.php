<?php

namespace App\Http\Controllers\Api\Customer;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ProfileController extends Controller
{
    public function get_profile()
    {
        return response()->json(customer_auth_get());
    }

    public function update_profile(Request $request)
    {
        $customer = customer_auth_get();
        $validation = Validator::make($request->all(),[
            'name' => 'required|max:225',
            'province_id' =>'required|exists:provinces,id',
            'city_id' =>'required|exists:cities,id',
            'zone_id' =>'required|exists:zones,id',
            'address' =>'required',
            'tel' => "nullable|numeric|unique:,tel,$customer->id"
        ]);
        if ($validation->fails()){
            return response()->json($validation->errors(),421);
        }
        $customer->update([
            'name' => $request->name,
            'province_id' => $request->province_id,
            'city_id' => $request->city_id,
            'zone_id' => $request->zone_id,
            'address' => $request->address,
            'tel' => $request->tel,
        ]);
        return response()->json($customer);
    }
}
