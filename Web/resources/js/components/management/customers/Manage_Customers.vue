<template>
    <page_title :title="'مدیریت مشتریان سیستم'"></page_title>
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <div class="row mb-2">
                        <div class="col-sm-4">
                            <div class="search-box me-2 mb-2 d-inline-block">
                                <div class="position-relative">
                                    <input v-model="search" @change="SearchItem" type="text" class="form-control" placeholder="جستجو ...">
                                    <i class="bx bx-search-alt search-icon"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-8">
                            <div class="text-sm-end">
                                <button type="button" data-bs-toggle="modal" data-bs-target="#new_item" class="btn btn-primary btn-rounded waves-effect waves-light mb-2 me-2"><i class="mdi mdi-plus me-1"></i> افزودن آیتم جدید</button>
                            </div>
                            <div class="modal fade" id="new_item" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
                                 aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="myLargeModalLabel">افزودن آیتم جدید</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="row">
                                                <div class="mb-4 col-md-6">
                                                    <label  class="form-label">نام مشتری</label>
                                                    <input v-model="add.name" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'name').length}">
                                                    <validation_errors :errors="errors" :field="'name'"></validation_errors>
                                                </div>
                                                <div class="mb-4 col-md-6">
                                                    <label  class="form-label">شماره موبایل</label>
                                                    <input v-model="add.phone" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'phone').length}">
                                                    <validation_errors :errors="errors" :field="'phone'"></validation_errors>
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
                                                    <select v-model="add.city_id" @change="SelectZone" class="form-control form-select">
                                                        <option v-for="(city,index) in cities" :key="index" :value="city.id">
                                                            {{city.name}}
                                                        </option>
                                                    </select>
                                                    <validation_errors :errors="errors" :field="'city_id'"></validation_errors>
                                                </div>
                                                <div class="mb-4 col-md-6">
                                                    <label  class="form-label">انتخاب منطقه</label>
                                                    <select v-model="add.zone_id" class="form-control form-select">
                                                        <option v-for="(zone,index) in zones" :key="index" :value="zone.id">
                                                            {{zone.name}}
                                                        </option>
                                                    </select>
                                                    <validation_errors :errors="errors" :field="'zone_id'"></validation_errors>
                                                </div>
                                                <div class="mb-4 col-md-6">
                                                    <label  class="form-label">شماره تلفن ثابت</label>
                                                    <input v-model="add.tel" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'tel').length}">
                                                    <validation_errors :errors="errors" :field="'tel'"></validation_errors>
                                                </div>
                                                <div class="mb-4 col-md-12">
                                                    <label  class="form-label">آدرس کامل</label>
                                                    <textarea class="form-control" v-model="add.address" rows="5"></textarea>
                                                    <validation_errors :errors="errors" :field="'address'"></validation_errors>
                                                </div>


                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary waves-effect" data-bs-dismiss="modal">
                                                <i class="bx bx-x font-size-18 align-middle"></i> بستن
                                            </button>
                                            <button @click="CreateItem" type="button" class="btn btn-success waves-effect waves-light">
                                                <i class="bx bx-check font-size-18 align-middle" :class="{'bx-hourglass bx-spin' : add_loading}"></i>  ایجاد آیتم
                                            </button>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div v-if="item_loading === false" class="table-responsive">
                        <table v-if="SearchItem.length > 0" class="table align-middle table-nowrap table-bordered">
                            <thead>
                            <tr>
                                <th>#</th>
                                <th>نام</th>
                                <th>موبایل</th>
                                <th>استان</th>
                                <th>شهر</th>
                                <th>منطقه</th>
                                <th>کد مشتری</th>
                                <th>وضعیت</th>
                                <th>ابزار</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr class="app-fade-in" v-for="(item,index) in SearchItem" :key="index">
                                <td width="10">
                                    <div class="form-check font-size-16">
                                        <input class="form-check-input" type="checkbox" id="customerlistcheck01">
                                        <label class="form-check-label" for="customerlistcheck01"></label>
                                    </div>
                                </td>
                                <td>
                                    {{ item.name }}
                                </td>
                                <td>
                                    {{ item.phone }}
                                </td>
                                <td>
                                    <template v-if="item.province !== null">
                                        {{ item.province.name }}
                                    </template>

                                </td>
                                <td>
                                    <template v-if="item.city !== null">
                                    {{ item.city.name }}
                                    </template>
                                </td>
                                <td>
                                    <template v-if="item.zone !== null">
                                    {{ item.zone.name }}
                                    </template>
                                </td>
                                <td>
                                    <span class="badge rounded-pill badge-soft-danger font-size-12 fw-medium p-2">
                                        {{ item.code }}
                                    </span>

                                </td>
                                <td class="text-center">
                                    <div class="square-switch">
                                        <input @change="ChangeActivation(item.id)" type="checkbox" :id="'square-switch3'+item.id" switch="bool" :checked="item.is_active">
                                        <label :for="'square-switch3'+item.id" data-on-label="YES" data-off-label="NO"></label>
                                    </div>
                                </td>
                                <td>
                                    <button @click="EditSelectCity(item.id)" data-bs-toggle="modal" :data-bs-target="'#edit_item'+item.id" title="ویرایش آیتم" type="button" class="btn btn-sm btn-primary waves-effect waves-light me-2"><i class="bx bx-edit font-size-16 align-middle"></i></button>
                                    <button @click="DelItem(item.id)" title="حذف آیتم" type="button" class="btn btn-sm btn-danger waves-effect waves-light me-2"><i class="bx bx-trash font-size-16 align-middle"></i></button>

                                    <div class="modal fade" :id="'edit_item'+item.id" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
                                         aria-hidden="true">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">ویرایش آیتم : {{ item.name }}</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">

                                                    <div class="row">
                                                        <div class="mb-4 col-md-6">
                                                            <label  class="form-label">نام مشتری</label>
                                                            <input v-model="edit.name[item.id]" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'name').length}">
                                                            <validation_errors :errors="errors" :field="'name'"></validation_errors>
                                                        </div>
                                                        <div class="mb-4 col-md-6">
                                                            <label  class="form-label">شماره موبایل</label>
                                                            <input v-model="edit.phone[item.id]" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'phone').length}">
                                                            <validation_errors :errors="errors" :field="'phone'"></validation_errors>
                                                        </div>
                                                        <div class="mb-4 col-md-6">
                                                            <label  class="form-label">انتخاب استان</label>
                                                            <select v-model="edit.province_id[item.id]"  @change="EditSelectCity(item.id)" class="form-control">
                                                                <option v-for="(province,index) in provinces" :key="index" :value="province.id">
                                                                    {{province.name}}
                                                                </option>
                                                            </select>
                                                            <validation_errors :errors="errors" :field="'province_id'"></validation_errors>
                                                        </div>
                                                        <div class="mb-4 col-md-6">
                                                            <label  class="form-label">انتخاب شهر</label>
                                                            <select v-model="edit.city_id[item.id]" @change="EditSelectZone(item.id)" class="form-control">
                                                                <option v-for="(city,index) in cities" :key="index" :value="city.id">
                                                                    {{city.name}}
                                                                </option>
                                                            </select>
                                                            <validation_errors :errors="errors" :field="'city_id'"></validation_errors>
                                                        </div>
                                                        <div class="mb-4 col-md-6">
                                                            <label  class="form-label">انتخاب منطقه</label>
                                                            <select v-model="edit.zone_id[item.id]" class="form-control">
                                                                <option v-for="(zone,index) in zones" :key="index" :value="zone.id">
                                                                    {{zone.name}}
                                                                </option>
                                                            </select>
                                                            <validation_errors :errors="errors" :field="'zone_id'"></validation_errors>
                                                        </div>
                                                        <div class="mb-4 col-md-6">
                                                            <label  class="form-label">شماره تلفن ثابت</label>
                                                            <input v-model="edit.tel[item.id]" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'tel').length}">
                                                            <validation_errors :errors="errors" :field="'tel'"></validation_errors>
                                                        </div>
                                                        <div class="mb-4 col-md-12">
                                                            <label  class="form-label">آدرس کامل</label>
                                                            <textarea class="form-control" v-model="edit.address[item.id]" rows="5"></textarea>
                                                            <validation_errors :errors="errors" :field="'address'"></validation_errors>
                                                        </div>


                                                    </div>

                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary waves-effect" data-bs-dismiss="modal">
                                                        <i class="bx bx-x font-size-18 align-middle"></i> بستن
                                                    </button>
                                                    <button @click="EditItem(item.id)" type="button" class="btn btn-success waves-effect waves-light">
                                                        <i class="bx bx-check font-size-18 align-middle" :class="{'bx-hourglass bx-spin' : add_loading}"></i>  ویرایش آیتم
                                                    </button>

                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </td>
                            </tr>

                            </tbody>
                        </table>
                        <nodata v-else></nodata>

                    </div>
                    <item_loading v-else></item_loading>

                </div>
            </div>
        </div>
    </div>

</template>

<script>
import Swal from "sweetalert2";

export default {
    name: "Manage_Customers",
    created() {
        this.GetItems();
        this.GetProvinces();
    },

    data(){
        return {
            add : {
                province_id : null,
                city_id : null,
                zone_id : null,
                name : null,
                phone : null,
                address : null,
                tel : null,

            },
            edit:{
                province_id : [],
                city_id : [],
                zone_id : [],
                name : [],
                phone : [],
                address : [],
                tel : [],
            },
            add_loading:false,
            item_loading:false,
            items : [],
            errors:[],
            provinces:[],
            cities:[],
            zones:[],
            search:'',

        }
    },

    methods:{
        GetItems(){
            this.item_loading=true;
            axios.get('/api/management/customers').then(res => {
                this.item_loading=false;
                this.items=res.data;
                res.data.forEach(item=>{
                    this.edit.name[item.id] = item.name;
                    this.edit.province_id[item.id] = item.province_id;
                    this.edit.city_id[item.id] = item.city_id;
                    this.edit.zone_id[item.id] = item.zone_id;
                    this.edit.phone[item.id] = item.phone;
                    this.edit.address[item.id] = item.address;
                    this.edit.tel[item.id] = item.tel;
                })

            }).catch(error => {
                this.item_loading=false;
                Sweet.SweetServerErrorMessage();
            })
        },

        CreateItem(){
            this.add_loading=true;
            if (this.add.phone !== null){this.add.phone = this.NumberToEn(this.add.phone)}
            axios.post('/api/management/customers',this.add).then(res => {
                $('#new_item').modal('hide');
                Sweet.SweetAddItem();
                this.EmptyAdd();
                this.items.push(res.data);
                this.add_loading=false;
            }).catch(error => {
                this.add_loading=false;
                if (error.response.status === 421){
                    this.errors = error.response.data
                }else {
                    Sweet.SweetServerErrorMessage()
                }
            })

        },

        EditItem(id){
            this.add_loading=true;
            if (this.add.phone !== null){this.add.phone = this.NumberToEn(this.add.phone)}
            let data = {
                name : this.edit.name[id],
                province_id : this.edit.province_id[id],
                city_id : this.edit.city_id[id],
                zone_id : this.edit.zone_id[id],
                phone : this.edit.phone[id],
                address : this.edit.address[id],
                tel : this.edit.tel[id],
            }

            axios.put('/api/management/customers/'+id,data).then(res => {
                this.GetItems();
                $('#edit_item'+id).modal('hide');
                Sweet.SweetEditItem();
                this.add_loading=false;
            }).catch(error => {
                this.add_loading=false;
                if (error.response.status === 421){
                    this.errors = error.response.data
                }else {
                    Sweet.SweetServerErrorMessage()
                }
            })


        },

        DelItem(id){
            Swal.fire({
                title: 'آیا مطمئن هستید',
                text: "آیتم مورد نظر حذف شود ؟",
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: '#26a852',
                cancelButtonColor: '#d33',
                cancelButtonText : 'خیر',
                confirmButtonText: 'حذف شود'
            }).then((result) => {
                if (result.isConfirmed) {
                    axios.delete('/api/management/customers/'+id).then(res =>{
                        Sweet.SweetDeleteItem()
                        this.GetItems();
                    }).catch(e=>{
                        Sweet.SweetServerErrorMessage();
                    })
                }
            })
        },

        EmptyAdd(){
            this.add = {
                province_id : null,
                city_id : null,
                zone_id : null,
                name : null,
                phone : null,
                address : null,
                tel : null,

            }
        },

        ChangeActivation(id){
            axios.get('/api/management/customers/activation/'+id).then(res => {
                this.GetItems();
                Sweet.SweetToastMessage(res.data);
            }).catch(error => {
                this.item_loading=false;
                Sweet.SweetServerErrorMessage();
            })
        },

        GetProvinces(){
            axios.get('/api/management/helpers/get/provinces').then(res => {
                this.provinces = res.data;
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
                if (this.zones.length){
                    this.add.zone_id = this.zones[0].id;
                }


            }
        },

        EditSelectCity(id){

            let cities = this.provinces.filter(item => {
                return this.edit.province_id[id] === item.id;
            })
            this.cities = cities[0].cities;
            this.EditSelectZone(id);

        },

        EditSelectZone(id){

            let cities = this.provinces.filter(item => {
                return this.edit.province_id[id] === item.id;
            })
            let zones = cities[0].cities.filter(city => {
                return this.edit.city_id[id] === city.id;
            })
            this.zones = zones[0].zones;

        }

    },

    computed:{
        SearchItem(){
            return this.items.filter(item => {
                return item.name !== null && item.name.match(this.search)
                || item.phone !== null && item.phone.match(this.search)
                || item.code !== null && item.code.match(this.search)
            })

        }
    }
}
</script>

<style scoped>

</style>
