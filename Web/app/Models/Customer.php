<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Customer extends Model
{
    use HasFactory;
    protected $table='customers';
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
    public function zone()
    {
        return $this->belongsTo(Zone::class,'zone_id');
    }

    public function orders()
    {
        return $this->hasMany(Order::class,'customer_id');
    }


}
