<template>

    <div class="container-fluid">
        <div class="row mt-5 mb-5">
            <div class="col-md-3 mb-3">
                <main_menu class="app-fade-in"></main_menu>
            </div>
            <div class="col-md-9">

                <div class="card app-fade-in">
                    <div class="card-body">
                        <h6 class="text-danger">لیست همه فاکتور ها</h6>
                        <hr>
                        <div class="mt-5 mb-3">
                            <template v-if="!items.length">
                                <div class="mt-5">
                                    <div class="row justify-content-center">
                                        <div class="col-md-7">
                                            <div class="alert alert-primary text-center">
                                                کاربر گرامی در حال حاضر هیچ فاکتوری برای شما در چارسو ثبت نشده است .
                                                <br>
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
                                            <th>مبلغ</th>
                                            <th>وضعیت پرداخت</th>
                                            <th>جزئیات</th>
                                            <th>تاریخ ثبت</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr v-for="(item,index) in items" :key="index">
                                            <td>
                                                <span class="badge badge-primary font-13">{{item.order.code}}</span>
                                            </td>
                                            <td>
                                                <span class="font-weight-bold font-15 text-success ml-1">
                                                    {{this.NumberFormatter(item.price)}}
                                                </span>
                                                تومان
                                            </td>
                                            <td>
                                                <span v-if="item.is_pay" class="font-weight-bold font-14 text-success">
                                                    <i class="mdi mdi-check-circle font-20"></i>
                                                    پرداخت شده
                                                </span>
                                                <span v-else class="font-weight-bold font-14 text-danger">
                                                    <i class="mdi mdi-cancel font-20"></i>
                                                    پرداخت نشده
                                                </span>
                                            </td>
                                            <td>
                                                <router-link :to="{name : 'customer_invoices_details',params : {id : item.id}}" class="btn btn-info font-14">
                                                    مشاهده جزئیات
                                                </router-link>
                                            </td>
                                            <td>
                                                <span class="badge badge-dark font-13">
                                                    {{this.$filters.date(item.created_at)}}
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
    name: "Customer_Invoices",
    created() {
        this.GetItems();
    },
    components : {
        main_menu : Customer_Main_Menu
    },
    data(){
        return {
            items : [],
        }
    },
    methods:{
        GetItems(){
            axios.get('/api/customer/invoices').then(res => {
                this.items = res.data
            }).catch(e => {
                Sweet.SweetServerErrorMessage();
            })
        }


    }

}
</script>

<style scoped>

</style>
