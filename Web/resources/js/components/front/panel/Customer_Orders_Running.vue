<template>


    <div class="container-fluid">
        <div class="row mt-5 mb-5">
            <div class="col-md-3 mb-3">
                <main_menu class="app-fade-in"></main_menu>
            </div>
            <div class="col-md-9">

                <div class="card app-fade-in">
                    <div class="card-body">
                        <h6 class="text-danger">لیست سفاراشات در حال اجرا</h6>
                        <hr>
                        <div class="mt-5 mb-3">
                            <template v-if="!orders.length">
                                <div class="mt-5">
                                    <div class="row justify-content-center">
                                        <div class="col-md-7">
                                            <div class="alert alert-primary text-center">
                                                کاربر گرامی شما در حال حاضر هیچ سفارش فعالی در چارسو ندارید.
                                                <br>
                                                برای ثبت سفارش جدید از دکمه زیر استفاده کنید
                                            </div>
                                            <div class="banner-btn mt-4 text-center">
                                                <router-link :to="{name : 'front_orders_new'}"  class="default-btn">
                                                    ثبت سفارش در چارسو
                                                    <span></span>
                                                </router-link>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </template>
                            <template v-else>
                                <div class="table-responsive">
                                    <table class="table table-bordered text-center">
                                        <thead>
                                            <tr class="bg-dark text-light">
                                                <th>کد سفارش</th>
                                                <th>برند</th>
                                                <th>مدل</th>
                                                <th>وضعیت</th>
                                                <th>سرویس کار</th>
                                                <th>جزئیات</th>
                                                <th>تاریخ ثبت</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <tr v-for="(order,index) in orders" :key="index">
                                            <td>
                                                <span class="badge badge-primary font-12">{{order.code}}</span>
                                            </td>
                                            <td>
                                                <template v-if="order.device_brand_id !== null">
                                                    {{order.device_brand.name}}
                                                </template>
                                            </td>
                                            <td>
                                                <template v-if="order.device_id !== null">
                                                    {{order.device.name}}
                                                </template>
                                            </td>
                                            <td>
                                               <template v-if="!order.is_active">
                                                   <span class="badge badge-danger p-2 font-13">غیرفعال <i class="mdi mdi-cancel"></i></span>
                                               </template>
                                                <template v-else-if="order.invoice">
                                                    <span class="badge badge-warning text-dark p-2 font-13">در انتطار پرداخت فاکتور <i class="mdi mdi-clock"></i></span>
                                                </template>
                                                <template v-else>
                                                    <span class="badge badge-success p-2 font-13">درحال انجام <i class="mdi mdi-check-circle"></i></span>

                                                </template>
                                            </td>
                                            <td>
                                                <template v-if="order.servicemans.length">
                                                    <span class="font-15">{{order.servicemans[0].serviceman.name}}</span>
                                                </template>
                                                <template v-else>
                                                    <span class="badge badge-primary p-2 font-13">در انتطار سرویس کار <i class="mdi mdi-timer-sand"></i></span>
                                                </template>
                                            </td>
                                            <td>
                                                <router-link :to="{name : 'customer_orders_details',params : {code : order.code}}" class="btn btn-info font-14">
                                                    مشاهده جزئیات
                                                </router-link>
                                            </td>
                                            <td>
                                                <span class="badge badge-dark font-13">
                                                    {{this.$filters.date(order.created_at)}}
                                                </span>
                                            </td>

                                        </tr>
                                        </tbody>
                                    </table>

                                </div>
                            </template>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>




</template>

<script>
import Customer_Main_Menu from "./Customer_Main_Menu";

export default {
    name: "Customer_Orders_Running",
    created() {
      this.GetOrders();
    },
    components : {
        main_menu : Customer_Main_Menu
    },
    data(){
        return {
            orders : [],
        }
    },
    methods:{
        GetOrders(){
            axios.get('/api/customer/orders/running').then(res => {
                this.orders = res.data
            }).catch(e => {
                Sweet.SweetServerErrorMessage();
            })
        }


    }
}
</script>

<style scoped>

</style>
