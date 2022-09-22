<?php

namespace App\Http\Controllers\Api\Manage;

use App\Http\Controllers\Controller;
use App\Models\Cost;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class CostController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        return response()->json(Cost::all());
    }



    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {
        $validation = Validator::make($request->all(),[
            'title' => 'required|unique:costs|max:225',
            'price' => 'required|numeric|min:1000',
        ]);
        if ($validation->fails()){
            return response()->json($validation->errors(),421);
        }
        $result = Cost::create([
            'title' => $request->title,
            'price' => $request->price,
            'is_active' => 0,
        ]);
        return response()->json($result);
    }


    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Cost  $cost
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Request $request, Cost $cost)
    {

        $validation = Validator::make($request->all(),[
            'title' => "required|unique:costs,title,$cost->id|max:225",
            'price' => 'required|numeric|min:1000',
        ]);

        if ($validation->fails()){
            return response()->json($validation->errors(),421);
        }
        $cost->update([
            'title' => $request->title,
            'price' => $request->price,
        ]);

        return response()->json('Updated Successful');

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Cost  $cost
     * @return \Illuminate\Http\Response
     */
    public function destroy(Cost $cost)
    {
        $cost->delete();

        return response()->json('Deleted Successful');

    }
}
