<template>
    <div class="container-fluid">
        <div class="row mt-5 mb-5">
            <div class="col-md-3 mb-3">
                <div class="card">
                    <div class="card-body">
                        <div class="mb-4">
                            <router-link to="" class="btn w-100 font-15 p-2" :class="{'btn-info' : this.$route.name === 'customer_profile','btn-dark' : this.$route.name !== 'customer_profile'}">
                                <i class="mdi mdi-account font-24 ml-1"></i>
                                اطلاعات حساب کاربری
                            </router-link>
                        </div>
                        <div class="mb-4">
                            <router-link to="" class="btn btn-dark w-100 font-15 p-2" >
                                <i class="mdi mdi-account-hard-hat-outline font-24 ml-1"></i>
                                سفارشات درحال اجرا
                            </router-link>
                        </div>
                        <div class="mb-4">
                            <router-link to="" class="btn btn-dark w-100 font-15 p-3">
                                اطلاعات حساب کاربری
                            </router-link>
                        </div>
                        <div class="mb-4">
                            <router-link to="" class="btn btn-dark w-100 font-15 p-3">
                                اطلاعات حساب کاربری
                            </router-link>
                        </div>

                    </div>

                </div>
            </div>
            <div class="col-md-9">
                <profile :if="this.$route.name === 'customer_profile'"></profile>

            </div>

        </div>
    </div>

</template>

<script>
import Customer_Profile from "./Customer_Profile";

export default {
    name: "Customer_Main",
    components : {
        profile : Customer_Profile,
    }
}
</script>

<style scoped>


</style>
