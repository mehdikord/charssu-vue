<template>

    <div class="page-title-area">
        <div class="d-table">
            <div class="d-table-cell">
                <div class="container">
                    <div class="page-title-content">
                        <h2>فرم ثبت درخواست جدید </h2>
                        <ul>
                            <li><router-link :to="{name : 'front_index'}">صفحه اصلی</router-link></li>
                            <li>درخواست جدید</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid">
        <div class="row justify-content-center pt-5 pb-5">
            <div class="col-md-8 app-fade-in">
                <div class="card-body">
                    <div class="alert alert-primary shadow ">
                        کاربر گرامی لطفا اطلاعات خواسته شده را بادقت کامل نمایید ، پس از ثبت درخواست <strong>چارسو</strong> سرویس کار متناسب با کار شما را انتخاب میکند
                        <br>
                        از صبر و شکبیایی ما سپاس گذاریم
                    </div>
                </div>
            </div>

            <template v-if="!UserAuthCheck()">
                <div class="col-12 mb-4"></div>
                <div class="col-md-4 app-fade-in">
                    <div class="card-body shadow rounded-3">
                        <div>
                            <h6 class="text-center text-danger">برای ثبت سفارش ابتدا باید وارد حساب کاربری خود شوید</h6>
                            <div class="mt-5">
                                <div class="text-center">
                                    برای ورود به حساب یا ثبت نام کافیست شماره موبایل خود را وارد کنید
                                </div>
                                <div class="mt-4">
                                    <input v-model="phone" dir="ltr" class="form-control" placeholder="09XX XXX XXXX">
                                </div>
                                <div class="mt-4 text-center mb-4">
                                    <button @click="LoginFormSubmit" class="btn btn-success">ورود یا ثبت نام در چارسو</button>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </template>
            <template v-else>
                <div class="col-8 app-fade-in">
                    <div class="card-body shadow rounded-3">
                        <h6 class="text-danger">مشخصات محصول</h6>
                        <hr>
                        <div class="form-row mt-4">
                            <div class="col-md-6 form-group">
                                <label class="form-label">انتخاب برند محصول</label>
                                <loading1 v-if="brandsloading" :text="'درحال دریافت برند ها'"></loading1>
                                <select @change="GetDevice" v-else class="form-control mt-2 is-" v-model="form.device_brand_id" :class="{'is-invalid' : this.ValidationErrors(errors,'device_brand_id').length}">
                                    <option  v-for="(brand,index) in brands" :key="index+'_brand'" :value="brand.id">{{brand.name}}</option>
                                </select>
                                <validation_errors :errors="errors" :field="'device_brand_id'"></validation_errors>
                            </div>
                            <div class="col-md-6 form-group">
                                <label class="form-label"> انتخاب مدل محصول</label>
                                <loading1 v-if="devicesloading" class="mt-2" :text="'ابتدا برند محصول را انتخاب کنید'"></loading1>
                                <select v-else class="form-control mt-2 app-fade-in" v-model="form.device_id" :class="{'is-invalid' : this.ValidationErrors(errors,'device_id').length}">
                                    <option v-for="(device,index) in devices" :key="index+'_device'" :value="device.id">{{device.name}}</option>
                                </select>
                                <validation_errors :errors="errors" :field="'device_id'"></validation_errors>

                            </div>
                            <div class="col-md-6 form-group mt-3">
                                <label class="form-label"> محصول شمال گارانتی است </label>
                                <select  class="form-control mt-2" v-model="form.warranty">
                                    <option value="1">بله</option>
                                    <option value="0">خیر</option>
                                </select>
                            </div>
                            <div v-if="this.form.warranty === '1'" class="col-md-6 form-group mt-3 app-fade-in">
                                <label class="form-label"> تاریخ گارانتی محصول </label>
                                <date-picker  format="YYYY/MM/DD"  display-format="jDD/jMM/jYYYY" v-model="form.warranty_date"  color="#5c6bc0" :class="{'is-invalid' : this.ValidationErrors(errors,'warranty_date').length}"></date-picker>
                                <validation_errors :errors="errors" :field="'warranty_date'"></validation_errors>

                            </div>

                        </div>
                    </div>
                </div>
                <div class="col-8 app-fade-in mt-5">
                    <div class="card-body shadow rounded-3">
                        <h6 class="text-danger">ثبت مشکلات دستگاه</h6>
                        <hr>
                        <div class="form-row mt-4">
                            <div class="col-md-12 form-group">
                                <label class="form-label">پکیج شما چه مشکلی دارد  ؟</label>
                                <loading1 v-if="problemsloading" :text="'درحال دریافت لیست مشکلات'"></loading1>
                                <select v-else class="form-control mt-2" v-model="form.problem_id" :class="{'is-invalid' : this.ValidationErrors(errors,'problem_id').length}">
                                    <option v-for="(problem,index) in problems" :key="index+'_problem'" :value="problem.id">{{problem.problem}}</option>
                                </select>
                                <validation_errors :errors="errors" :field="'problem_id'"></validation_errors>

                            </div>
                            <div class="col-md-12 form-group mt-3">
                                <label class="form-label">توضیحات تکمیلی در مورد مشکل</label>
                                <textarea class="form-control" rows="5" v-model="form.description"></textarea>
                            </div>
                            <div class="col-md-12 form-group mt-3">
                                <label class="form-label">افزودن تصویر از دستگاه </label>
                                <input class="form-control" type="file" ref="image" @change="ImageFileHandler"  >
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-8 app-fade-in mt-5">
                    <div class="card-body shadow rounded-3">
                        <h6 class="text-danger">ثبت مشخصات فردی و اطلاعات آدرس</h6>
                        <hr>
                        <div class="form-row mt-4">
                            <div class="col-md-6 form-group">
                                <label class="form-label">نام کامل</label>
                                <input type="text" v-model="user.name" class="form-control mt-1" :class="{'is-invalid' : this.ValidationErrors(errors,'name').length}">
                                <validation_errors :errors="errors" :field="'name'"></validation_errors>

                            </div>
                            <div class="col-md-6 form-group">
                                <label class="form-label">شماره موبایل</label>
                                <input disabled type="text" :value="user.phone" class="form-control mt-1">

                            </div>

                            <div class="col-md-6 form-group">
                                <label class="form-label">استان</label>
                                <select @change="SelectCity" class="form-control mt-1" v-model="user.province_id" :class="{'is-invalid' : this.ValidationErrors(errors,'province_id').length}">
                                    <option  v-for="(province,index) in provinces" :key="index+'_province'" :value="province.id">{{province.name}}</option>
                                </select>
                                <validation_errors :errors="errors" :field="'province_id'"></validation_errors>

                            </div>
                            <div class="col-md-6 form-group">
                                <label class="form-label">شهر</label>
                                <select @change="SelectZone"  class="form-control mt-1" v-model="user.city_id" :class="{'is-invalid' : this.ValidationErrors(errors,'city_id').length}">
                                    <option   v-for="(city,index) in cities" :key="index+'_city'" :value="city.id">{{city.name}}</option>
                                </select>
                                <validation_errors :errors="errors" :field="'city_id'"></validation_errors>

                            </div>
                            <div class="col-md-6 form-group">
                                <label class="form-label">منطقه</label>
                                <select class="form-control mt-1" v-model="user.zone_id" :class="{'is-invalid' : this.ValidationErrors(errors,'zone_id').length}">
                                    <option  v-for="(zone,index) in zones" :key="index+'_zone'" :value="zone.id">{{zone.name}}</option>
                                </select>
                                <validation_errors :errors="errors" :field="'zone_id'"></validation_errors>

                            </div>
                            <div class="col-md-12 form-group mt-3">
                                <label class="form-label">آدرس کامل محل</label>
                                <textarea class="form-control" v-model="user.address" rows="5" :class="{'is-invalid' : this.ValidationErrors(errors,'address').length}">
                                </textarea>
                                <validation_errors :errors="errors" :field="'address'"></validation_errors>
                            </div>
                            <div class="col-12 mt-5 mb-5">
                                <div class="text-center">
                                    <button :disabled="confirmloading" @click="ConfirmOrder" class="btn btn-success p-3">
                                        ثبت درخواست و جستجو سرویس کار
                                    </button>
                                </div>

                            </div>

                        </div>
                    </div>
                </div>


            </template>

        </div>
    </div>



</template>

<script>
import Front_Inc_Loading1 from "../includes/Front_Inc_Loading1";
import Sweet from "../../../helpers/Sweet";


export default {
    name: "Front_Orders_New",


    components:{
        'loading1' : Front_Inc_Loading1,

    },

    created() {
        //check Auth
        if (!this.UserAuthCheck()){
            AppStorage.AppStorageSetItem('charssu_back_order','yes');
        }else {
            axios.get('/api/customer/profile').then(res => {
                this.user = res.data
                console.log(this.user)
            }).catch(e => {
                Sweet.SweetServerErrorMessage();
            })

        }

        this.GetBrands();
        this.GetProblems();
        this.GetProvinces();
    },

    data(){
        return {
            errors:[],
            brands:[],
            devices:[],
            problems:[],
            provinces:[],
            cities:[],
            zones:[],
            form :{
                device_brand_id : null,
                device_id:null,
                problem_id:null,
                warranty:0,
                warranty_date:null,
                description:null,
                image:null,
            },
            user : {
                name:null,
                province_id:null,
                city_id:null,
                zone_id:null,
                phone:null,
                tel:null,
                address:null,
            },
            brandsloading:true,
            devicesloading:true,
            problemsloading:true,
            provincesloading:true,
            confirmloading:false,
            phone : null,


        }
    },


    methods :{
        GetBrands(){
            axios.get('/api/helpers/get/brands').then(res =>{
                this.brands = res.data;
                this.brandsloading = false;
            })
        },
        GetDevice(){
              let filter = this.brands.filter(brand => {
                  return brand.id === this.form.device_brand_id
              });
              this.devices = filter[0].devices;
              if (this.devices.length){
                  this.form.device_id = this.devices[0].id;
              }
              this.devicesloading = false;
        },
        GetProblems(){
            axios.get('/api/helpers/get/problems').then(res =>{
                this.problems = res.data;
                this.problemsloading = false;
            })
        },
        GetProvinces(){
            axios.get('/api/helpers/get/provinces').then(res =>{
                this.provinces = res.data;
                this.provincesloading = false;
            })
        },
        SelectCity(){

            if (this.user.province_id !== null){
                let cities = this.provinces.filter(item => {
                    return this.user.province_id === item.id;
                })
                this.cities = cities[0].cities;
                this.user.city_id = this.cities[0].id;
                this.SelectZone();
            }

        },
        SelectZone(){
            if (this.user.province_id !== null && this.user.city_id !== null){
                let cities = this.provinces.filter(item => {
                    return this.user.province_id === item.id;
                })
                let zones = cities[0].cities.filter(city => {
                    return this.user.city_id === city.id;
                })
                this.zones = zones[0].zones
                if (this.zones.length){
                    this.user.zone_id = this.zones[0].id;
                }


            }
        },
        ImageFileHandler(){
            if (this.$refs.image.files.length){
                let file = this.$refs.image.files[0];
                if (file.type !== 'image/jpeg' && file.type !== 'image/png'){
                    return Sweet.SweetFileTypeError('png - jpg');
                }else {
                    this.form.image = file;
                }
            }
        },
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
                    window.open('/auth','self')
                }
            }).catch(error=>{
                if (error.response.status === 409){
                    return Sweet.SweetToastMessage(error.response.data,'error');
                }
                Sweet.SweetServerErrorMessage();
                this.loading = false;

            })
        },
        ConfirmOrder(){
            this.confirmloading = true;
            let data = new FormData();
            if (this.form.device_brand_id !== null){data.append('device_brand_id',this.form.device_brand_id)}
            if (this.form.device_id !== null){data.append('device_id',this.form.device_id)}
            if (this.form.problem_id !== null){data.append('problem_id',this.form.problem_id)}
            if (this.form.warranty !== null){data.append('warranty',this.form.warranty)}
            if (this.form.warranty_date !== null){data.append('warranty_date',this.form.warranty_date)}
            if (this.form.description !== null){data.append('description',this.form.description)}
            if (this.form.image !== null){data.append('image',this.form.image,this.form.image.name)}
            if (this.user.name !== null){data.append('name',this.user.name)}
            if (this.user.province_id !== null){data.append('province_id',this.user.province_id)}
            if (this.user.city_id !== null){data.append('city_id',this.user.city_id)}
            if (this.user.zone_id !== null){data.append('zone_id',this.user.zone_id)}
            if (this.user.address !== null){data.append('address',this.user.address)}

            axios.post('/api/customer/orders/new',data,{
                headers: {
                    'Content-Type': 'multipart/form-data'
                }
            }).then(res => {
                this.$router.push({name : 'front_index'})
                return Sweet.SweetAlertMessage('کاربر گرامی سفارش شما باموفقیت ثبت گردید، چارسو در سریع ترین زمان ممکن سرویس کار موردنظر شما را انتخاب میکند، اطلاعات سرویس کار از طریق پیامک برای شما ارسال میشود. همچنین میتوانید اطلاعات کامل و وضعیت سفارش را در پنل کاربری خود مشاهده کنید','','success');
            }).catch( error => {
                this.confirmloading=false;
                if (error.response.status === 421){
                    this.errors = error.response.data
                    Sweet.SweetToastMessage('اطلاعات شما ناقص است !','error');
                }else {
                    Sweet.SweetServerErrorMessage()
                }
            })

        }
    }
}
</script>

<style scoped>

</style>
