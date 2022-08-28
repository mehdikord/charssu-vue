<template>
    <page_title :title="'لیست همه دستگاه ها (پکیج ها)'"></page_title>
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
                                <div class="modal-dialog ">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="myLargeModalLabel">افزودن آیتم جدید</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="mb-4 ">
                                                <label class="form-label">نام دستگاه</label>
                                                <input v-model="add.name" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'name').length}">
                                                <validation_errors :errors="errors" :field="'name'"></validation_errors>
                                            </div>
                                            <div class="mb-4 ">
                                                <label class="form-label">انتخاب برند</label>
                                                <select class="form-control" v-model="add.device_brand_id">
                                                    <option v-for="(brand,index) in brands" :key="index" :value="brand.id">{{brand.name}}</option>
                                                </select>
                                                <validation_errors :errors="errors" :field="'device_brand_id'"></validation_errors>
                                            </div>
                                            <div class="mb-4 ">
                                                <label class="form-label">شناسه دستگاه (Model Number)</label>
                                                <input v-model="add.device_code" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'device_code').length}">
                                                <validation_errors :errors="errors" :field="'device_code'"></validation_errors>
                                            </div>
                                            <div class="mb-4 ">
                                                <label  class="form-label">توضیحات</label>
                                                <textarea class="form-control" rows="5" v-model="add.description"></textarea>
                                                <validation_errors :errors="errors" :field="'description'"></validation_errors>
                                            </div>
                                            <div class="mb-4 ">
                                                <label class="form-label">تصویر لوگو</label>
                                                <input @change="LogoFileHandler" ref="image" class="form-control" type="file">
                                                <validation_errors :errors="errors"  :field="'image'"></validation_errors>
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
                                <th>برند</th>
                                <th>شناسه</th>
                                <th>کد چارسو</th>
                                <th>توضیحات</th>
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
                                    <img v-if="item.image !== null" :src="item.image" class="img-fluid avatar-md  rounded-circle me-2" alt="">
                                    <img v-else src="/images/default/no-photo.png" class="img-fluid avatar-md  rounded-circle me-2" alt="">
                                    <span class="font-size-13">{{item.name}}</span>

                                </td>
                                <td>
                                    {{ item.brand.name }}
                                </td>
                                <td>
                                    <span class="badge rounded-pill badge-soft-purple font-size-12 fw-medium p-2"> {{item.device_code}}</span>
                                </td>
                                <td>
                                    <span class="badge rounded-pill badge-soft-danger font-size-12 fw-medium p-2"> {{item.code}}</span>
                                </td>
                                <td>
                                    {{ item.description }}
                                </td>

                                <td>
                                    <button data-bs-toggle="modal" :data-bs-target="'#edit_item'+item.id" title="ویرایش آیتم" type="button" class="btn btn-sm btn-primary waves-effect waves-light me-2"><i class="bx bx-edit font-size-16 align-middle"></i></button>
                                    <button @click="DelItem(item.id)" title="حذف آیتم" type="button" class="btn btn-sm btn-danger waves-effect waves-light me-2"><i class="bx bx-trash font-size-16 align-middle"></i></button>
                                    <div class="modal fade" :id="'edit_item'+item.id" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
                                         aria-hidden="true">
                                        <div class="modal-dialog ">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">ویرایش آیتم : {{ item.name }}</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="mb-4 ">
                                                        <label class="form-label">نام دستگاه</label>
                                                        <input v-model="edit.name[item.id]" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'name').length}">
                                                        <validation_errors :errors="errors" :field="'name'"></validation_errors>
                                                    </div>
                                                    <div class="mb-4 ">
                                                        <label class="form-label">انتخاب برند</label>
                                                        <select class="form-control" v-model="edit.device_brand_id[item.id]">
                                                            <option v-for="(brand,index) in brands" :key="index" :value="brand.id">{{brand.name}}</option>
                                                        </select>
                                                        <validation_errors :errors="errors" :field="'device_brand_id'"></validation_errors>
                                                    </div>
                                                    <div class="mb-4 ">
                                                        <label class="form-label">شناسه دستگاه (Model Number)</label>
                                                        <input v-model="edit.device_code[item.id]" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'device_code').length}">
                                                        <validation_errors :errors="errors" :field="'device_code'"></validation_errors>
                                                    </div>
                                                    <div class="mb-4 ">
                                                        <label  class="form-label">توضیحات</label>
                                                        <textarea class="form-control" rows="5" v-model="edit.description[item.id]"></textarea>
                                                        <validation_errors :errors="errors" :field="'description'"></validation_errors>
                                                    </div>
                                                    <div class="mb-4 ">
                                                        <label class="form-label">تصویر لوگو</label>
                                                        <div class="alert alert-warning alert-dismissible alert-label-icon label-arrow fade show" role="alert">
                                                            <i class="mdi mdi-alert-outline label-icon"></i><strong>توجه</strong> : فقط در صورت تغییر تصویر فعلی ، فایل جدید را انتخاب کنید
                                                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                                        </div>
                                                        <input @change="EditLogoFileHandler" :ref="'image'+item.id" class="form-control" type="file">
                                                        <validation_errors :errors="errors"  :field="'image'"></validation_errors>
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
import Sweet from "../../../helpers/Sweet";
import Swal from "sweetalert2";

export default {
    name: "Manage_Devices",
    created() {
        this.GetItems();
        this.GetBrands();
    },

    data(){
        return {
            add : {
                device_brand_id : null,
                name : null,
                device_code : null,
                image : null,
                description : null,
            },
            edit:{
                device_brand_id : [],
                name : [],
                device_code : [],
                image : [],
                description : [],
            },
            add_loading:false,
            item_loading:false,
            items : [],
            brands : [],
            errors:[],
            search:'',

        }
    },

    methods:{
        GetItems(){
            this.item_loading=true;
            axios.get('/api/management/devices').then(res => {
                this.item_loading=false;
                this.items=res.data;
                res.data.forEach(item=>{
                    this.edit.device_brand_id[item.id] = item.device_brand_id;
                    this.edit.name[item.id] = item.name;
                    this.edit.device_code[item.id] = item.device_code;
                    this.edit.description[item.id] = item.description;
                    this.edit.image[item.id] = null;
                })
            }).catch(error => {
                this.item_loading=false;
                Sweet.SweetServerErrorMessage();
            })
        },
        GetBrands(){
            axios.get('/api/management/device-brands').then(res => {
                this.brands = res.data;
            }).catch(e => {
                Sweet.SweetServerErrorMessage();
            })

        },

        CreateItem(){
            this.add_loading=true;
            let data = new FormData();
            if (this.add.device_brand_id !== null){data.append('device_brand_id',this.add.device_brand_id)}
            if (this.add.name !== null){data.append('name',this.add.name)}
            if (this.add.device_code !== null){data.append('device_code',this.add.device_code)}
            if (this.add.description !== null){data.append('description',this.add.description)}
            if (this.add.image !== null){data.append('image',this.add.image,this.add.image.name)}

            axios.post('/api/management/devices',data,{
                headers: {
                    'Content-Type': 'multipart/form-data'
                }
            }).then(res => {

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

        //TODO
        EditItem(id){
            this.add_loading=true;
            let data = new FormData();

            if (this.edit.device_brand_id[id] !== null){data.append('device_brand_id',this.edit.device_brand_id[id])}
            if (this.edit.name[id] !== null){data.append('name',this.edit.name[id])}
            if (this.edit.device_code[id] !== null){data.append('device_code',this.edit.device_code[id])}
            if (this.edit.description[id] !== null){data.append('description',this.edit.description[id])}
            if (this.edit.image[id] !== null){data.append('image',this.edit.image[id],this.edit.image.name[id])}

            axios.post('/api/management/devices/update/'+id,data,{
                headers: {
                    'Content-Type': 'multipart/form-data'
                }
            }).then(res => {
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
                    axios.delete('/api/management/devices/'+id).then(res =>{
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
                device_brand_id : null,
                name : null,
                device_code : null,
                description : null,
                image: null,

            }
        },

        LogoFileHandler(){
            if (this.$refs.image.files.length){
                let file = this.$refs.image.files[0];
                if (file.type !== 'application/pdf' && file.type !== 'image/jpeg' && file.type !== 'image/png'){
                    return Sweet.SweetFileTypeError('pdf / image');
                }else {
                    this.add.image = file;
                }
            }
        },

        EditLogoFileHandler(id){
            let name = "image"+id;
            if (this.$refs[name][0].files.length){
                let file = this.$refs[name][0].files[0];
                if (file.type === 'image/jpg' || file.type === 'image/png' || file.type === 'image/jpeg'){
                    this.edit.image[id] = file;
                }else{
                    return Sweet.SweetToastMessage('فایل انتخابی باید فایلی از نوع ( jpg - png - jpeg ) باشد !','error');
                }

            }
        },

    },

    computed:{
        SearchItem(){
            return this.items.filter(item => {
                return item.name !== null && item.name.match(this.search) ||
                 item.device_code !== null && item.device_code.match(this.search)
            })

        }
    }

}
</script>

<style scoped>

</style>
