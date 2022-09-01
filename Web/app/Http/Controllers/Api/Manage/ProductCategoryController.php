<?php

namespace App\Http\Controllers\Api\Manage;

use App\Http\Controllers\Controller;
use App\Models\Product_Category;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ProductCategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        return response()->json(Product_Category::withCount('products')->get());
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
            'name' => 'required|unique:product_categories|max:225',
        ]);
        if ($validation->fails()){
            return response()->json($validation->errors(),421);
        }
        $result = Product_Category::create([
            'name' => $request->name,
            'description' => $request->description,
        ]);
        return response()->json($result);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Product_Category  $product_Category
     * @return \Illuminate\Http\Response
     */
    public function show(Product_Category $product_Category)
    {

    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Product_Category  $product_Category
     * @return \Illuminate\Http\Response
     */
    public function edit(Product_Category $product_Category)
    {

    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Product_Category  $product_Category
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Request $request, Product_Category $product_category)
    {
        $validation = Validator::make($request->all(),[
            'name' => "required|unique:product_categories,name,$product_category->id|max:225",
        ]);
        if ($validation->fails()){
            return response()->json($validation->errors(),421);
        }
        $product_category->update([
            'name' => $request->name,
            'description' => $request->description,
        ]);
        return response()->json('Updated Successful');

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Product_Category  $product_Category
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy(Product_Category $product_category)
    {
        $product_category->delete();
        return response()->json('Deleted Successful');

    }
}
