<?php

namespace App\Http\Controllers\Api\App\Serviceman;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;

class ProfileController extends Controller
{
    public function get_profile(): \Illuminate\Http\JsonResponse
    {
        return response()->json(['response'=>api_serviceman_get_user(),'status'=>200]);
    }

    public function update_profile(Request $request)
    {
        $serviceman = api_serviceman_get_user();
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:225|min:3',
            'province_id' => 'required|exists:provinces,id',
            'city_id' => 'required|exists:cities,id',
            'national_code'=>"required|unique:servicemans,national_code,$serviceman->id",
            'email'=>"nullable|email|unique:servicemans,email,$serviceman->id",
            'tel'=>"nullable|unique:servicemans,tel,$serviceman->id",
            'birthday'=>"required",
            'address'=>'required',
            'start_time'=>"required",
            'end_time'=>"required",
            'brands'=>'nullable|array',
            'zones'=>'nullable|array',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors'=>$validator->errors(),'status'=>422],422);
        }

        $technical_license=$serviceman->technical_license;
        $police_certificate=$serviceman->police_certificate;
        $non_addictions=$serviceman->non_addictions;
        $profile_url=$serviceman->profile;
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


        $serviceman->update([
            'province_id'=>$request->province_id,
            'city_id'=>$request->city_id,
            'name'=>$request->name,
            'email'=>$request->email,
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
        ]);
        $brands = [];
        $zones = [];

        $serviceman->brands()->sync($brands);
        $serviceman->zones()->sync($zones);
        //get serviceman data after update
        $serviceman = api_serviceman_get_user();
        return response()->json(['message'=>'اطلاعات پروفایل باموفقیت ویرایش شد','serviceman'=>$serviceman,'status'=>200]);

    }


    public function activation()
    {
        $serviceman = api_serviceman_get_user();
        if ($serviceman->is_online == 1){
            $serviceman->update(['is_online'=>0]);
            $serviceman->activities()->create(['active'=>0]);
            $response = ['activation'=>0,'message'=>'وضعیت درحالت غیرفعال قرار گرفت'];

        }else{
            $serviceman->update(['is_online'=>1]);
            $serviceman->activities()->create(['active'=>1]);
            $response = ['activation'=>1,'message'=>'وضعیت درحالت فعال قرار گرفت'];

        }
        return response()->json(['response'=>$response,'status'=>200]);

    }

}
