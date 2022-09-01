<?php

namespace App\Http\Controllers\Api\Manage;

use App\Http\Controllers\Controller;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ProductController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        return response()->json(Product::all());
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
            'product_category_id' => 'nullable|exists:product_categories,id',
            'device_brand' => 'nullable|exists:device_brands,id',
            'device_id' => 'nullable|exists:device_id,id',
            'name' => 'required|max:225',
            'price' => 'required|numeric|min:1',
            'sale' => 'nullable|numeric|min:1',
            'serviceman_price' => 'required|numeric|min:1',
            'quantity' => 'required|numeric',
        ]);
        if ($validation->fails()){
            return response()->json($validation->errors(),421);
        }
        $result = Product::create([
            'user_id' => manage_auth_get()->id,
            'product_category_id' => $request->product_category_id,
            'device_brand' => $request->device_brand,
            'device_id' => $request->device_id,
            'name' => $request->name,
            'product_code' => $request->product_code,
            'price' => $request->price,
            'sale' => $request->sale,
            'serviceman_price' => $request->serviceman_price,
            'quantity' => $request->quantity,
            'description' => $request->description,
            'is_active' => true,
        ]);
        $result->update([
            'code' => engine_random_code($result->id),
        ]);
        return response()->json($result);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Product  $product
     * @return \Illuminate\Http\Response
     */
    public function show(Product $product)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Product  $product
     * @return \Illuminate\Http\Response
     */
    public function edit(Product $product)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Product  $product
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Request $request, Product $product)
    {
        $validation = Validator::make($request->all(),[
            'product_category_id' => 'nullable|exists:product_categories,id',
            'device_brand' => 'nullable|exists:device_brands,id',
            'device_id' => 'nullable|exists:device_id,id',
            'name' => 'required|max:225',
            'price' => 'required|numeric|min:1',
            'sale' => 'nullable|numeric|min:1',
            'serviceman_price' => 'required|numeric|min:1',
            'quantity' => 'required|numeric',
        ]);
        if ($validation->fails()){
            return response()->json($validation->errors(),421);
        }
        $product->update([
            'product_category_id' => $request->product_category_id,
            'device_brand' => $request->device_brand,
            'device_id' => $request->device_id,
            'name' => $request->name,
            'product_code' => $request->product_code,
            'price' => $request->price,
            'sale' => $request->sale,
            'serviceman_price' => $request->serviceman_price,
            'quantity' => $request->quantity,
            'description' => $request->description,
        ]);
        return response()->json('Updated Successful');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Product  $product
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy(Product $product)
    {
        $product->delete();
        return response()->json('Deleted Successful');

    }
}
