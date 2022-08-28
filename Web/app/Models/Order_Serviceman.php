<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Order_Serviceman extends Model
{
    use HasFactory;
    protected $table='order_servicemans';
    protected $guarded=[];

    public function order()
    {
        return $this->belongsTo(Order::class);
    }

    public function serviceman()
    {
        return $this->belongsTo(Serviceman::class,'serviceman_id');
    }
}
