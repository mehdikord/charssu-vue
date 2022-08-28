<?php

//get auth customer
function customer_auth_get(){

    return \App\Models\Customer::where('api_token',request()->header('Authorization'))->with(['province','city','zone'])->first();
}
