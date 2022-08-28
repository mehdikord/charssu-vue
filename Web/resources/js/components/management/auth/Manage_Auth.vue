<template>
    <div class="row justify-content-center mt-5">
        <div class="col-md-5">
            <div class="card">
                <div class="card-body" v-if="!pre_login">
                    <h5 class="text-center mt-2 text-danger">ورود مدیران چارسو</h5>
                    <div class="mt-5 ">
                        <h6 class="text-center form-label mb-4">برای ورود شماره موبایل خود را وارد کنید </h6>
                        <input @keyup.enter="LoginFormSubmit" class="form-control text-center" v-model="phone" placeholder="09XX XXX XXXX">
                    </div>
                    <div class="mt-3 text-center">
                        <button @click="LoginFormSubmit" class="btn btn-success">ورود به مدیریت</button>
                    </div>
                </div>
                <div class="card-body" v-else>
                    <h5 class="text-center mt-2 text-danger">تایید احراز هویت مدیریت</h5>
                    <div class="mt-5 ">
                        <h6 class="text-center form-label mb-4">برای تایید ورود به حساب کد ارسال شده به شماره موبایل خود را وارد کنید </h6>
                        <input @keyup.enter="SubmitCode" class="form-control text-center" v-model="code" placeholder="کد تایید چارسو">
                        <validation_errors :errors="errors" :field="'code'"></validation_errors>

                    </div>
                    <div class="mt-3 text-center">
                        <button @click="SubmitCode" class="btn btn-success mb-4">ارسال کد و تایید احراز هویت</button>
                        <br>
                        <span @click="ChangePhone" class=" app-pointer">
                            تغییر شماره موبایل
                        </span>
                    </div>

                </div>

            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: "Manage_Auth",
    created() {
        if (this.UserAuthCheck()){
            this.$router.push({name : 'manage_dashboard'})
        }

        if (AppStorage.AppStorageCheckItem('charssu_pre_login')){
            this.pre_login=true;
        }
    },

    data(){
        return {
            phone : null,
            code : null,
            loading : false,
            pre_login : false,
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
            axios.post('/api/management/auth/login',{phone : this.phone}).then(res => {
                this.loading = false;
                if (res.data){
                    AppStorage.AppStorageSetItem('charssu_pre_login',res.data);
                    this.pre_login=true;
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
            AppStorage.AppStorageDelItem('charssu_pre_login');
            location.reload();
        },

        SubmitCode(){
            this.code = this.NumberToEn(this.code);
            this.loginloading=true;
            this.errors={};
            axios.post('/api/management/auth/login-check',{code : this.code,phone:AppStorage.AppStorageGetItem('charssu_pre_login')}).then(res=>{

                Auth.AuthLoginUser(JSON.stringify(res.data.user),res.data.access_token);
                Sweet.SweetToastMessage('باموفقیت وارد حسابتان شدید');
                AppStorage.AppStorageDelItem('charssu_pre_login');
                this.loginloading=false;
                setTimeout(() => {
                    window.open('/management/dashboard','_self');
                }, 1000);

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
