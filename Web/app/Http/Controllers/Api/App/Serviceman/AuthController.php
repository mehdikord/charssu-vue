<?php

namespace App\Http\Controllers\Api\App\Serviceman;

use App\Http\Controllers\Controller;
use App\Models\Auth_Code;
use App\Models\Serviceman;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    public function auth(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'phone' => 'required|numeric',
        ]);
        if ($validator->fails()) {
            return response()->json($validator->errors(),422);
        }
        if (Auth_Code::where('phone',$request->phone)->exists() && helper_check_auth_sms(Auth_Code::where('phone',$request->phone)->first()->id)){
            return response()->json(['error'=>'کد ارسال شده قبلی تا دو دقیقه معتبر است !'],409);
        }
        //send auth code with sms to phone number
        $code = random_int(100000,999999);
        Auth_Code::UpdateOrCreate(['phone'=>$request->phone],['code'=>$code]);
        helper_send_auth_sms($request->phone,$code);
        return response()->json(['message'=>'کد تایید باموفقیت ارسال شد','status'=>200],200);

    }

    public function auth_check(Request $request): \Illuminate\Http\JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'phone' => 'required|numeric',
            'code' => 'required|numeric',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors'=>$validator->errors(),'status'=>422],422);
        }
        $auth_code = Auth_Code::where('phone',$request->phone)->where('code',$request->code)->first();
        if (!empty($auth_code)){
            if (helper_check_auth_sms($auth_code->id)){
                $serviceman = Serviceman::where('phone',$request->phone)->first();
                if (!empty($serviceman)){
                    $auth_code->delete();
                    //update api token
                    $serviceman->update(['api_token'=>token_creator($serviceman->id)]);
                    $serviceman = Serviceman::find($serviceman->id);
                    return response()->json(['response'=>$serviceman,'status'=>200]);
                }
                $serviceman = Serviceman::create([
                    'phone'=>$request->phone,
                ]);
                $auth_code->delete();
                $serviceman->update(['api_token'=>token_creator($serviceman->id)]);
                $serviceman = Serviceman::find($serviceman->id);
                return response()->json(['response'=>$serviceman,'status'=>200],200);
            }
            $auth_code->delete();
            return response()->json(['error'=>'مدت زمان ارسال کد به پایان رسیده','status'=>409],409);
        }
        return response()->json(['error'=>'کد ارسال شده نادرست است','status'=>409],409);
    }


}
