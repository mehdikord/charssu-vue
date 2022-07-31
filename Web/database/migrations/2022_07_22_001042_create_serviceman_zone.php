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
        Schema::create('serviceman_zone', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('serviceman_id');
            $table->unsignedBigInteger('zone_id');
            $table->foreign('serviceman_id')->references('id')->on('servicemans')->onUpdate('cascade')->onDelete('cascade');
            $table->foreign('zone_id')->references('id')->on('zones')->onUpdate('cascade')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('serviceman_zone');
    }
};
