<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Order_Product extends Model
{
    use HasFactory;
    protected $table='order_products';
    protected $guarded=[];

    public function order()
    {
        return $this->belongsTo(Order::class,'order_id');
    }

    public function products()
    {
        return $this->belongsTo(Product::class,'product_id');
    }

    public function serviceman()
    {
        return $this->belongsTo(Serviceman::class,'serviceman_id');
    }
}
