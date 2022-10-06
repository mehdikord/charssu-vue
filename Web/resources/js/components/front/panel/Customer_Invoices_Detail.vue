<template>

    <div class="container-fluid">
        <div class="row mt-5 mb-5">
            <div class="col-md-3 mb-3">
                <main_menu class="app-fade-in"></main_menu>
            </div>
            <div class="col-md-9">

                <div class="card app-fade-in">
                    <div class="card-body">
                        <h6 class="text-danger">مشاهده جزئیات فاکتور </h6>
                        <hr>
                        <template v-if="invoice.is_pay">
                            <div class="row justify-content-center mt-3">
                                <div class="col-md-6">
                                    <div class="alert alert-success text-center">
                                        این فاکتور با موفقیت پرداخت شده است <i class="mdi mdi-check-circle font-20"></i>
                                    </div>
                                </div>
                            </div>
                        </template>
                        <div class="mt-4 mb-3">
                            <div class="row">
                                <div v-if="invoice !== null" class="col-12">
                                    <h6 class="font-15 text-primary">
                                        جزئیات
                                    </h6>
                                    <div class="mt-2 row">
                                        <div v-if="invoice.order !== null" class="col-md-4 mt-2">
                                            <div class="card p-3">
                                                <div>
                                                    <span class="font-13 text-secondary ml-1">کد سفارش : </span>
                                                    <span class="text-danger font-14">{{invoice.order.code }}</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4 mt-2">
                                            <div class="card p-3">
                                                <div>
                                                    <span class="font-13 text-secondary ml-1"> مبلغ فاکتور : </span>
                                                    <span class="text-success font-weight-bold font-15 ml-1">{{ this.NumberFormatter(invoice.price)}}</span>
                                                    تومان
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4 mt-2">
                                            <div class="card p-3">
                                                <div>
                                                    <span class="font-13 text-secondary ml-1"> وضعیت پرداخت : </span>
                                                    <span v-if="invoice.is_pay" class="font-weight-bold font-14 text-success">
                                                    <i class="mdi mdi-check-circle font-20"></i>
                                                    پرداخت شده
                                                </span>
                                                    <span v-else class="font-weight-bold font-14 text-danger">
                                                    <i class="mdi mdi-cancel font-20"></i>
                                                    پرداخت نشده
                                                </span>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <h6 class="font-15 text-primary mt-4">
                                        جزئیات پرداخت فاکتور
                                    </h6>
                                    <template v-if="!invoice.is_pay">
                                        <div class="row justify-content-center mt-5">
                                            <div class="col-md-6">
                                                <div class="alert alert-warning text-dark text-center">
                                                    فاکتور مورد نظر پرداخت نشده است !
                                                    <div class="mt-3">
                                                        <button @click="StartPayment" class="btn btn-success">پرداخت آنلاین فاکتور</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </template>
                                    <template v-else>
                                        <div class="mt-2 row">
                                            <div class="col-md-4 mt-3">
                                                <div class="card p-3">
                                                    <div>
                                                        <span class="font-13 text-secondary ml-1">کد پیگیری بانکی : </span>
                                                        <span class="text-success font-14 font-weight-bold">{{invoice.ref_id }}</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4 mt-3">
                                                <div class="card p-3">
                                                    <div>
                                                        <span class="font-13 text-secondary ml-1">شناسه پرداخت : </span>
                                                        <span class="text-danger font-14 font-weight-bold">{{invoice.pay_id }}</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4 mt-3">
                                                <div class="card p-3">
                                                    <div>
                                                        <span class="font-13 text-secondary ml-1">تاریخ پرداخت : </span>
                                                        <span class="font-14 font-weight-bold">
                                                            {{this.$filters.date(invoice.paid_at)}}
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4 mt-3">
                                                <div class="card p-3">
                                                    <div>
                                                        <span class="font-13 text-secondary ml-1">شماره کارت : </span>
                                                        <span class="font-14 font-weight-bold">
                                                            {{invoice.card_number}}
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4 mt-3">
                                                <div class="card p-3">
                                                    <div>
                                                        <span class="font-13 text-secondary ml-1">روش پرداخت : </span>
                                                        <span class="font-14 badge badge-dark p-2">
                                                            {{invoice.method}}
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4 mt-3">
                                                <div class="card p-3">
                                                    <div>
                                                        <span class="font-13 text-secondary ml-1">درگاه پرداخت : </span>
                                                        <span class="font-14 badge badge-primary p-2">
                                                            {{invoice.gateway}}
                                                        </span>
                                                    </div>
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

</template>

<script>
import Customer_Main_Menu from "./Customer_Main_Menu";
import Swal from "sweetalert2";

export default {
    name: "Customer_Invoices_Detail",
    created() {
        this.GetInvoice();
    },
    components : {
        main_menu : Customer_Main_Menu,
    },
    data(){
        return {
            invoice : null,
        }
    },
    methods : {
        GetInvoice(){
            axios.get('/api/customer/invoices/'+this.$route.params.id).then(res => {
                this.invoice = res.data;
                console.log(this.invoice);
            }).catch(error => {
                return Sweet.SweetServerErrorMessage();
            })

        },
        StartPayment(){
            if (this.invoice !== null){
                Swal.fire({
                    html: '<p class="font-18 text-dark">در حال اتصال به درگاه پرداخت </p>',
                    timer: 3200,
                    timerProgressBar: true,
                    didOpen: () => {
                        Swal.showLoading()
                        axios.post('/api/customer/invoices/payment/start',{invoice_id : this.invoice.id}).then(res => {
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

</style>
