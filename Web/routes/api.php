<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

//management api
Route::group(['prefix'=>'management'],static function (){

    //Helpers
    Route::prefix('helpers')->group(function (){
        Route::get('get/provinces',[\App\Http\Controllers\Api\HelperController::class,'get_provinces']);
    });

    //Users
    Route::resource('users',\App\Http\Controllers\Api\Manage\UserController::class);
    Route::get('users/activation/{user}',[\App\Http\Controllers\Api\Manage\UserController::class,'activation']);

    //Customers
    Route::resource('customers',\App\Http\Controllers\Api\Manage\CustomerController::class);
    Route::get('customers/activation/{customer}',[\App\Http\Controllers\Api\Manage\CustomerController::class,'activation']);

    //Provinces
    Route::resource('zones',\App\Http\Controllers\Api\Manage\ZoneController::class);

    //Servicemans
    Route::resource('servicemans',\App\Http\Controllers\Api\Manage\ServicemanController::class);

    //device brands
    Route::resource('device-brands',\App\Http\Controllers\Api\Manage\DeviceBrandController::class);






});

//Application api
Route::group(['prefix' => 'app'],static function(){

    //servicemans

    Route::prefix('serviceman')->group(function (){

        Route::post('auth',[\App\Http\Controllers\Api\App\Serviceman\AuthController::class,'auth']);
        Route::post('auth/check',[\App\Http\Controllers\Api\App\Serviceman\AuthController::class,'auth_check']);

        Route::middleware('api_serviceman_auth')->group(function (){
            Route::get('profile',[\App\Http\Controllers\Api\App\Serviceman\ProfileController::class,'get_profile']);
            Route::post('profile',[\App\Http\Controllers\Api\App\Serviceman\ProfileController::class,'update_profile']);
            Route::get('activation',[\App\Http\Controllers\Api\App\Serviceman\ProfileController::class,'activation']);

        });


    });



});
