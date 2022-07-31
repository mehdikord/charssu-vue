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
        Schema::create('servicemans', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id')->nullable();
            $table->unsignedBigInteger('province_id')->nullable();
            $table->unsignedBigInteger('city_id')->nullable();
            $table->string('name')->nullable();
            $table->string('phone')->nullable();
            $table->string('national_code')->nullable();
            $table->string('birthday')->nullable();
            $table->string('address')->nullable();
            $table->string('work_address')->nullable();
            $table->string('tel')->nullable();
            $table->string('technical_license')->nullable();
            $table->string('police_certificate')->nullable();
            $table->string('non_addictions')->nullable();
            $table->string('start_time')->nullable();
            $table->string('end_time')->nullable();
            $table->string('code')->nullable();
            $table->string('profile')->nullable();
            $table->boolean('is_accepted')->default(0);
            $table->unsignedBigInteger('accepted_by')->nullable();
            $table->timestamp('accepted_at')->nullable();
            $table->boolean('is_rejected')->default(0);
            $table->unsignedBigInteger('rejected_by')->nullable();
            $table->timestamp('rejected_at')->nullable();
            $table->longText('rejected_for')->nullable();
            $table->boolean('is_active')->default(1);
            $table->boolean('is_online')->default(0);
            $table->softDeletes();
            $table->timestamps();
            $table->foreign('user_id')->references('id')->on('users')->onUpdate('cascade')->onDelete('set null');
            $table->foreign('province_id')->references('id')->on('provinces')->onUpdate('cascade')->onDelete('set null');
            $table->foreign('city_id')->references('id')->on('cities')->onUpdate('cascade')->onDelete('set null');
            $table->foreign('accepted_by')->references('id')->on('users')->onUpdate('cascade')->onDelete('set null');
            $table->foreign('rejected_by')->references('id')->on('users')->onUpdate('cascade')->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('servicemans');
    }
};
