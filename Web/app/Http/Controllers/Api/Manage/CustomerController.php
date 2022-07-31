<?php

namespace App\Http\Controllers\Api\Manage;

use App\Http\Controllers\Controller;
use App\Models\Customer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class CustomerController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        return response()->json(Customer::with('user')->with('province')->with('city')->with('zone')->get());
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {

        $validation = Validator::make($request->all(),[
            'province_id' => 'required|numeric',
            'city_id' => 'required|numeric',
            'zone_id' => 'required|numeric',
            'name' => 'required',
            'phone' => 'required|numeric|unique:customers',
        ]);
        if ($validation->fails()){
            return response()->json($validation->errors(),421);
        }
        //#TODO
        $result = Customer::create([
            'user_id' => null,
            'province_id'=>$request->province_id,
            'city_id'=>$request->city_id,
            'zone_id'=>$request->zone_id,
            'name'=>$request->name,
            'phone'=>$request->phone,
            'address'=>$request->address,
            'tel'=>$request->address,
        ]);
        //generate code
        $result->update([
            'code' => engine_random_code('2'.$result->id),
        ]);
        return response()->json(Customer::with('user')->with('province')->with('city')->with('zone')->find($result->id));
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Customer  $customer
     * @return \Illuminate\Http\Response
     */
    public function show(Customer $customer)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Customer  $customer
     * @return \Illuminate\Http\Response
     */
    public function edit(Customer $customer)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Customer  $customer
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Request $request, Customer $customer)
    {
        $validation = Validator::make($request->all(),[
            'province_id' => 'required|numeric',
            'city_id' => 'required|numeric',
            'zone_id' => 'required|numeric',
            'name' => 'required',
            'phone' => "required|numeric|unique:customers,phone,$customer->id",
        ]);
        if ($validation->fails()){
            return response()->json($validation->errors(),421);
        }
        $customer->update([
            'province_id'=>$request->province_id,
            'city_id'=>$request->city_id,
            'zone_id'=>$request->zone_id,
            'name'=>$request->name,
            'phone'=>$request->phone,
            'address'=>$request->address,
            'tel'=>$request->address,
        ]);

        return response()->json('Updated Successful');

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Customer  $customer
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy(Customer $customer)
    {
        $customer->delete();
        return response()->json('Delete Successful');

    }

    public function activation(Customer $customer)
    {
        if ($customer->is_active == 1){
            $customer->update(['is_active'=>0]);
            $message = 'حساب مشتری باموفقیت غیرفعال شد';
        }else{
            $customer->update(['is_active'=>1]);
            $message = 'حساب مشتری باموفقیت فعال شد';
        }
        return response()->json($message);
    }
}
