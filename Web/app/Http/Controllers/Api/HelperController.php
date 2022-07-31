<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Province;
use Illuminate\Http\Request;

class HelperController extends Controller
{
    public function get_provinces(): \Illuminate\Http\JsonResponse
    {
        return response()->json(Province::whereIn('id',[8,32])->with('cities')->with('cities.zones')->get());
    }
}
