<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Serviceman extends Model
{
    use HasFactory;
    protected $table='servicemans';
    protected $guarded=[];

    public function user()
    {
        return $this->belongsTo(User::class,'user_id');
    }
    public function province()
    {
        return $this->belongsTo(Province::class,'province_id');
    }
    public function city()
    {
        return $this->belongsTo(City::class,'city_id');
    }
    public function accepted()
    {
        return $this->belongsTo(User::class,'accepted_by');
    }
    public function rejected()
    {
        return $this->belongsTo(User::class,'rejected_by');
    }

    public function zones()
    {
        return $this->belongsToMany(Zone::class);
    }



}
