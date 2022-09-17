<template>
    <div class="page-title-area">
        <div class="d-table app-fade-in">
            <div class="d-table-cell">
                <div class="container">
                    <div class="page-title-content">
                        <h2>فروشگاه قطعات چارسو </h2>
                        <ul>
                            <li>
                                <router-link :to="{name : 'front_index'}" >
                                    صفحه اصلی
                                </router-link>
                            </li>
                            <li>
                                <router-link :to="{name : 'front_shop'}">
                                    فروشگاه قطعات
                                </router-link>
                            </li>
                            <li>
                                    پرداخت نهایی و ثبت سفارش
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="mt-5 mb-5">
        <div class="container">
            <h5 class="text-center mb-4">
                 پرداخت و ثبت نهایی سفارشات
            </h5>
            <hr>
            <div class="mt-4">
                <template v-if="CartItemCount">
                    <div class="row">
                        <div class="col-md-6">
                            <h6 class="text-danger">
                               لیست محصولات :
                            </h6>
                            <div class="card-body mt-1 table-responsive">
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
                                            <i @click="CartRemoveFromCart(index)" class="mdi mdi-trash-can font-22 pointer text-danger" title="حذف محصول از لیست خرید"></i>
                                        </td>
                                    </tr>
                                </table>
                            </div>

                        </div>
                        <div class="col-md-6">
                            <h6 class="text-danger">
                                اطلاعات فاکتور :
                            </h6>
                            <div class="card-body mt-1 table-responsive">
                                <table class="table">
                                    <tr>
                                        <td>
                                            <span class="text-secondary font-14">تعداد اقلام در فاکتور :</span>
                                        </td>
                                        <td>
                                            <span class="badge badge-success font-16">3</span>
                                            <span class="mr-2">عدد</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="text-secondary font-14">مجموع مبالغ محصولات :</span>
                                        </td>
                                        <td>
                                            <span class="font-17 text-success"><strong>{{this.NumberFormatter(168000)}}</strong></span>
                                            <span class="mr-2">تومان</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="text-secondary font-14">تخفیف اعمال شده :</span>
                                        </td>
                                        <td>
                                            <span class="font-17 text-danger"><strong>{{this.NumberFormatter(0)}}</strong></span>
                                            <span class="mr-2">تومان</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="text-dark font-15"><strong>مبلغ قابل پرداخت :</strong></span>
                                        </td>
                                        <td>
                                            <span class="font-18 text-danger"><strong>{{this.NumberFormatter(CartTotalPrice)}}</strong></span>
                                            <span class="mr-2">تومان</span>
                                        </td>
                                    </tr>
                                </table>
                                <hr>
                                <div class="text-center">
                                    <button v-if="UserAuthCheck()" class="btn btn-success font-16 w-100" >پرداخت آنلاین فاکتور  <i class="mdi mdi-check"></i></button>
                                    <button v-else disabled class="btn btn-success font-16 w-100" >پرداخت آنلاین فاکتور  <i class="mdi mdi-check"></i></button>
                                </div>
                            </div>
                        </div>
                        <div class="col-12"><hr></div>
                        <div class="col-md-12 mt-2">
                          <h6 class="text-center text-danger">
                              اطلاعات کاربری و محل سکونت
                          </h6>
                            <template  v-if="!UserAuthCheck()">
                                <div class="row justify-content-center mt-5">
                                    <div class="col-md-7">
                                        <div class="card-body shadow rounded">
                                            <div class="alert alert-primary">
                                                کاربر گرامی برای ثبت سفارش در سامانه چارسو، ابتدا باید وارد حساب کاربری خود شوید
                                                <br>
                                                برای ورود به حساب یا ثبت نام کافیست شماره موبایل خود را این قسمت وارد کنید .
                                            </div>
                                            <div class="mt-4">
                                                <label class="form-label mb-3">شماره موبایل :</label>
                                                <input class="form-control " v-model="phone" type="text" dir="ltr" placeholder="09XX XXX XXXX">
                                                <div class="mt-4 text-center">
                                                    <button v-if="!loading" @click="LoginFormSubmit" class="default-btn">ثبت نام یا ورود به حساب کاربری</button>
                                                    <button v-else disabled class="default-btn">ثبت نام یا ورود به حساب کاربری</button>
                                                </div>
                                            </div>

                                        </div>

                                    </div>

                                </div>
                            </template>
                            <template v-else>

                            </template>
                        </div>


                    </div>

                </template>
                <template v-else>

                    <div class="mt-5">
                        <div class="text-center img-fluid">
                            <img src="/images/default/empty-cart.png" alt="">
                        </div>
                        <h6 class="mt-4 text-danger text-center">
                            سبد خرید شما خالی است ، برای خرید محصولات با استفاده از دکمه زیر به فروشگاه بروید
                        </h6>
                        <div class="text-center mt-4">
                            <router-link :to="{name : 'front_shop'}" class="btn btn-info font-17">فروشگاه قطعات چارسو <i class="mdi mdi-shopping font-22"></i></router-link>
                        </div>

                    </div>

                </template>

            </div>



        </div>
    </div>
</template>

<script>
import {mapGetters} from "vuex";
export default {
    name: "Front_Shop_Checkout",
    created(){
        if(!this.UserAuthCheck()){
            AppStorage.AppStorageSetItem('charssu_back_to_cart','true')
        }

    },
    data(){
        return {
            phone : null,
            loading : false,
            errors:[],
        }
    },
    methods : {
        LoginFormSubmit() {
            if (!this.phone) {
                return Sweet.SweetToastMessage('برای ورود شماره موبایل خود را وارد کنید', 'error')
            }
            this.phone = this.NumberToEn(this.phone);
            this.loading = true;
            axios.post('/api/customer/auth/login', {phone: this.phone}).then(res => {
                this.loading = false;
                if (res.data) {
                    AppStorage.AppStorageSetItem('charssu_pre_customer_login', res.data);
                    window.open('/auth','_self');
                }
            }).catch(error => {
                if (error.response.status === 409) {
                    return Sweet.SweetToastMessage(error.response.data, 'error');
                }
                Sweet.SweetServerErrorMessage();
                this.loading = false;

            })
        },
    },

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


</style>
