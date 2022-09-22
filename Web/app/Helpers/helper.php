<?php
use Kavenegar\Laravel\Facade as Kavenegar;
//send auth sms
function helper_send_auth_sms($phone,$code)
{
    if (env('APP_ENV') != 'local'){
        $req = new \GuzzleHttp\Client();
        $req->get("https://api.kavenegar.com/v1/307175483364594348624B776E2B313465525579445874386B736B4F514B556875792B58684C4D6B5779773D/verify/lookup.json?receptor=$phone&token=$code&template=charsuu-verification");
    }
}

//send custom sms
function helper_send_sms($phone,$message){

    try{
        $sender = "";

        $receptor = array($phone);

        $result = Kavenegar::Send($sender,$receptor,$message);
        if($result){


        }
    }
    catch(\Kavenegar\Exceptions\ApiException $e){
        // در صورتی که خروجی وب سرویس 200 نباشد این خطا رخ می دهد
        echo $e->errorMessage();
    }
    catch(\Kavenegar\Exceptions\HttpException $e){
        // در زمانی که مشکلی در برقرای ارتباط با وب سرویس وجود داشته باشد این خطا رخ می دهد
        echo $e->errorMessage();
    }

}


//check auth sms time
function helper_check_auth_sms($auth_code_id): bool
{
    $auth_code = \App\Models\Auth_Code::find($auth_code_id);
    if (!empty($auth_code)){
        $now_time = \Carbon\Carbon::now();
        return !($now_time->diffInMinutes($auth_code->updated_at) >= 2);
    }return false;
}
