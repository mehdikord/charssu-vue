<template>
    <div class="container-fluid">
        <div class="row mt-5 mb-5">
            <div class="col-md-3 mb-3">
                <main_menu class="app-fade-in"></main_menu>
            </div>
            <div class="col-md-9">

                <div class="card app-fade-in">
                    <div class="card-body">
                        <h6 class="text-danger">مشاهده جزئیات سفارش : <span class="text-dark app-fade-in" v-if="order !== null">{{order.code}}</span> </h6>
                        <hr>
                        <div class="mt-4 mb-3">
                            <div class="row">
                                <div v-if="order !== null" class="col-12">
                                    <h6 class="font-15 text-primary">
                                        اطلاعات سفارش
                                    </h6>
                                    <div class="mt-2 row">
                                        <div class="col-md-4 mt-2">
                                            <div class="card p-3">
                                               <div>
                                                   <span class="font-13 text-secondary ml-1">کد سفارش : </span>
                                                   <span class="text-danger font-14">{{order.code }}</span>
                                               </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4 mt-2">
                                            <div class="card p-3">
                                                <div>
                                                    <span class="font-13 text-secondary ml-1">نام برند دستگاه : </span>
                                                    <span class="text-dark font-14">{{order.device_brand.name}}</span>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="col-md-4 mt-2">
                                            <div class="card p-3">
                                                <div>
                                                    <span class="font-13 text-secondary ml-1">مدل و سریال دستگاه : </span>
                                                    <span class="text-dark font-14">{{order.device.name}}</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4 mt-2">
                                            <div class="card p-3">
                                                <div>
                                                    <span class="font-13 text-secondary ml-1">شامل گارانتی است : </span>
                                                    <span v-if="order.warranty === '1'" class="text-success font-14">بله <i class="mdi mdi-check-circle font-18"></i></span>
                                                    <span v-else class="text-danger font-14">خیر <i class="mdi mdi-cancel font-18"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div  v-if="order.warranty === '1'" class="col-md-4 mt-2">
                                            <div class="card p-3">
                                                <div>
                                                    <span class="font-13 text-secondary ml-1">تاریخ گارانتی : </span>
                                                    <span class="text-dark font-14">
                                                        {{this.$filters.date(order.warranty_date)}}
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4 mt-2">
                                            <div class="card p-3">
                                                <div>
                                                    <span class="font-13 text-secondary ml-1">تصویر سفارش : </span>
                                                    <span>
                                                        <button data-toggle="modal" data-target="#show_image" class="btn btn-info font-14 btn-sm" :disabled="order.image === null">مشاهده</button>
                                                    </span>
                                                    <div v-if="order.image !== null" class="modal fade" id="show_image" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                        <div class="modal-dialog modal-lg">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h6 class="font-14" id="exampleModalLabel">مشاهده تصویر پیوست</h6>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <div class="mt-3 text-center img-fluid">
                                                                        <img :src="order.image" width="100%" alt="">
                                                                    </div>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">بستن</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12 mt-2">
                                            <div class="card p-3">
                                                <div>
                                                    <span class="font-13 text-secondary ml-1">مشکل دستگاه : </span>
                                                    <span class="text-dark font-14">
                                                        {{order.problem.problem}}
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12 mt-2">
                                            <div class="card p-3">
                                                <div>
                                                    <span class="font-13 text-secondary ml-1">توضیحات کامل : </span>
                                                    <span class="text-dark font-14">
                                                        {{order.description}}
                                                    </span>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <div class="row mt-4">
                                <div v-if="order !== null" class="col-12">
                                    <h6 class="font-15 text-primary">
                                        اطلاعات سرویس کار
                                    </h6>
                                    <div class="mt-2 row">
                                        <template v-if="order.servicemans.length">
                                            <div class="col-md-4 mt-2">
                                                <div class="card p-3">
                                                    <div>
                                                        <img v-if="order.servicemans[0].serviceman.profile !== null"  class="serviceman-img" src="" alt="">
                                                        <img v-else  class="serviceman-img" src="/images/default/user.png" alt="">
                                                        <span class="text-dark font-15 mr-2">{{order.servicemans[0].serviceman.name}}</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4 mt-2">
                                                <div class="card p-3">
                                                    <div>
                                                        <span class="font-13 text-secondary ml-1">شماره موبایل سرویس کار : </span>
                                                        <a :href="'tel:'+order.servicemans[0].serviceman.phone" class="badge badge-dark text-light font-14 p-2">
                                                            {{order.servicemans[0].serviceman.phone}}
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4 mt-2">
                                                <div class="card p-3">
                                                    <div>
                                                        <span class="font-13 text-secondary ml-1">کد سرویس کار در چارسو : </span>
                                                        <span class="badge badge-danger font-14 p-2">
                                                            {{order.servicemans[0].serviceman.code}}
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>

                                        </template>
                                        <template v-else>
                                            <div class="col-12 mt-4">
                                                <div class="alert alert-warning text-dark text-center">
                                                    سفارش در انتظار دریافت سرویس کار است
                                                </div>
                                            </div>
                                        </template>
                                    </div>
                                </div>
                            </div>
                            <div class="row mt-5">
                                <div v-if="order !== null" class="col-12">
                                    <h6 class="font-15 text-primary">
                                        اطلاعات فاکتور و قطعات خریداری شده
                                    </h6>
                                    <div class="mt-2 row">

                                    </div>
                                </div>
                            </div>
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
    name: "Customer_Orders_Detail",
    created() {
      this.GetOrder();
    },
    components : {
        main_menu : Customer_Main_Menu,
    },
    data(){
        return {
            order : null,

        }
    },
    methods : {
        GetOrder(){
            axios.get('/api/customer/orders/details/'+this.$route.params.code).then(res => {
                this.order = res.data;
            }).catch(error => {
                return Sweet.SweetServerErrorMessage();
            })

        }
    }
}
</script>

<style scoped>
.serviceman-img{
    width: 55px;
    height: 55px;
    border-radius: 50%;
}

</style>
