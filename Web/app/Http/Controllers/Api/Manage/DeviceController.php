<?php

namespace App\Http\Controllers\Api\Manage;

use App\Http\Controllers\Controller;
use App\Models\Device;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;

class DeviceController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        return response()->json(Device::with('brand')->get());
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
        $request->merge(['device_code' => str_replace(' ','-',$request->device_code)]);
        $validation = Validator::make($request->all(),[
            'name' => 'required',
            'device_code' => 'required|unique:devices',
            'image' => 'nullable|image'
        ]);
        if ($validation->fails()){
            return response()->json($validation->errors(),421);
        }
        $image_url=null;
        if ($request->hasFile('image')){
            $image = Storage::put('public/devices/',$request->file('image'));
            $image_url = asset(Storage::url($image));
        }

        $result = Device::create([
            'name' => $request->name,
            'device_brand_id' => $request->device_brand_id,
            'device_code' => $request->device_code,
            'description' => $request->description,
            'image' => $image_url,
        ]);
        $result->update(['code'=>engine_random_code('3'.$result->id)]);
        $result = Device::with('brand')->find($result->id);
        return response()->json($result);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Device  $device
     * @return \Illuminate\Http\Response
     */
    public function show(Device $device)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Device  $device
     * @return \Illuminate\Http\Response
     */
    public function edit(Device $device)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Device  $device
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Request $request, Device $device)
    {
        $request->merge(['device_code' => str_replace(' ','-',$request->device_code)]);
        $validation = Validator::make($request->all(),[
            'name' => 'required',
            'device_code' => "required|unique:devices,device_code,$device->id",
            'image' => 'nullable|image'
        ]);
        if ($validation->fails()){
            return response()->json($validation->errors(),421);
        }
        $image_url=$device->image;
        if ($request->hasFile('image')){
            $image = Storage::put('public/devices/',$request->file('image'));
            $image_url = asset(Storage::url($image));
        }
        $device->update([
            'name' => $request->name,
            'device_brand_id' => $request->device_brand_id,
            'device_code' => $request->device_code,
            'description' => $request->description,
            'image' => $image_url
        ]);

        return response()->json('Updated Successful');

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Device  $device
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy(Device $device)
    {
        $device->delete();
        return response()->json('Deleted Successful');

    }
}
