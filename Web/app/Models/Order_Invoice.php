<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Order_Invoice extends Model
{
    use HasFactory;
    protected $table='order_invoices';
    protected $guarded=[];

    public function order()
    {
        return $this->belongsTo(Order::class.'order_id');
    }

    public function details()
    {
        return $this->hasMany(Invoice_Detail::class,'order_invoice_id');
    }
}
