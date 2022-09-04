<?php

namespace App\Http\Controllers\Api\Manage;

use App\Http\Controllers\Controller;
use App\Models\Product;
use App\Models\Product_Image;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
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
        return response()->json(Product::with('category')->with('brand')->with('device')->with('images')->get());
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
            'device_brand_id' => 'nullable|exists:device_brands,id',
            'device_id' => 'nullable|exists:device_id,id',
            'name' => 'required|max:225',
            'product_code' => 'nullable|unique:products|max:225',
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
            'device_brand_id' => $request->device_brand_id,
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
        $result->load(['category','brand','device']);
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
            'device_brand_id' => 'nullable|exists:device_brands,id',
            'device_id' => 'nullable|exists:device_id,id',
            'product_code' => "nullable|unique:products,product_code,$product->id|max:225",
            'name' => 'required|max:225',
            'price' => 'required|numeric|min:1',
            'sale' => 'nullable|numeric|min:1',
            'serviceman_price' => 'required|numeric|min:1',
        ]);
        if ($validation->fails()){
            return response()->json($validation->errors(),421);
        }
        $product->update([
            'product_category_id' => $request->product_category_id,
            'device_brand_id' => $request->device_brand_id,
            'device_id' => $request->device_id,
            'name' => $request->name,
            'product_code' => $request->product_code,
            'price' => $request->price,
            'sale' => $request->sale,
            'serviceman_price' => $request->serviceman_price,
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

    public function images(Product $product)
    {
        return response()->json($product->images);
    }

    public function images_store(Request $request,Product $product)
    {
        $validation = Validator::make($request->all(),[
            'image' => 'required|image',
        ]);
        if ($validation->fails()){
            return response()->json($validation->errors(),421);
        }
        $image = null;
        $image_file = null;
        if ($request->hasFile('image')){
            $image_file = Storage::put('public/products/images',$request->file('image'));
            $image = asset(Storage::url($image_file));
        }
        $result = $product->images()->create([
            'image' => $image,
            'image_file' => $image_file
        ]);
        return response()->json($result);
    }

    public function images_delete(Product_Image $image)
    {
        Storage::delete($image->image_file);
        $image->delete();
        return response()->json('Deleted Successful');

    }
}
