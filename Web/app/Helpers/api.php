<?php
 use App\Models\Serviceman;
 use Illuminate\Support\Str;

//create token string with unique id for users
function token_creator($unique) :string
{
    return Str::random(5).$unique.Str::random(122);
}

//serviceman get user info
function api_serviceman_get_user()
{
    return Serviceman::where('api_token',request()->header('Authorization'))->with(['province','city','brands','zones'])->first();
}

//set serviceman to order
function api_order_set_serviceman($order_id){


}

