<template>
    <div class="container-fluid">
        <div class="row mt-5 mb-5">
            <div class="col-md-3 mb-3">
                <main_menu class="app-fade-in"></main_menu>
            </div>
            <div class="col-md-9">
                <div class="card app-fade-in">
                    <div class="card-body">
                        <h6 class="text-danger">اطلاعات حساب کاربری</h6>
                        <hr>
                        <div class="mt-5 mb-3">
                            <div class="form-row">
                                <div class="col-md-4 mb-4 form-group">
                                    <label class="form-label text-secondary">نام و نام خانوادگی</label>
                                    <input type="text" class="form-control" v-model="user.name" :class="{'is-invalid' : this.ValidationErrors(errors,'name').length}">
                                    <validation_errors :errors="errors" :field="'name'"></validation_errors>
                                </div>
                                <div class="col-md-4 mb-4 form-group ">
                                    <label class="form-label text-secondary">شماره موبایل</label>
                                    <input type="text"  class="form-control" v-model="user.phone" disabled>
                                </div>
                                <div class="col-md-4 mb-4 form-group">
                                    <label class="form-label text-secondary">کد چارسو</label>
                                    <input type="text"  class="form-control" v-model="user.code" disabled>
                                </div>
                                <div class="col-md-4 mb-4 form-group">
                                    <label class="form-label text-secondary">استان</label>
                                    <select @change="SelectCity" class="form-control mt-1" v-model="user.province_id" :class="{'is-invalid' : this.ValidationErrors(errors,'province_id').length}">
                                        <option  v-for="(province,index) in provinces" :key="index+'_province'" :value="province.id">{{province.name}}</option>
                                    </select>
                                </div>
                                <div class="col-md-4 mb-4 form-group">
                                    <label class="form-label text-secondary">شهر</label>
                                    <select @change="SelectZone"  class="form-control mt-1" v-model="user.city_id" :class="{'is-invalid' : this.ValidationErrors(errors,'city_id').length}">
                                        <option   v-for="(city,index) in cities" :key="index+'_city'" :value="city.id">{{city.name}}</option>
                                    </select>
                                    <validation_errors :errors="errors" :field="'city_id'"></validation_errors>
                                </div>
                                <div class="col-md-4 mb-4 form-group">
                                    <label class="form-label text-secondary">منطقه</label>
                                    <select class="form-control mt-1" v-model="user.zone_id" :class="{'is-invalid' : this.ValidationErrors(errors,'zone_id').length}">
                                        <option  v-for="(zone,index) in zones" :key="index+'_zone'" :value="zone.id">{{zone.name}}</option>
                                    </select>
                                    <validation_errors :errors="errors" :field="'zone_id'"></validation_errors>
                                </div>
                                <div class="col-md-4 mb-4 form-group">
                                    <label class="form-label text-secondary">تلفن ثابت (اختیاری)</label>
                                    <input type="text"  class="form-control" v-model="user.tel" :class="{'is-invalid' : this.ValidationErrors(errors,'tel').length}">
                                    <validation_errors :errors="errors" :field="'tel'"></validation_errors>

                                </div>
                                <div class="col-md-12 mb-4 form-group">
                                    <label class="form-label text-secondary">آدرس کامل محل سکونت</label>
                                    <textarea class="form-control" rows="6" v-model="user.address" :class="{'is-invalid' : this.ValidationErrors(errors,'address').length}"></textarea>
                                    <validation_errors :errors="errors" :field="'address'"></validation_errors>

                                </div>

                            </div>
                            <div class="text-center mt-5">
                                <button @click="UpdateProfile" class="btn btn-success font-16 pr-5 pl-5 pt-2 pb-2">بروز رسانی اطلاعات کاربری</button>
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
    name: "Customer_Profile",
    components : {
        main_menu : Customer_Main_Menu
    },
    created() {
        this.GetProvinces();
        this.GetProfile();

    },
    data(){
        return {
            user : {
                name:null,
                code:null,
                province_id:null,
                city_id:null,
                zone_id:null,
                phone:null,
                tel:null,
                address:null,
            },
            provinces:[],
            cities:[],
            zones:[],
            errors:[],
        }
    },
    methods : {
        GetProfile(){

            axios.get('/api/customer/profile').then(res => {
                this.user = res.data
                if (this.user.province_id !== null){
                    this.SelectCity();

                }
            }).catch(e => {
                Sweet.SweetServerErrorMessage();
            })

        },

        GetProvinces(){
            axios.get('/api/helpers/get/provinces').then(res =>{
                this.provinces = res.data;
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

        UpdateProfile(){
            axios.post('/api/customer/profile',this.user).then(res => {
                this.errors=[];
                Sweet.SweetAlertMessage('اطلاعات حساب کاربری شما باموفقیت بروزرسانی شد','انجام شد','success');

            }).catch(error => {
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
