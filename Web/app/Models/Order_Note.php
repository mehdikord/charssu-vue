<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Order_Note extends Model
{
    use HasFactory;
    protected $table='order_notes';
    protected $guarded=[];

    public function serviceman()
    {
        return $this->belongsTo(Serviceman::class,'serviceman_id');
    }

    public function order()
    {
     return $this->belongsTo(Order::class);
    }
}
