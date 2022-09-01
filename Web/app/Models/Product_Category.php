<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product_Category extends Model
{
    use HasFactory;
    protected $table='product_categories';
    protected $guarded=[];

    public function products()
    {
        return $this->hasMany(Product::class,'product_category_id');
    }
}
