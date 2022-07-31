<?php

namespace App\Http\Controllers\Api\Manage;

use App\Http\Controllers\Controller;
use App\Models\Zone;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Validator;

class ZoneController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {

        return response()->json(Zone::with('city')->with('province')->get());

    }

    /**
     * Show the form for creating a new resource.
     *
     * @return Response
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
            'name' => 'required',
            'province_id' => 'required|numeric',
            'city_id' => 'required|numeric',
        ]);
        if ($validation->fails()){
            return response()->json($validation->errors(),421);
        }

        $result = Zone::create([
            'province_id'=>$request->province_id,
            'city_id'=>$request->city_id,
            'name'=>$request->name,
        ]);

        return response()->json(Zone::with('province')->with('city')->find($result->id));

    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Zone  $zone
     * @return Response
     */
    public function show(Zone $zone)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Zone  $zone
     * @return Response
     */
    public function edit(Zone $zone)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Zone  $zone
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Request $request, Zone $zone)
    {
        $validation = Validator::make($request->all(),[
            'name' => 'required',
            'province_id' => 'required|numeric',
            'city_id' => 'required|numeric',
        ]);
        if ($validation->fails()){
            return response()->json($validation->errors(),421);
        }
        $zone->update([
            'province_id'=>$request->province_id,
            'city_id'=>$request->city_id,
            'name'=>$request->name,
        ]);
        return response()->json('Updated Successful');

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Zone  $zone
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy(Zone $zone)
    {
        $zone->delete();
        return response()->json('Delete Successful');

    }
}
