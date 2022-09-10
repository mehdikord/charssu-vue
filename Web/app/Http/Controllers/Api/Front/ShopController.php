<?php

namespace App\Http\Controllers\Api\Front;

use App\Http\Controllers\Controller;
use App\Models\Product;
use App\Models\Product_Category;
use Illuminate\Http\Request;

class ShopController extends Controller
{
    public function categories()
    {
        return response()->json(Product_Category::all());
    }

    public function products(Request $request)
    {
        $data = Product::query();
        $data->where('is_active',true);
        $data->with('images');
        $data->with('category');

        if ($request->filled('category')){
            $data->where('product_category_id',$request->category);
        }

        if ($request->filled('device_brand')){
            $data->where('device_brand_id',$request->device_brand);
        }

        if ($request->filled('search_name')){
            $data->where('name','LIKE','%'.$request->search_name.'%' );
        }

        return response()->json($data->orderByDesc('id')->get());
    }

    public function single_product($code)
    {
        $product = Product::where('code',$code)->where('is_active',true)
            ->with("images")
            ->with('category')
            ->with('brand')
            ->firstorfail();
        return response()->json($product);

    }
}
