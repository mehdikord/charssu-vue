<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\City;
use App\Models\Device_Brand;
use App\Models\Problem;
use App\Models\Province;
use App\Models\Zone;
use Illuminate\Http\Request;

class HelperController extends Controller
{
    public function get_provinces(): \Illuminate\Http\JsonResponse
    {
        return response()->json(Province::whereIn('id',[8,32])->with('cities')->with('cities.zones')->get());
    }

    public function get_brands()
    {
        return response()->json(Device_Brand::with('devices')->get());
    }

    public function get_zones()
    {
        return response()->json(Zone::all());
    }

    public function get_problems()
    {
        return response()->json(Problem::all());

    }

    public function install_zone()
    {
        foreach (City::all() as $city){
            $provicne_id = $city->province_id;
            $city->zones()->updateorcreate(['name' => 'منطقه ۱'],['province_id' => $provicne_id]);
        }
        return response()->json('done');

    }
}
