<?php

function manage_auth_get(){
    return \App\Models\User::where('api_token',request()->header('Authorization'))->first();

}
