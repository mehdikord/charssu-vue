<template>







    <nav class="navbar sticky-top navbar-expand-lg navbar-dark bg-dark pr-4 pl-4">

        <a class="navbar-brand img-fluid font-weight-bolder" href="#">
            <img src="/logo-name.png" width="40" class="img-fluid pl-2" alt="logo">
            <span>
                چارسو
            </span>
        </a>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav font-weight-bold ">
                <li class="nav-item pr-1 pl-1">
                    <router-link class="nav-link  text-warning " :to="{name: 'front_index'}" :class="{'text-light' : this.$route.name !== 'front_index' }">
                        <i class="mdi mdi-home"></i>
                        صفحه اصلی
                    </router-link>
                </li>
                <li class="nav-item pr-1 pl-1">
                    <router-link class="nav-link text-warning" :to="{name: 'front_orders_new'}" :class="{'text-light' : this.$route.name !== 'front_orders_new'}">
                        <i class="mdi mdi-wrench"></i>
                        تعمیر پکیج
                    </router-link>
                </li>
                <li class="nav-item pr-1 pl-1">
                    <router-link class="nav-link text-warning" :to="{name: 'front_shop'}"  :class="{'text-light' : this.$route.name !== 'front_shop'}">
                        <i class="mdi mdi-cart-plus"></i>
                        فروشگاه چارسو
                    </router-link>
                </li>

                <li class="nav-item pr-1 pl-1">
                    <a  class="nav-link text-light" >
                        <i class="mdi mdi-account-group"></i>
                        درباره چارسو
                    </a>
                </li>
                <li class="nav-item pr-1 pl-1">
                    <a  class="nav-link text-light">
                        <i class="mdi mdi-script-text"></i>
                        قوانین و مقررات
                    </a>
                </li>

            </ul>
        </div>

        <div class="row">
            <div>
                <router-link v-if="!UserAuthCheck()" :to="{name : 'front_auth'}" class="btn btn-warning btn-sm">
                    <i class="mdi mdi-account"></i>
                    حساب کاربری
                </router-link>
                <router-link v-else :to="{name : 'front_auth'}" class="btn btn-warning btn-sm">
                    <i class="mdi mdi-monitor-dashboard"></i>
                    پنل کاربری
                </router-link>

            </div>
            <div class="dropdown pr-3">
                <button class="btn btn-secondary dropdown-toggle btn-sm" :class="{'btn-danger' : CartItemCount}" type="button" data-toggle="dropdown" aria-expanded="false">
                    <i class="mdi mdi-shopping"></i>
                    سبد خرید ({{CartItemCount}})
                </button>
                <div class="dropdown-menu mt-3 p-3 cart-box">
                    <template v-if="CartItemCount">
                        <table class="table">

                            <tr v-for="(item,index) in CartItemGet.items" :key="index" class="cart-right">
                                <td>
                                    <template v-if="item.product.images.length">
                                        <img class="img-fluid" :src="item.product.images[0].image" :alt="item.product.name" width="70" >
                                    </template>
                                    <img v-else class="img-fluid" src="/images/default/product.png" width="50" alt="image">
                                </td>
                                <td>
                                    <router-link class="font-17" :to="{name:'front_shop_products_single',params : {code : item.product.code}}">
                                        {{item.product.name}}
                                    </router-link>
                                    <br>
                                    <span v-if="item.product.sale !== null" class="font-14 text-success">
                                        {{this.NumberFormatter(item.product.sale)}}
                                    </span>
                                    <span v-else class="font-14 text-success">
                                        {{this.NumberFormatter(item.product.price)}}
                                    </span>
                                    <span class="font-12 mr-2">تومان</span>

                                </td>
                                <td>
                                    <span class="badge badge-primary mt-2">{{item.quantity}}</span>
                                </td>
                                <td>
                                    <i @click="CartRemoveFromCart(index)" class="mdi mdi-trash-can font-22 pointer"></i>
                                </td>
                            </tr>
                        </table>

                    </template>

                    <template v-else>

                        <div class="text-center">
                            <img src="/images/default/empty-cart.png" width="180" alt="empty cart">
                            <h6 class="mt-3">
                                سبد خرید شما خالی است
                            </h6>


                        </div>

                    </template>
                    <hr>
                   <div class="text-center">
                       <router-link :to="{name : 'front_shop_checkout'}" class="btn btn-success w-100">
                           مشاهده سبد و پرداخت نهایی
                       </router-link>
                   </div>
                </div>
            </div>
            <div class="pr-3">
                <router-link :to="{name : 'front_auth'}" class="btn btn-success btn-sm ">
                    <i class="mdi mdi-headset"></i>
                    پشتیبانی
                </router-link>
            </div>

        </div>

        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

    </nav>






</template>

<script>
import {mapGetters} from "vuex";

export default {
    name: "Front_Template_Main_Navbar",

    computed:{
        ...mapGetters({
            CartItemCount : 'CartItemCount',
            CartItemGet : 'CartItemGet',
            CartTotalPrice : 'CartTotalPrice',
        })

    }

}
</script>

<style scoped>
.font-weight-bold{
    font-weight: 500 !important;
}
.dropdown-menu{
    min-width: 18rem;
    left: -70px !important;

}
.cart-right{
    text-align: right!important;
}
.cart-box {
    overflow: scroll !important;
    height: auto !important;
    max-height: 100vh !important;
}

.pointer{
    cursor: pointer!important;
}

</style>
