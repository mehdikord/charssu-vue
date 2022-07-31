<?php

namespace App\Http\Controllers\Api\Manage;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(): \Illuminate\Http\JsonResponse
    {
        return response()->json(User::all());
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
            'name' => 'required',
            'phone' => 'required|unique:users',
            'national_code' => 'required|unique:users',
            'email' => 'nullable|email|unique:users',
            'role' => 'required|numeric',
        ]);
        if ($validation->fails()){
            return response()->json($validation->errors(),421);
        }
        $result = User::create([
            'role' => $request->role,
            'name' => $request->name,
            'phone' => $request->phone,
            'national_code' => $request->national_code,
            'email' => $request->email,
            'is_active' => 1,
        ]);

        return response()->json($result);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\User  $user
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(User $user)
    {
        //
    }


    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\User  $user
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Request $request, User $user)
    {
        $validation = Validator::make($request->all(),[
            'name' => 'required',
            'phone' => "required|unique:users,phone,$user->id",
            'national_code' => "required|unique:users,national_code,$user->id",
            'email' => "nullable|email|unique:users,email,$user->id",
            'role' => 'required|numeric',
        ]);
        if ($validation->fails()){
            return response()->json($validation->errors(),421);
        }
        $user->update([
            'role' => $request->role,
            'name' => $request->name,
            'phone' => $request->phone,
            'national_code' => $request->national_code,
            'email' => $request->email,
        ]);
        return response()->json('Updated Successful');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\User  $user
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy(User $user)
    {
        $user->delete();
        return response()->json('Deleted Successful');
    }

    public function activation(User $user)
    {
        if ($user->is_active == 1){
            $user->update(['is_active'=>0]);
            $message = 'حساب کاربر باموفقیت غیرفعال شد';
        }else{
            $user->update(['is_active'=>1]);
            $message = 'حساب کاربر باموفقیت فعال شد';
        }
        return response()->json($message);
    }
}
