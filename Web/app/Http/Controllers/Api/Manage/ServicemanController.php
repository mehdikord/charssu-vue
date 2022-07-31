<?php

namespace App\Http\Controllers\Api\Manage;

use App\Http\Controllers\Controller;
use App\Models\Serviceman;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;

class ServicemanController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        return response()->json(Serviceman::with('user')
            ->with('province')
            ->with('city')
            ->with('zones')
            ->get()
        );

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
            'zones' => 'nullable|array',
            'profile'=>'nullable|image',
            'name' => 'required|min:3|max:225',
            'national_code'=>'required|numeric|unique:servicemans',
            'phone'=>'required|numeric|unique:servicemans',
            'birthday'=>"required",
            'address'=>"required",
            'start_time'=>"required",
            'end_time'=>"required",
        ]);
        if ($validation->fails()){
            return response()->json($validation->errors(),421);
        }
        $technical_license=null;
        $police_certificate=null;
        $non_addictions=null;
        $profile_url=null;
        if ($request->hasFile('technical_license')){
            $technical_license = Storage::put('private/servicemans/docs',$request->file('technical_license'));
        }
        if ($request->hasFile('police_certificate')){
            $police_certificate = Storage::put('private/servicemans/docs',$request->file('police_certificate'));
        }
        if ($request->hasFile('non_addictions')){
            $non_addictions = Storage::put('private/servicemans/docs',$request->file('non_addictions'));
        }
        if ($request->hasFile('profile')){
            $profile = Storage::put('public/servicemans/profile',$request->file('profile'));
            $profile_url = asset(Storage::url($profile));
        }
        //#TODO
        $result = Serviceman::create([
            'user_id'=>null,
            'province_id'=>$request->province_id,
            'city_id'=>$request->city_id,
            'name'=>$request->name,
            'phone'=>$request->phone,
            'national_code'=>$request->national_code,
            'birthday'=>$request->birthday,
            'address'=>$request->address,
            'work_address'=>$request->work_address,
            'tel'=>$request->tel,
            'start_time'=>$request->start_time,
            'end_time'=>$request->end_time,
            'technical_license'=>$technical_license,
            'police_certificate'=>$police_certificate,
            'non_addictions'=>$non_addictions,
            'profile'=>$profile_url,
            'is_accepted' => 1,

        ]);
        //generate code
        $result->update(['code'=>engine_random_code('1'.$result->id)]);

        //sync zones
        if ($request->filled('zones') && count($request->zones)){
            $result->zones()->sync($request->zones);
        }
        return response()->json('Create Successful');
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Serviceman  $serviceman
     *
     */
    public function show(Serviceman $serviceman)
    {
        return response()->json(Serviceman::with('zones')->find($serviceman->id));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Serviceman  $serviceman
     * @return \Illuminate\Http\Response
     */
    public function edit(Serviceman $serviceman)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Serviceman  $serviceman
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Serviceman $serviceman)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Serviceman  $serviceman
     * @return \Illuminate\Http\Response
     */
    public function destroy(Serviceman $serviceman)
    {
        //
    }
}
