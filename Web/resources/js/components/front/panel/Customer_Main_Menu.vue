<template>
    <div class="card">
        <div class="card-body">
            <div class="mb-4">
                <router-link :to="{name : 'customer_profile'}" class="btn w-100 font-15 p-2" :class="{'btn-info' : this.$route.name === 'customer_profile','btn-dark' : this.$route.name !== 'customer_profile'}">
                    <i class="mdi mdi-account font-24 ml-1"></i>
                    اطلاعات حساب کاربری
                </router-link>
            </div>
            <div class="mb-4">
                <router-link :to="{name : 'customer_orders_running'}" class="btn w-100 font-15 p-2" :class="{'btn-info' : this.$route.name === 'customer_orders_running','btn-dark' : this.$route.name !== 'customer_orders_running'}">
                    <i class="mdi mdi-account-hard-hat-outline font-24 ml-1"></i>
                    سفارشات درحال اجرا
                </router-link>
            </div>
            <div class="mb-4">
                <router-link to="" class="btn btn-dark w-100 font-15 p-2">
                    <i class="mdi mdi-check-circle font-24 ml-1"></i>
                    سفارشات پابان یافته
                </router-link>
            </div>
            <div class="mb-4">
                <router-link to="" class="btn btn-dark w-100 font-15 p-3">
                    اطلاعات حساب کاربری
                </router-link>
            </div>

        </div>

    </div>

</template>

<script>

export default {
    name: "Customer_Main",

}
</script>

<style scoped>


</style>
