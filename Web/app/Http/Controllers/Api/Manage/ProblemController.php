<?php

namespace App\Http\Controllers\Api\Manage;

use App\Http\Controllers\Controller;
use App\Models\Problem;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ProblemController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        return response()->json(Problem::all());
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
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
            'problem' => 'required|unique:problems',
            'price' => 'required|numeric|min:1000',
        ]);
        if ($validation->fails()){
            return response()->json($validation->errors(),421);
        }
        $result = Problem::create([
            'problem' => $request->problem,
            'price' => $request->price,
        ]);
        return  response()->json($result);

    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Problem  $problem
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(Problem $problem)
    {


    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Problem  $problem
     * @return \Illuminate\Http\Response
     */
    public function edit(Problem $problem)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Problem  $problem
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Request $request, Problem $problem)
    {
        $validation = Validator::make($request->all(),[
            'problem' => "required|unique:problems,problem,$problem->id",
            'price' => 'required|numeric|min:1000',
        ]);
        if ($validation->fails()){
            return response()->json($validation->errors(),421);
        }
        $problem->update(['problem'=>$request->problem,'price'=>$request->price]);
        return response()->json('Updated Successful');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Problem  $problem
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy(Problem $problem)
    {
        $problem->delete();
        return response()->json('Deleted Successful');

    }
}
