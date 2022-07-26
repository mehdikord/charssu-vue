<?php

use App\Models\Order;
use App\Models\Serviceman;
 use Illuminate\Support\Str;

//create token string with unique id for users
function token_creator($unique) :string
{
    return Str::random(5).$unique.Str::random(122);
}

//serviceman get user info
function api_serviceman_get_user()
{
    return Serviceman::where('api_token',request()->header('Authorization'))->with(['province','city','device_brands','zones'])->first();
}

function api_serviceman_get_id(){

    return Serviceman::where('api_token',request()->header('Authorization'))->first()->id;

}

//set serviceman to order
function api_order_set_serviceman($order_id){

    $order = Order::find($order_id);
    if($order->is_active && !$order->is_done){
        $serviceman = Serviceman::query();
        $serviceman->where('is_accepted',true)->where('is_active',true)->where('is_online',true);
        $serviceman->whereHas('zones',function($zone)use($order){
            $zone->where('zones.id',$order->zone_id);
        });
        $serviceman->whereHas('device_brands',function($brand)use($order){
            $brand->where('device_brands.id',$order->device_brand_id);
        });
        $serviceman->whereDoesntHave('orders',function($service_order)use($order){
            $service_order->where('order_id',$order->id);
        });
        $serviceman = $serviceman->get();
        $final_servicemans = [];
        if (count($serviceman)) {
            foreach ($serviceman as $item) {
                if (!api_check_serviceman_busy($item->id)) {
                    $final_servicemans[]=$item;
                }
            }
            if(count($final_servicemans)){
                $final_servicemans[0]->orders()->create([
                    'order_id' => $order->id,
                ]);

                return ['find'=>true,'serviceman' => $final_servicemans[0]];
            }
            return ['find'=>false,'notfound'];
        }
        return ['find'=>false,'notfound'];
    }
    return ['find'=>false,'inactive'];
}

//check serviceman busy
function api_check_serviceman_busy($serviceman_id){
    $serviceman = Serviceman::find($serviceman_id);
    $busy=false;
    foreach($serviceman->orders as $order){
        if($order->order->is_done == 0){
            $busy = true;
        }
    }
    return $busy;
}

