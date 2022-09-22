<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('order_invoices', function (Blueprint $table) {
            $table->string('ref_id')->nullable()->after('paid_at');
            $table->string('pay_id')->nullable()->after('ref_id');
            $table->string('gateway')->nullable()->after('pay_id');
            $table->enum('method',['online','card','manage'])->default('online')->after('gateway');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('order_invoices', function (Blueprint $table) {
            //
        });
    }
};
