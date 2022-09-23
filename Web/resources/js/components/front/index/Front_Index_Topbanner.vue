<template>
    <div class="main-banner-four">
        <div class="d-table">
            <div class="d-table-cell">
                <div class="container-fluid">
                    <div class="row align-items-center">
                        <div class="col-lg-6 col-md-12">
                            <div class="main-banner-content">
                                <h1 class="text-aviny font-70">چارسو</h1>
                                <p class="font-22">
                                    چارسو اولین پلتفرم تخصصی خدمات و ارسال سرویس کار پکیج های دیواری
                                </p>
                                <div class="banner-btn">
                                    <router-link :to="{name : 'front_orders_new'}"  class="default-btn-one text-dark">
                                        درخواست سرویس کار !
                                        <span></span>
                                    </router-link>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-12">
                            <div class="banner-image">
                                <img src="/template/img/default/main-banner.svg" alt="image">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="creative-shape">
            <img src="/template/img/main-banner-shape/home-shape-4.png" alt="main-image">
        </div>
        <div class="lines">
            <div class="line"></div>
            <div class="line"></div>
            <div class="line"></div>
        </div>
    </div>
</template>

<script>
export default {
    name: "Front_Index_Topbanner"
}
</script>

<style scoped>

</style>
