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
                                    <div v-if="order.is_done" class="col-md-12 mt-3">
                                        <div class="alert alert-success bg-success text-center">
                                            <p class="font-16 text-light font-weight-bold">
                                                این سفارش به پایان رسیده است
                                            </p>
                                        </div>

                                    </div>
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
                                        <div class="col-md-4 mt-2">
                                            <div class="card p-3">
                                                <div>
                                                    <span class="font-13 text-secondary ml-1">تاریخ ثبت سفارش : </span>
                                                    <span class="text-dark font-14">{{this.$filters.date(order.created_at)}}</span>
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
                                                        <span class="text-dark font-16 mr-2">{{order.servicemans[0].serviceman.name}}</span>
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
                                            <div class="col-md-4 mt-2">
                                                <div class="card p-3">
                                                    <div>
                                                        <span class="font-13 text-secondary ml-1">تاریخ شروع کار : </span>
                                                        <span class=" font-14 ">
                                                            {{this.$filters.date(order.servicemans[0].created_at)}}
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
                                        <div class="col-md-12 mt-2">
                                            <div class="card p-3">
                                                <div>
                                                    <div class="text-danger font-15">لیست قطعات خریداری شده برای سفارش</div>
                                                    <template v-if="!order.products.length">
                                                        <div class="mt-2 text-center img-fluid">
                                                            <img src="/images/default/no-products.png" width="70" alt="">

                                                            <div class="mt-1">هیچ محصولی برای این سفارش ثبت نشده است !</div>
                                                        </div>
                                                    </template>
                                                    <template v-else>
                                                        <div class="mt-4 table-responsive text-center">
                                                            <table class="table table-bordered">
                                                                <thead>
                                                                    <tr class="bg-dark text-light">
                                                                        <th>محصول</th>
                                                                        <th>قیمت</th>
                                                                        <th>توسط</th>
                                                                        <th>پرداخت</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr v-for="(product,index) in order.products">
                                                                        <td>
                                                                            <template v-if="product.products !== null">
                                                                                <router-link :to="{name : 'front_shop_products_single',params : {code : product.products.code}}">
                                                                                    {{product.products.name}}
                                                                                </router-link>
                                                                            </template>
                                                                        </td>
                                                                        <td>
                                                                            <span class="text-success font-15">
                                                                                <template v-if="product.products.sale !== null">
                                                                                    {{this.NumberFormatter(product.products.sale)}}
                                                                                </template>
                                                                                <template v-else>
                                                                                    {{this.NumberFormatter(product.products.price)}}
                                                                                </template>

                                                                            </span>
                                                                            <span class="mr-1 font-13">تومان</span>
                                                                        </td>
                                                                        <td>
                                                                            <span class="badge badge-warning font-13 p-2" v-if="product.paid === 'customer' || product.paid === 'nobody' ">
                                                                                مشتری
                                                                            </span>
                                                                            <span v-else class="badge badge-info font-13 p-2">
                                                                                سرویس کار
                                                                            </span>

                                                                        </td>
                                                                        <td>
                                                                            <span v-if="product.is_paid" class="badge badge-success font-13">
                                                                                پرداخت شده <i class="mdi mdi-check-circle font-18"></i>
                                                                            </span>
                                                                            <span v-else class="badge badge-danger font-13">
                                                                                پرداخت نشده <i class="mdi mdi-close font-18"></i>
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
                                        <div class="col-md-12 mt-2">
                                            <div class="card p-3">
                                                <div>
                                                    <div class="text-danger font-16">مبلغ نهایی قابل پرداخت</div>
                                                    <template v-if="!order.invoice">
                                                        <div class="mt-3">
                                                            <div class="alert alert-primary text-center">
                                                                هنوز فاکتوری برای این سفارش صادر نشده است .
                                                            </div>
                                                        </div>
                                                    </template>
                                                    <template v-else>
                                                        <div class="mt-3 row justify-content-center">

                                                            <div v-if="order.invoices.length" class="col-md-6">
                                                                <div class="card p-3">
                                                                    <div class="text-center">
                                                                        <span class="font-18 text-success font-weight-bold">
                                                                            {{this.NumberFormatter(order.invoices[0].price)}}
                                                                        </span>
                                                                        <span class="text-secondary mr-2">تومان</span>
                                                                    </div>
                                                                    <hr>
                                                                    <h6 class="text-center text-danger font-16">جزئیات فاکتور</h6>
                                                                    <table class="table table-bordered mt-2">
                                                                        <thead>
                                                                        <tr  class="font-14 bg-dark text-light">
                                                                            <th>عنوان</th>
                                                                            <th>هزینه</th>
                                                                        </tr>
                                                                        </thead>
                                                                        <tbody>
                                                                            <tr v-for="(detail,index) in order.invoices[0].details">
                                                                                <td>
                                                                                    {{detail.title}}
                                                                                </td>
                                                                                <td>
                                                                                    <span class="text-danger font-weight-bold">
                                                                                        {{this.NumberFormatter(detail.price)}}
                                                                                    </span>
                                                                                    <span class="text-secondary mr-2">تومان</span>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <span class="font-weight-bold font-15">جمع کل مبالغ</span>
                                                                                </td>
                                                                                <td>
                                                                                    <span class="font-weight-bold font-17 text-success">
                                                                                         {{this.NumberFormatter(order.invoices[0].price)}}
                                                                                    </span>
                                                                                    <span class="text-secondary mr-2">تومان</span>

                                                                                </td>
                                                                            </tr>
                                                                        </tbody>
                                                                        <tfoot>
                                                                        <tr>
                                                                            <td colspan="2" class="p-1 text-center">

                                                                                <button @click="StartPayment" v-if="!order.invoices[0].is_pay" class="btn btn-success w-100 text-center font-weight-bold">پرداخت آنلاین فاکتور</button>
                                                                                <span v-else class="badge badge-success p-2 font-14 w-100">
                                                                                    پرداخت شده است <i class="mdi mdi-check-circle font-20"></i>
                                                                                </span>
                                                                            </td>
                                                                        </tr>
                                                                        </tfoot>
                                                                    </table>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </template>
                                                </div>
                                            </div>
                                        </div>

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
import Swal from "sweetalert2";

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
                console.log(this.order);
            }).catch(error => {
                return Sweet.SweetServerErrorMessage();
            })

        },
        StartPayment(){
            if (this.order !== null && this.order.invoices.length){
                Swal.fire({
                    html: '<p class="font-18 text-dark">در حال اتصال به درگاه پرداخت </p>',
                    timer: 3200,
                    timerProgressBar: true,
                    didOpen: () => {
                        Swal.showLoading()
                        axios.post('/api/customer/invoices/payment/start',{invoice_id : this.order.invoices[0].id}).then(res => {
                            window.open(res.data.link,'_self')
                        }).catch(error => {
                            Sweet.SweetServerErrorMessage();
                        })

                    },
                    willClose: () => {

                    }
                }).then((result) => {
                    /* Read more about handling dismissals below */
                    if (result.dismiss === Swal.DismissReason.timer) {

                    }
                })
            }

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
