<?php

namespace App\Http\Controllers\Api\Customer;

use App\Http\Controllers\Controller;
use App\Models\Auth_Code;
use App\Models\Customer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $validation = Validator::make($request->all(),[
            'phone'=>'required|numeric',
        ]);
        if ($validation->fails()){
            return response()->json($validation->errors(),421);
        }
        $user = Customer::where('phone',$request->phone)->where('is_active',true)->first();
        if (!empty($user)){
            $code = random_int(100000,999999);
            Auth_Code::UpdateorCreate(['phone'=>$request->phone],['code'=>$code]);
            helper_send_auth_sms($user->phone,$code);
            return response()->json($user->phone);
        }
        $user = Customer::create(['phone'=>$request->phone]);
        $user->update(['code' => engine_random_code('2'.$user->id),]);
        $code = random_int(100000,999999);
        Auth_Code::UpdateorCreate(['phone'=>$request->phone],['code'=>$code]);
        helper_send_auth_sms($user->phone,$code);
        return response()->json($user->phone);

    }

    public function login_check(Request $request)
    {
        $validation = Validator::make($request->all(),[
            'code'=>'required|numeric',
            'phone'=>'required|numeric',
        ]);
        if ($validation->fails()){
            return response()->json($validation->errors(),421);
        }
        $find_code = Auth_Code::where("code",$request->code)->where('phone',$request->phone)->first();
        if (!empty($find_code)){
            if (helper_check_auth_sms($find_code->id)) {
                $find_code->delete();
                $user = Customer::where('phone',$request->phone)->first();
                $token = Str::random(120);
                $user->update(['api_token'=>$token]);
                $user = [
                    'name'=>$user->name,
                    'email'=>$user->email,
                    'profile'=>$user->profile,
                    'phone'=>$user->gender
                ];
                return response()->json(['user'=>$user,'access_token'=>$token]);
            }
            $code = random_int(100000,999999);
            $find_code->update(['code'=>$code]);
            helper_send_auth_sms($request->phone,$code);
            return response()->json('مدت زمان ارسال کد به پایان رسیده است، کد تایید جدید برای شما ارسال شد، لطفا آن را وارد کنید',410);

        }
        return response()->json('کد ارسال شده نادرست است',411);

    }
}
