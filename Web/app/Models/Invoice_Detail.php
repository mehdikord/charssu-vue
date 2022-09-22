<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Invoice_Detail extends Model
{
    use HasFactory;
    protected $table='invoice_details';
    protected $guarded=[];

    public function invoice()
    {
        return $this->belongsTo(Order_Invoice::class,'order_invoice_id');
    }
}
