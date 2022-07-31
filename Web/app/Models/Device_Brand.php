<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Device_Brand extends Model
{
    use HasFactory;
    protected $table='device_brands';
    protected $guarded=[];

    public function devices()
    {
        return $this->hasMany(Device::class,'device_brand_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class,'user_id');
    }
}
