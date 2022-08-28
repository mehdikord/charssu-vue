<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    use HasFactory;
    protected $table='orders';
    protected $guarded=[];

    public function customer()
    {
        return $this->belongsTo(Customer::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function province()
    {
        return $this->belongsTo(Province::class);
    }
    public function city()
    {
        return $this->belongsTo(City::class);
    }
    public function zone()
    {
        return $this->belongsTo(Zone::class);
    }
    public function device_brand()
    {
        return $this->belongsTo(Device_Brand::class,'device_brand_id');
    }
    public function device()
    {
        return $this->belongsTo(Device::class,'device_id');
    }
    public function problem()
    {
        return $this->belongsTo(Problem::class);
    }
    public function servicemans()
    {
        return $this->hasMany(Order_Serviceman::class,'order_id');
    }

    public function notes()
    {
        return $this->hasMany(Order_Note::class,'order_id');
    }

}
