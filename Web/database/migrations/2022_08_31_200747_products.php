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
        Schema::create('products', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id')->nullable();
            $table->unsignedBigInteger('product_category_id')->nullable();
            $table->unsignedBigInteger('device_brand_id')->nullable();
            $table->unsignedBigInteger('device_id')->nullable();
            $table->string('name')->nullable();
            $table->string('product_code')->nullable();
            $table->string('code')->nullable();
            $table->string('price')->nullable();
            $table->string('sale')->nullable();
            $table->string('serviceman_price')->nullable();
            $table->longText('description')->nullable();
            $table->string('quantity')->default(0);
            $table->boolean('is_active')->default(1);
            $table->timestamps();
            $table->foreign('user_id')->references('id')->on('users')->onUpdate('cascade')->onDelete('set null');
            $table->foreign('product_category_id')->references('id')->on('product_categories')->onUpdate('cascade')->onDelete('set null');
            $table->foreign('device_brand_id')->references('id')->on('device_brands')->onUpdate('cascade')->onDelete('set null');
            $table->foreign('device_id')->references('id')->on('devices')->onUpdate('cascade')->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('products');
    }
};
