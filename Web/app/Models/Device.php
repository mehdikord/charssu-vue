<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Device extends Model
{
    use HasFactory;
    protected $table='devices';
    protected $guarded=[];

    public function brand()
    {
        return $this->belongsTo(Device_Brand::class,'device_brand_id');
    }
}
