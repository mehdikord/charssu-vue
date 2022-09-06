
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
//helpers
Route::prefix('helpers')->group(function (){
    Route::get('get/provinces',[\App\Http\Controllers\Api\HelperController::class,'get_provinces']);
    Route::get('get/brands',[\App\Http\Controllers\Api\HelperController::class,'get_brands']);
    Route::get('get/problems',[\App\Http\Controllers\Api\HelperController::class,'get_problems']);
    Route::get('get/product-categories',[\App\Http\Controllers\Api\HelperController::class,'get_product_categories']);
    Route::get('install-zones',[\App\Http\Controllers\Api\HelperController::class,'install_zone']);
    Route::prefix('shop')->group(function (){
        Route::prefix('products')->group(function (){
            Route::get('',[\App\Http\Controllers\Api\Front\ShopController::class,'products']);
            Route::get('categories',[\App\Http\Controllers\Api\Front\ShopController::class,'categories']);
        });


    });

});



//management api
Route::group(['prefix'=>'management'],static function (){

    //Helpers
    Route::prefix('helpers')->group(function (){
        Route::get('get/provinces',[\App\Http\Controllers\Api\HelperController::class,'get_provinces']);
        Route::get('get/brands',[\App\Http\Controllers\Api\HelperController::class,'get_brands']);
    });

    Route::prefix('auth')->group(function (){
        Route::post('login',[\App\Http\Controllers\Api\Manage\AuthController::class,'login']);
        Route::post('login-check',[\App\Http\Controllers\Api\Manage\AuthController::class,'login_check']);

    });

    //set middleware
    Route::middleware('api_user_auth')->group(function (){

        //Users
        Route::resource('users',\App\Http\Controllers\Api\Manage\UserController::class);
        Route::get('users/activation/{user}',[\App\Http\Controllers\Api\Manage\UserController::class,'activation']);

        //Customers
        Route::resource('customers',\App\Http\Controllers\Api\Manage\CustomerController::class);
        Route::get('customers/activation/{customer}',[\App\Http\Controllers\Api\Manage\CustomerController::class,'activation']);

        //Provinces
        Route::resource('zones',\App\Http\Controllers\Api\Manage\ZoneController::class);

        Route::prefix('servicemans')->group(function (){
            Route::get('waiting',[\App\Http\Controllers\Api\Manage\ServicemanController::class,'waiting']);
            Route::get('set/accept',[\App\Http\Controllers\Api\Manage\ServicemanController::class,'set_accept']);
            Route::get('set/reject',[\App\Http\Controllers\Api\Manage\ServicemanController::class,'set_reject']);
        });

        Route::resource('servicemans',\App\Http\Controllers\Api\Manage\ServicemanController::class);

        //device brands
        Route::resource('device-brands',\App\Http\Controllers\Api\Manage\DeviceBrandController::class);
        Route::post('device-brands/update/{brand}',[\App\Http\Controllers\Api\Manage\DeviceBrandController::class,'update']);

        //devices
        Route::resource('devices',\App\Http\Controllers\Api\Manage\DeviceController::class);
        Route::post('devices/update/{device}',[\App\Http\Controllers\Api\Manage\DeviceController::class,'update']);

        //problems
        Route::resource('problems',\App\Http\Controllers\Api\Manage\ProblemController::class);

        //products categories
        Route::resource('product-categories',\App\Http\Controllers\Api\Manage\ProductCategoryController::class);

        //products
        Route::resource('products',\App\Http\Controllers\Api\Manage\ProductController::class);
        Route::prefix('products')->group(function (){
            Route::get('images/{product}',[\App\Http\Controllers\Api\Manage\ProductController::class,'images']);
            Route::post('images/{product}',[\App\Http\Controllers\Api\Manage\ProductController::class,'images_store']);
            Route::delete('images/{image}',[\App\Http\Controllers\Api\Manage\ProductController::class,'images_delete']);

        });






    });




});

//management
Route::prefix('customer')->group(function (){

    Route::prefix('auth')->group(function (){
        Route::post('login',[\App\Http\Controllers\Api\Customer\AuthController::class,'login']);
        Route::post('login-check',[\App\Http\Controllers\Api\Customer\AuthController::class,'login_check']);

    });

    Route::middleware('api_customer_auth')->group(function (){

        Route::prefix('profile')->group(function (){
            Route::get('',[\App\Http\Controllers\Api\Customer\ProfileController::class,'get_profile']);
        });
        Route::prefix('orders')->group(function (){
            Route::post('new',[\App\Http\Controllers\Api\Customer\OrderController::class,'new']);

        });


    });


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
            Route::prefix('orders')->group(function (){
                Route::get('new',[\App\Http\Controllers\Api\App\Serviceman\OrderController::class,'new']);
                Route::get('done',[\App\Http\Controllers\Api\App\Serviceman\OrderController::class,'done']);
                Route::get('active',[\App\Http\Controllers\Api\App\Serviceman\OrderController::class,'active']);
                Route::post('accept',[\App\Http\Controllers\Api\App\Serviceman\OrderController::class,'accept']);
                Route::post('cancel',[\App\Http\Controllers\Api\App\Serviceman\OrderController::class,'cancel']);
                Route::post('cancel-reason',[\App\Http\Controllers\Api\App\Serviceman\OrderController::class,'cancel_reason']);
                Route::get('single/{order}',[\App\Http\Controllers\Api\App\Serviceman\OrderController::class,'single']);
                Route::post('notes/{order}',[\App\Http\Controllers\Api\App\Serviceman\OrderController::class,'set_notes']);
                Route::get('notes/{order}',[\App\Http\Controllers\Api\App\Serviceman\OrderController::class,'get_notes']);
                Route::get('products/{order}',[\App\Http\Controllers\Api\App\Serviceman\OrderController::class,'get_products']);

            });

        });





    });



});
