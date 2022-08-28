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
        Schema::create('order_servicemans', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('order_id');
            $table->unsignedBigInteger('serviceman_id')->nullable();
            $table->boolean('accepted')->default(0);
            $table->timestamp('accepted_at')->nullable();
            $table->boolean('canceled')->default(0);
            $table->longText('cancel_reason')->nullable();
            $table->timestamp('canceled_at')->nullable();
            $table->timestamps();
            $table->foreign('order_id')->references('id')->on('orders')->onUpdate('cascade')->onDelete('cascade');
            $table->foreign('serviceman_id')->references('id')->on('servicemans')->onUpdate('cascade')->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('order_servicemans');
    }
};
