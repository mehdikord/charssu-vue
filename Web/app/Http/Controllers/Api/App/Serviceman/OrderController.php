<?php

namespace App\Http\Controllers\Api\App\Serviceman;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class OrderController extends Controller
{
    public function new()
    {
        $serviceman = api_serviceman_get_user();
        $data = $serviceman->orders()
            ->where('accepted',false)
            ->where('canceled',false)
            ->get();
        return response()->json($data);
    }
}
