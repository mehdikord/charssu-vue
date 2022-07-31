<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Zone extends Model
{
    use HasFactory;

    protected $table='zones';
    protected $guarded=[];
    public function city()
    {
        return $this->belongsTo(City::class,'city_id');
    }

    public function province()
    {
        return $this->belongsTo(Province::class,'province_id');
    }
}
