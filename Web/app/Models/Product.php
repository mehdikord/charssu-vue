<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;
    protected $table='products';
    protected $guarded=[];

    public function category()
    {
        return $this->belongsTo(Product_Category::class,'product_category_id');
    }

    public function brand()
    {
        return $this->belongsTo(Device_Brand::class,'device_brand_id');

    }

    public function device()
    {
        return $this->belongsTo(Device::class,'device_id');

    }

    public function images()
    {
        return $this->hasMany(Product_Image::class,'product_id');
    }

    public function orders()
    {
        return $this->hasMany(Order_Product::class,'product_id');
    }


}
