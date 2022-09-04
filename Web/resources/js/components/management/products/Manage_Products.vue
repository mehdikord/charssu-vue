<template>
    <page_title :title="'مدیریت قطعات محصولات'"></page_title>
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
                            <div class="modal fade" id="new_item" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="myLargeModalLabel">افزودن آیتم جدید</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="row">
                                                <div class="mb-4 col-md-6">
                                                    <label  class="form-label">نام قطعه یا محصول</label>
                                                    <input v-model="add.name" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'name').length}">
                                                    <validation_errors :errors="errors" :field="'name'"></validation_errors>
                                                </div>
                                                <div class="mb-4 col-md-6">
                                                    <label  class="form-label">شناسه قطعه (Model Number)</label>
                                                    <input v-model="add.product_code" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'product_code').length}">
                                                    <validation_errors :errors="errors" :field="'product_code'"></validation_errors>
                                                </div>
                                                <div class="mb-4 col-md-6">
                                                    <label  class="form-label">دسته بندی محصول</label>
                                                    <select class="form-control" v-model="add.product_category_id">
                                                        <option v-for="(category,index) in categories" :key="index+'_cat'" :value="category.id">{{ category.name }}</option>
                                                    </select>
                                                    <validation_errors :errors="errors" :field="'product_category_id'"></validation_errors>
                                                </div>
                                                <div class="mb-4 col-md-6">
                                                    <label  class="form-label">برند محصول</label>
                                                    <select class="form-control" v-model="add.device_brand_id">
                                                        <option v-for="(brand,index) in brands" :key="index+'_b'" :value="brand.id">{{ brand.name }}</option>
                                                    </select>
                                                    <validation_errors :errors="errors" :field="'device_brand_id'"></validation_errors>
                                                </div>
                                                <div class="mb-4 col-md-6">
                                                    <label  class="form-label">قیمت (تومان)</label>
                                                    <input v-model="add.price" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'price').length}">
                                                    <validation_errors :errors="errors" :field="'price'"></validation_errors>
                                                </div>
                                                <div class="mb-4 col-md-6">
                                                    <label  class="form-label">قیمت با تخفیف</label>
                                                    <input v-model="add.sale" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'sale').length}">
                                                    <validation_errors :errors="errors" :field="'sale'"></validation_errors>
                                                </div>
                                                <div class="mb-4 col-md-6">
                                                    <label  class="form-label">قیمت برای سرویس کاران</label>
                                                    <input v-model="add.serviceman_price" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'serviceman_price').length}">
                                                    <validation_errors :errors="errors" :field="'serviceman_price'"></validation_errors>
                                                </div>
                                                <div class="mb-4 col-md-6">
                                                    <label  class="form-label">موجودی در انبار</label>
                                                    <input v-model="add.quantity" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'quantity').length}">
                                                    <validation_errors :errors="errors" :field="'quantity'"></validation_errors>
                                                </div>
                                                <div class="mb-4 col-12">
                                                    <label  class="form-label">توضیحات کامل</label>
                                                    <textarea v-model="add.description" class="form-control" rows="7"></textarea>
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
                                <th>دسته بندی</th>
                                <th>برند</th>
                                <th>سریال</th>
                                <th>کدچارسو</th>
                                <th>قیمت</th>
                                <th>تخفیف</th>
                                <th>قیمت سرویس کار</th>
                                <th>موجودی</th>
                                <th>تصاویر</th>
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
                                    <template v-if="item.category !== null">
                                        {{item.category.name}}
                                    </template>
                                </td>
                                <td>
                                    <template v-if="item.category !== null">
                                        {{item.category.name}}
                                    </template>
                                </td>
                                <td>
                                    <span class="badge rounded-pill badge-soft-primary font-size-12 fw-medium p-2">
                                        {{ item.product_code }}
                                    </span>
                                </td>
                                <td>
                                    <span class="badge rounded-pill badge-soft-danger font-size-12 fw-medium p-2">
                                        {{ item.code }}
                                    </span>
                                </td>
                                <td>
                                    <strong class="font-size-14 text-success">{{this.NumberFormatter(item.price)}}</strong> <span>تومان</span>

                                </td>
                                <td>
                                    <template v-if="item.sale !== null">
                                        <strong class="font-size-14 text-danger">{{this.NumberFormatter(item.sale)}}</strong> <span>تومان</span>
                                    </template>
                                </td>
                                <td>
                                    <strong class="font-size-14 text-primary">{{this.NumberFormatter(item.serviceman_price)}}</strong> <span>تومان</span>
                                </td>
                                <td class="text-center">
                                    <span class="badge rounded-pill badge-soft-pink font-size-12 fw-medium p-2">{{item.quantity}}</span>
                                </td >
                                <td>
                                    <button type="button" data-bs-toggle="modal" :data-bs-target="'#image_item_'+item.id" class="btn btn-dark btn-sm waves-effect waves-light">مشاهده و ویرایش</button>

                                    <div class="modal fade" :id="'image_item_'+item.id" tabindex="-1" role="dialog"  aria-hidden="true">
                                        <div class="modal-dialog modal-xl">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" >تصاویر محصول : <span class="text-danger">{{item.name}}</span></h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <h5 class="font-size-14 mb-3 mt-2"> افزودن تصویر جدید</h5>
                                                    <div v-if="!add_image_loading" class="row gx-3 gy-2 align-items-center">
                                                        <div class="hstack gap-3">
                                                            <input @change="AddNewImage(item.id)" class="form-control me-auto" :ref="'image'+item.id" type="file">
                                                            <button :disabled="this.image === null" @click="SubmitNewImage(item.id)" type="button" class="btn btn-success">افزودن تصویر <i class="mdi mdi-plus me-1"></i></button>
                                                        </div>
                                                    </div>
                                                    <template  v-else >
                                                        <div class="progress progress-xl mt-3">
                                                            <div class="progress-bar progress-bar-striped progress-bar-animated " role="progressbar"  style="width: 100%"></div>
                                                        </div>
                                                        <h6 class="mt-3 mb-4 text-danger text-center">در حال دخیره سازی تصویر ... </h6>
                                                    </template>
                                                    <hr>
                                                    <div class="mt-3 row">
                                                        <div v-for="(item_image,index) in item.images" :key="index+'_'+item.id" class="col-md-4">
                                                            <div class="card">
                                                                <img class="card-img-top img-fluid" :src="item_image.image" :alt="item.name">
                                                                <div class="card-body p-1">
                                                                    <button @click="DeleteImage(item_image.id)"  class="btn btn-danger waves-effect btn-label waves-light btn-sm"><i class="bx bx-trash label-icon"></i> حذف</button>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>

                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary waves-effect" data-bs-dismiss="modal">
                                                        <i class="bx bx-x font-size-18 align-middle"></i> بستن
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
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
                                                            <label  class="form-label">نام قطعه یا محصول</label>
                                                            <input v-model="edit.name[item.id]" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'name').length}">
                                                            <validation_errors :errors="errors" :field="'name'"></validation_errors>
                                                        </div>
                                                        <div class="mb-4 col-md-6">
                                                            <label  class="form-label">شناسه قطعه (Model Number)</label>
                                                            <input v-model="edit.product_code[item.id]" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'product_code').length}">
                                                            <validation_errors :errors="errors" :field="'product_code'"></validation_errors>
                                                        </div>
                                                        <div class="mb-4 col-md-6">
                                                            <label  class="form-label">دسته بندی محصول</label>
                                                            <select class="form-control" v-model="edit.product_category_id[item.id]">
                                                                <option v-for="(category,index) in categories" :key="index+'_cat'" :value="category.id">{{ category.name }}</option>
                                                            </select>
                                                            <validation_errors :errors="errors" :field="'product_category_id'"></validation_errors>
                                                        </div>
                                                        <div class="mb-4 col-md-6">
                                                            <label  class="form-label">برند محصول</label>
                                                            <select class="form-control" v-model="edit.device_brand_id[item.id]">
                                                                <option v-for="(brand,index) in brands" :key="index+'_b'" :value="brand.id">{{ brand.name }}</option>
                                                            </select>
                                                            <validation_errors :errors="errors" :field="'device_brand_id'"></validation_errors>
                                                        </div>
                                                        <div class="mb-4 col-md-6">
                                                            <label  class="form-label">قیمت (تومان)</label>
                                                            <input v-model="edit.price[item.id]" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'price').length}">
                                                            <validation_errors :errors="errors" :field="'price'"></validation_errors>
                                                        </div>
                                                        <div class="mb-4 col-md-6">
                                                            <label  class="form-label">قیمت با تخفیف</label>
                                                            <input v-model="edit.sale[item.id]" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'sale').length}">
                                                            <validation_errors :errors="errors" :field="'sale'"></validation_errors>
                                                        </div>
                                                        <div class="mb-4 col-md-6">
                                                            <label  class="form-label">قیمت برای سرویس کاران</label>
                                                            <input v-model="edit.serviceman_price[item.id]" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'serviceman_price').length}">
                                                            <validation_errors :errors="errors" :field="'serviceman_price'"></validation_errors>
                                                        </div>
                                                        <div class="mb-4 col-12">
                                                            <label  class="form-label">توضیحات کامل</label>
                                                            <textarea v-model="edit.description[item.id]" class="form-control" rows="7"></textarea>
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
import Sweet from "../../../helpers/Sweet";

export default {
    name: "Manage_Products",
    created() {
        this.GetItems();
        this.GetCategories();
        this.GetBrands();
    },

    data(){
        return {
            add : {
                name : null,
                product_category_id : null,
                device_brand_id : null,
                device_id : null,
                product_code : null,
                price : null,
                sale : null,
                serviceman_price : null,
                quantity : 0,
                description : null,
            },
            edit:{
                name : [],
                product_category_id : [],
                device_brand_id : [],
                device_id : [],
                product_code : [],
                price : [],
                sale : [],
                serviceman_price : [],
                quantity: [],
                description: [],
            },
            add_loading:false,
            item_loading:false,
            items : [],
            errors:[],
            categories:[],
            brands:[],
            devices:[],
            search:'',
            image:null,
            add_image_loading : false,

        }
    },

    methods:{
        GetItems(){
            this.item_loading=true;
            axios.get('/api/management/products').then(res => {
                this.item_loading=false;
                this.items=res.data;
                res.data.forEach(item=>{
                    this.edit.name[item.id] = item.name;
                    this.edit.product_category_id[item.id] = item.product_category_id;
                    this.edit.device_brand_id[item.id] = item.device_brand_id;
                    this.edit.device_id[item.id] = item.device_id;
                    this.edit.product_code[item.id] = item.product_code;
                    this.edit.price[item.id] = item.price;
                    this.edit.sale[item.id] = item.sale;
                    this.edit.serviceman_price[item.id] = item.serviceman_price;
                    this.edit.description[item.id] = item.description;
                })

            }).catch(error => {
                this.item_loading=false;
                Sweet.SweetServerErrorMessage();
            })
        },

        CreateItem(){
            this.add_loading=true;
            if (this.add.price !== null){this.add.price = this.NumberToEn(this.add.price)}
            if (this.add.sale !== null){this.add.sale = this.NumberToEn(this.add.sale)}
            if (this.add.serviceman_price !== null){this.add.serviceman_price = this.NumberToEn(this.add.serviceman_price)}
            if (this.add.quantity !== null){this.add.quantity = this.NumberToEn(this.add.quantity)}
            axios.post('/api/management/products',this.add).then(res => {
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
            if (this.edit.price[id] !== null){this.edit.price[id] = this.NumberToEn(this.edit.price[id])}
            if (this.edit.sale[id] !== null){this.edit.sale[id] = this.NumberToEn(this.edit.sale[id])}
            if (this.edit.serviceman_price[id] !== null){this.edit.serviceman_price[id] = this.NumberToEn(this.edit.serviceman_price[id])}
            let data = {
                name : this.edit.name[id],
                product_category_id : this.edit.product_category_id[id],
                device_brand_id : this.edit.device_brand_id[id],
                device_id : this.edit.device_id[id],
                product_code : this.edit.product_code[id],
                price : this.edit.price[id],
                sale : this.edit.sale[id],
                serviceman_price : this.edit.serviceman_price[id],
                description : this.edit.description[id],
            }
            axios.put('/api/management/products/'+id,data).then(res => {
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
                    axios.delete('/api/management/products/'+id).then(res =>{
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
                name : null,
                product_category_id : null,
                device_brand_id : null,
                device_id : null,
                product_code : null,
                price : null,
                sale : null,
                serviceman_price : null,
                quantity: 0,
                description: null,
            }
        },

        GetCategories(){
            axios.get('/api/helpers/get/product-categories').then(res => {
                this.categories = res.data;
            }).catch(e => {
                Sweet.SweetServerErrorMessage()

            })
        },

        GetBrands(){
            axios.get('/api/helpers/get/brands').then(res => {
                this.brands = res.data;
            }).catch(e => {
                Sweet.SweetServerErrorMessage()
            })

        },

        AddNewImage(id){
            let name = "image"+id;
            if (this.$refs[name][0].files.length){
                let file = this.$refs[name][0].files[0];
                if (file.type === 'image/jpg' || file.type === 'image/png' || file.type === 'image/jpeg'){
                    this.image = file;
                }else{
                    return Sweet.SweetToastMessage('فایل انتخابی باید فایلی از نوع ( jpg - png - jpeg ) باشد !','error');
                }

            }
        },

        SubmitNewImage(id){
            this.add_image_loading=true;
            let data = new FormData();
            if (this.image !== null){data.append('image',this.image,this.image.name)}
            axios.post('/api/management/products/images/'+id,data,
                {
                    headers: {
                        'Content-Type': 'multipart/form-data'
                    }
                }
            ).then(res => {
                this.add_image_loading=false;
                this.GetItems();
                $('#image_item_'+id).modal('toggle');
                Sweet.SweetToastMessage('تصویر جدید محصول باموفقیت اضافه شد');
            }).catch(error => {
                this.add_loading=false;
                if (error.response.status === 421){
                    this.errors = error.response.data
                }else {
                    Sweet.SweetServerErrorMessage()
                }
            })

        },

        DeleteImage(id){
            axios.delete('/api/management/products/images/'+id).then(res => {
                this.GetItems();
                $('#image_item_'+id).modal('toggle');
                Sweet.SweetDeleteItem();
            }).catch(e => {
                return Sweet.SweetServerErrorMessage()
            })
        }
    },

    computed:{
        SearchItem(){
            return this.items.filter(item => {
                return item.name !== null && item.name.match(this.search)
            })

        }
    }
}
</script>

<style scoped>
.product-image{
    width: 75%!important;
}

</style>
