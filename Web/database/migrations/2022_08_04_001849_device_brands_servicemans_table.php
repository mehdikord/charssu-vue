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
        Schema::create('device_brands_servicemans', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('device_brand_id');
            $table->unsignedBigInteger('serviceman_id');
            $table->foreign('device_brand_id')->references('id')->on('device_brands')->onUpdate('cascade')->onDelete('cascade');
            $table->foreign('serviceman_id')->references('id')->on('servicemans')->onUpdate('cascade')->onDelete('cascade');


        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('device_brands_servicemans');
    }
};
