<template>
    <div class="card">
        <div class="card-body">
            <h6 class="text-danger">اطلاعات حساب کاربری</h6>
            <hr>
            <div class="mt-5 mb-3">
                <div class="form-row">
                    <div class="col-md-4 mb-4 form-group">
                        <label class="form-label text-secondary">نام و نام خانوادگی</label>
                        <input type="text" class="form-control" v-model="user.name" >
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
                        <input type="text"  class="form-control" v-model="user.tel" >
                    </div>
                    <div class="col-md-12 mb-4 form-group">
                        <label class="form-label text-secondary">آدرس کامل محل سکونت</label>
                        <textarea class="form-control" rows="6" v-model="user.address"></textarea>
                    </div>

                </div>
                <div class="text-center mt-5">
                    <button class="btn btn-success font-16 pr-5 pl-5 pt-2 pb-2">بروز رسانی اطلاعات کاربری</button>
                </div>
            </div>
        </div>
    </div>
</template>

<script>

export default {
    name: "Customer_Profile",
    created() {
        this.GetProfile();
        this.GetProvinces();

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
        }
    },
    methods : {
        GetProfile(){
            axios.get('/api/customer/profile').then(res => {
                this.user = res.data
                console.log(this.user)
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
    }

}
</script>

<style scoped>

</style>
