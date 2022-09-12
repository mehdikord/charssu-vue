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
                <button class="btn btn-secondary dropdown-toggle btn-sm" type="button" data-toggle="dropdown" aria-expanded="false">
                    <i class="mdi mdi-shopping"></i>
                    سبد خرید
                </button>
                <div class="dropdown-menu">


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
export default {
    name: "Front_Template_Main_Navbar",

}
</script>

<style scoped>
.font-weight-bold{
    font-weight: 500 !important;
}

</style>
