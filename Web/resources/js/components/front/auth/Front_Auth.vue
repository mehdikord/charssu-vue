<template>
    <div class="page-title-area">
        <div class="d-table">
            <div class="d-table-cell">
                <div class="container">
                    <div class="page-title-content">
                        <h2>حساب کاربری </h2>
                        <ul>
                            <li><router-link :to="{name : 'front_index'}">صفحه اصلی</router-link></li>
                            <li>حساب کاربری</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="contact-section ptb-100">
        <div class="container">
            <h5 v-if="!pre_customer_login" class="text-center text-danger">برای ثبت نام ورود به حساب کاربری خود در چارسو کافیست شماره موبایل خود را وارد کنید</h5>
            <h5 v-else class="text-center text-danger">برای تکمیل احراز هویت لطفا کد ارسال شده به شماره موبایل خود را وارد کنید</h5>
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <div class="contact-image">

                        <img v-if="pre_customer_login" src="/template/img/default/phone_auth_check.svg" alt="image">

                        <img v-else src="/template/img/default/auth.svg" alt="image">

                    </div>
                </div>
                <div class="col-lg-6">

                    <div class="contact-form">
                        <div v-if="pre_customer_login" class="row">
                                <div class="col-lg-12 col-md-12">
                                    <div class="form-group">
                                        <label class="font-18 mb-4">کد تائید ارسال شده را وارد کنید</label>
                                        <input dir="ltr" v-model="code" type="text" class="form-control p-4"  >
                                    </div>
                                </div>
                                <div class="col-lg-12 col-md-12">
                                    <button @click="SubmitCode" type="submit" class="submit-btn">ارسال کد تائید</button>
                                </div>
                            </div>
                        <div v-else class="row">
                                <div class="col-lg-12 col-md-12">
                                    <div class="form-group">
                                        <label class="form-label mb-4">شماره موبایل خود را وارد کنید</label>
                                        <input dir="ltr" v-model="phone" type="text" class="form-control p-4" placeholder="09XX XXX XXXX">
                                    </div>
                                </div>
                                <div class="col-lg-12 col-md-12">
                                    <button @click="LoginFormSubmit" type="submit" class="submit-btn">ورود به حساب کاربری</button>
                                </div>
                            </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</template>

<script>
import appStorage from "../../../helpers/AppStorage";

export default {
    name: "Front_Auth",
    created() {
        if (this.UserAuthCheck()){
            return this.$router.push({name : 'front_index'})
        }

        if (AppStorage.AppStorageCheckItem('charssu_pre_customer_login')){
            this.pre_customer_login=true;
        }

    },

    data(){
        return {
            phone : null,
            code : null,
            loading : false,
            pre_customer_login : false,
            errors:[],
        }
    },
    methods : {
        LoginFormSubmit(){
            if (!this.phone){
                return Sweet.SweetToastMessage('برای ورود شماره موبایل خود را وارد کنید','error')
            }
            this.phone = this.NumberToEn(this.phone);
            this.loading = true;
            axios.post('/api/customer/auth/login',{phone : this.phone}).then(res => {
                this.loading = false;
                if (res.data){
                    AppStorage.AppStorageSetItem('charssu_pre_customer_login',res.data);
                    this.pre_customer_login=true;
                    location.reload();
                }
            }).catch(error=>{
                if (error.response.status === 409){
                    return Sweet.SweetToastMessage(error.response.data,'error');
                }
                Sweet.SweetServerErrorMessage();
                this.loading = false;

            })
        },

        ChangePhone(){
            AppStorage.AppStorageDelItem('charssu_pre_customer_login');
            location.reload();
        },

        SubmitCode(){
            this.code = this.NumberToEn(this.code);
            this.loginloading=true;
            this.errors={};
            axios.post('/api/customer/auth/login-check',{code : this.code,phone:AppStorage.AppStorageGetItem('charssu_pre_customer_login')}).then(res=>{

                Auth.AuthLoginUser(JSON.stringify(res.data.user),res.data.access_token);
                Sweet.SweetToastMessage('باموفقیت وارد حسابتان شدید');
                AppStorage.AppStorageDelItem('charssu_pre_customer_login');
                this.loginloading=false;
                if (appStorage.AppStorageCheckItem('charssu_back_order')){
                    appStorage.AppStorageDelItem('charssu_back_order');
                    setTimeout(() => {
                        window.open('/orders/new','_self');
                    }, 1000);
                }else {
                    setTimeout(() => {
                        window.open('/','_self');
                    }, 1000);
                }

            }).catch(e=>{
                if ( [409,410,411].includes(e.response.status) ){
                    Sweet.SweetToastMessage(e.response.data,'error')
                }else if (e.response.status === 421){
                    this.errors = e.response.data;
                }else{
                    Sweet.SweetServerErrorMessage();
                }
                this.loginloading=false;
            })

        }
    }
}
</script>

<style scoped>

</style>
