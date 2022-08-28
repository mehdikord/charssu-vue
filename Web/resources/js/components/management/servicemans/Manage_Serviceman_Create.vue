<template>

    <page_title :title="'افزودن سرویس کار جدید'"></page_title>

    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title">فرم ایجاد سرویس کار جدید در چارسو</h4>
                    <p class="card-title-desc">

                    </p>
                </div>
                <div class="card-body p-4">

                    <div class="row">
                        <div class="col-12 mb-4">
                            <h6 class="text-danger font-size-14" >اطلاعات شخصی سرویس کار</h6>
                        </div>
                        <div class="col-md-6 mb-4">
                            <label  class="form-label">نام کامل</label>
                            <input v-model="add.name" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'name').length}">
                            <validation_errors :errors="errors" :field="'name'"></validation_errors>
                        </div>
                        <div class="col-md-6 mb-4">
                            <label  class="form-label">شماره موبایل</label>
                            <input v-model="add.phone" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'phone').length}">
                            <validation_errors :errors="errors" :field="'phone'"></validation_errors>
                        </div>
                        <div class="col-md-6 mb-4">
                            <label  class="form-label">کد ملی</label>
                            <input v-model="add.national_code" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'national_code').length}">
                            <validation_errors :errors="errors" :field="'national_code'"></validation_errors>
                        </div>
                        <div class="col-md-6 mb-4">
                            <label  class="form-label">تاریخ تولد</label>
                            <date-picker  format="YYYY/MM/DD"  display-format="jDD/jMM/jYYYY" v-model="add.birthday"  color="#5c6bc0"></date-picker>

                            <validation_errors :errors="errors" :field="'birthday'"></validation_errors>
                        </div>
                        <div class="col-12 mb-4 mt-4">
                            <h6 class="text-danger font-size-14">اطلاعات محل سکونت و مناطق فعالیت</h6>
                        </div>
                        <div class="mb-4 col-md-6">
                            <label  class="form-label">انتخاب استان</label>
                            <select v-model="add.province_id" @change="SelectCity" class="form-control form-select">
                                <option v-for="(province,index) in provinces" :key="index" :value="province.id">
                                    {{province.name}}
                                </option>
                            </select>
                            <validation_errors :errors="errors" :field="'province_id'"></validation_errors>
                        </div>
                        <div class="mb-4 col-md-6">
                            <label  class="form-label">انتخاب شهر</label>
                            <select v-model="add.city_id" class="form-control form-select" @change="SelectZone">
                                <option v-for="(city,index) in cities" :key="index" :value="city.id">
                                    {{city.name}}
                                </option>
                            </select>
                            <validation_errors :errors="errors" :field="'city_id'"></validation_errors>
                        </div>
                        <div class="mb-5 col-md-12">
                            <label  class="form-label">انتخاب مناطق تحت پوشش</label>
                            <div class="alert alert-primary alert-dismissible alert-label-icon label-arrow fade show mt-2 mb-4" role="alert">
                                <i class="mdi mdi-information label-icon"></i><strong>نکته : </strong> منظور از مناطق تحت پوشش ، مناطقی است که سفارشات برای سرویس کار ارسال میگردد
                            </div>
                            <div>
                                <v-select multiple :options="zones" v-model="add.zones" :label="'name'" :reduce="(option) => option.id" />
                            </div>
                            <validation_errors :errors="errors" :field="'city_id'"></validation_errors>
                        </div>
                        <div class="col-md-6 mb-4">
                            <label  class="form-label">آدرس محل سکونت</label>
                            <textarea class="form-control" v-model="add.address" rows="4" :class="{'is-invalid' : this.ValidationErrors(errors,'address').length}"></textarea>
                            <validation_errors :errors="errors" :field="'address'"></validation_errors>
                        </div>
                        <div class="col-md-6 mb-4">
                            <label  class="form-label">آدرس محل کار</label>
                            <textarea class="form-control" v-model="add.work_address" rows="4" :class="{'is-invalid' : this.ValidationErrors(errors,'work_address').length}"></textarea>
                            <validation_errors :errors="errors" :field="'work_address'"></validation_errors>
                        </div>
                        <div class="col-md-6 mb-4">
                            <label  class="form-label text-primary">بازه زمانی فعالیت</label>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <date-picker
                                            v-model="add.start_time"
                                            :placeholder="'از ساعت '"
                                            type="time"
                                            :jump-minute="15"
                                            :round-minute="true"
                                        />
                                        <validation_errors :errors="errors" :field="'start_at'"></validation_errors>

                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <date-picker
                                        v-model="add.end_time"
                                        :placeholder="'تا ساعات'"
                                        type="time"
                                        :jump-minute="15"
                                        :round-minute="true"
                                    />
                                        <validation_errors :errors="errors" :field="'end_at'"></validation_errors>

                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="col-md-6 mb-4">
                            <label  class="form-label">تلفن ثابت</label>
                            <input v-model="add.tel" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'tel').length}">
                            <validation_errors :errors="errors" :field="'tel'"></validation_errors>
                        </div>
                        <div class="col-12 mb-4 mt-4">
                            <h6 class="text-danger font-size-14">مدارک و گواهینامه ها</h6>
                        </div>

                        <div class="mb-5 col-md-12">
                            <label  class="form-label">انتخاب برند های قابل پشتیبانی</label>
                            <div class="alert alert-danger alert-dismissible alert-label-icon label-arrow fade show mt-2 mb-4" role="alert">
                                <i class="mdi mdi-information label-icon"></i><strong>نکته : </strong> سفارشات قابل دریافت برای سرویس کار، سفارشاتی هستند که برند دستگاه آن قابل پشتیبانی توسط سرویس کار باشد
                            </div>
                            <div>
                                <v-select multiple :options="brands" v-model="add.brands" :label="'name'" :reduce="(option) => option.id" />
                            </div>
                            <validation_errors :errors="errors" :field="'city_id'"></validation_errors>
                        </div>

                        <div class="col-12 mb-2">
                            <div class="alert alert-purple alert-dismissible alert-label-icon label-arrow fade show" role="alert">
                                <i class="mdi mdi-information label-icon"></i><strong>نکته : </strong> فایل ارسالی مدارک و گواهینامه ها باید از نوع pdf یا تصویر باشد
                            </div>
                        </div>
                        <div class="col-md-6 mb-4">
                            <label  class="form-label">تصویر پروفایل</label>
                            <input @change="ProfileFile" ref="profile" class="form-control" type="file" >
                        </div>
                        <div class="col-md-6 mb-4">
                            <label  class="form-label">مدرک فنی</label>
                            <input @change="DocFileHandler('technical')" ref="technical" class="form-control" type="file" >
                        </div>
                        <div class="col-md-6 mb-4">
                            <label  class="form-label">گواهی عدم سؤپیشینه</label>
                            <input @change="DocFileHandler('police')" ref="police" class="form-control" type="file" >
                        </div>
                        <div class="col-md-6 mb-4">
                            <label  class="form-label">گواهی عدم اعتیاد</label>
                            <input @change="DocFileHandler('addictions')"  ref="addictions" class="form-control" type="file" >
                        </div>
                        <div class="col-12 mt-3">
                            <button @click="CreateItem" :disabled="add_loading" class="btn btn-success font-size-15">ایجاد سرویس کار جدید <i v-if="add_loading" class="bx bx-hourglass bx-spin font-size-20 align-middle"></i></button>
                        </div>


                    </div>

                </div>
            </div>
        </div>

    </div>

</template>

<script>
import vSelect from 'vue-select'
import 'vue-select/dist/vue-select.css';
import Sweet from "../../../helpers/Sweet";

export default {
    name: "Manage_Serviceman_Create",
    components:{
        vSelect,
    },

    created() {
        this.GetProvinces();
        this.GetBrands();
    },

    data(){
        return {

            add_loading : false,
            add : {
                province_id : null,
                city_id : null,
                name : null,
                phone : null,
                national_code : null,
                birthday : null,
                address : null,
                zones:[],
                brands:[],
                work_address : null,
                tel : null,
                technical_license : null,
                police_certificate : null,
                non_addictions : null,
                start_time : null,
                end_time : null,
                profile : null,

            },
            item_loading:false,
            items : [],
            errors:[],
            provinces:[],
            brands:[],
            cities:[],
            zones:[],

        }
    },


    methods:{

        CreateItem(){
            this.add_loading=true;
            let data = new FormData();
            if (this.add.phone !== null){data.append('phone',this.NumberToEn(this.add.phone))}
            if (this.add.national_code !== null){data.append('national_code',this.NumberToEn(this.add.national_code))}
            if (this.add.tel !== null){data.append('tel',this.NumberToEn(this.add.tel))}
            if (this.add.province_id !== null){data.append('province_id',this.add.province_id)}
            if (this.add.city_id !== null){data.append('city_id',this.add.city_id)}
            if (this.add.name !== null){data.append('name',this.add.name)}
            if (this.add.birthday !== null){data.append('birthday',this.add.birthday)}
            if (this.add.address !== null){data.append('address',this.add.address)}
            if (this.add.work_address !== null){data.append('work_address',this.add.work_address)}
            if (this.add.start_time !== null){data.append('start_time',this.add.start_time)}
            if (this.add.end_time !== null){data.append('end_time',this.add.end_time)}
            if (this.add.technical_license !== null){data.append('technical_license',this.add.technical_license,this.add.technical_license.name)}
            if (this.add.police_certificate !== null){data.append('police_certificate',this.add.police_certificate,this.add.police_certificate.name)}
            if (this.add.non_addictions !== null){data.append('non_addictions',this.add.non_addictions,this.add.non_addictions.name)}
            if (this.add.profile !== null){data.append('profile',this.add.profile,this.add.profile.name)}
            data.append('zones',this.add.zones)
            data.append('brands',this.add.brands)

            axios.post('/api/management/servicemans',data,
                {
                    headers: {
                        'Content-Type': 'multipart/form-data'
                    }
                }
            ).then( res => {
                this.add_loading=false;
                this.$router.push({name : 'manage_servicemans'});
                Sweet.SweetToastMessage('سرویس کار جدید باموفقیت ایجاد و پذیرفته شد');

            }).catch(error => {
                this.add_loading=false;
                if (error.response.status === 421){
                    this.errors = error.response.data
                }else {
                    Sweet.SweetServerErrorMessage()
                }
            })

        },

        DocFileHandler(type){
            if (type==='technical'){
                if (this.$refs.technical.files.length){
                    let file = this.$refs.technical.files[0];
                    if (file.type !== 'application/pdf' && file.type !== 'image/jpeg' && file.type !== 'image/png'){
                        return Sweet.SweetFileTypeError('pdf / image');
                    }else {
                        this.add.technical_license = file;
                    }
                }


            }
            if (type==='police'){
                if (this.$refs.police.files.length){
                    let file = this.$refs.police.files[0];
                    if (file.type !== 'application/pdf' && file.type !== 'image/jpeg' && file.type !== 'image/png'){
                        return Sweet.SweetFileTypeError('pdf / image');
                    }else {
                        this.add.police_certificate = file;
                    }
                }


            }
            if (type==='addictions'){
                if (this.$refs.addictions.files.length){
                    let file = this.$refs.addictions.files[0];
                    if (file.type !== 'application/pdf' && file.type !== 'image/jpeg' && file.type !== 'image/png'){
                        return Sweet.SweetFileTypeError('pdf / image');
                    }else {
                        this.add.non_addictions = file;
                    }
                }


            }
        },

        ProfileFile(){
            if (this.$refs.profile.files.length){
                let file = this.$refs.profile.files[0];
                if (file.type !== 'image/jpeg' && file.type !== 'image/png'){
                    return Sweet.SweetFileTypeError('png - jpg');
                }else {
                    this.add.profile = file;
                }
            }
        },

        GetProvinces(){
            axios.get('/api/management/helpers/get/provinces').then(res => {
                this.provinces = res.data;
            }).catch(e => {
                Sweet.SweetServerErrorMessage();
            })
        },

        GetBrands(){
            axios.get('/api/management/helpers/get/brands').then(res => {
                this.brands = res.data;
            }).catch(e => {
                Sweet.SweetServerErrorMessage();
            })
        },

        SelectCity(){

            if (this.add.province_id !== null){
                let cities = this.provinces.filter(item => {
                    return this.add.province_id === item.id;
                })
                this.cities = cities[0].cities;
                this.add.city_id = this.cities[0].id;
                this.SelectZone();
                console.log(this.zones);
            }

        },

        SelectZone(){
            if (this.add.province_id !== null && this.add.city_id !== null){
                let cities = this.provinces.filter(item => {
                    return this.add.province_id === item.id;
                })
                let zones = cities[0].cities.filter(city => {
                    return this.add.city_id === city.id;
                })
                this.zones = zones[0].zones
                this.add.zones=[];


            }
        },

    }
}
</script>
<style src="vue-multiselect/dist/vue-multiselect.css"></style>

<style scoped>

</style>
