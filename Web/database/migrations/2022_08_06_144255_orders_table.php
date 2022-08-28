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
        Schema::create('orders', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('customer_id')->nullable();
            $table->unsignedBigInteger('user_id')->nullable();
            $table->unsignedBigInteger('province_id')->nullable();
            $table->unsignedBigInteger('city_id')->nullable();
            $table->unsignedBigInteger('zone_id')->nullable();
            $table->unsignedBigInteger('device_brand_id')->nullable();
            $table->unsignedBigInteger('device_id')->nullable();
            $table->unsignedBigInteger('problem_id')->nullable();
            $table->string('title')->nullable();
            $table->string('warranty')->nullable();
            $table->string('warranty_date')->nullable();
            $table->string('image')->nullable();
            $table->longText('description')->nullable();
            $table->string('code')->nullable();
            $table->string('start_at')->nullable();
            $table->string('end_at')->nullable();
            $table->string('rate')->nullable();
            $table->boolean('is_active')->default(1);
            $table->boolean('is_done')->default(0);
            $table->timestamps();
            $table->foreign('customer_id')->references('id')->on('customers')->onDelete('set null')->onUpdate('cascade');
            $table->foreign('user_id')->references('id')->on('users')->onDelete('set null')->onUpdate('cascade');
            $table->foreign('province_id')->references('id')->on('provinces')->onDelete('set null')->onUpdate('cascade');
            $table->foreign('city_id')->references('id')->on('cities')->onDelete('set null')->onUpdate('cascade');
            $table->foreign('zone_id')->references('id')->on('zones')->onDelete('set null')->onUpdate('cascade');
            $table->foreign('device_brand_id')->references('id')->on('device_brands')->onDelete('set null')->onUpdate('cascade');
            $table->foreign('device_id')->references('id')->on('devices')->onDelete('set null')->onUpdate('cascade');
            $table->foreign('problem_id')->references('id')->on('problems')->onDelete('set null')->onUpdate('cascade');

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('orders');
    }
};
