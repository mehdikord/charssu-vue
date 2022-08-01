<?php

namespace App\Http\Controllers\Api\Manage;

use App\Http\Controllers\Controller;
use App\Models\Device_Brand;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;

class DeviceBrandController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        return response()->json(Device_Brand::withCount('devices')->get());
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {

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
            'name' => 'required|unique:device_brands',
            'image' => 'nullable|image'
        ]);
        if ($validation->fails()){
            return response()->json($validation->errors(),421);
        }
        $image_url=null;
        if ($request->hasFile('image')){
            $image = Storage::put('public/devices-brands/',$request->file('image'));
            $image_url = asset(Storage::url($image));
        }

        $result = Device_Brand::create([
            'name' => $request->name,
            'description' => $request->description,
            'image' => $image_url,
        ]);

        return response()->json($result);

    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Device_Brand  $device_Brand
     * @return \Illuminate\Http\Response
     */
    public function show(Device_Brand $device_Brand)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Device_Brand  $device_Brand
     * @return \Illuminate\Http\Response
     */
    public function edit(Device_Brand $device_Brand)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Device_Brand  $device_Brand
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Request $request, Device_Brand $device_Brand)
    {
        $validation = Validator::make($request->all(),[
            'name' => "required|unique:device_brands,name,$device_Brand->id",
            'image' => 'nullable|image'
        ]);
        if ($validation->fails()){
            return response()->json($validation->errors(),421);
        }
        $image_url=$device_Brand->image;
        if ($request->hasFile('profile')){
            $image = Storage::put('public/devices-brands/',$request->file('image'));
            $image_url = asset(Storage::url($image));
        }
        $device_Brand->update([
            'name' => $request->name,
            'description' => $request->description,
            'image' => $image_url,
        ]);
        return response()->json('Updated Successful');

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Device_Brand  $device_Brand
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy(Device_Brand $device_Brand)
    {
        $device_Brand->forceDelete();
        return response()->json('Deleted Successful');
    }
}
