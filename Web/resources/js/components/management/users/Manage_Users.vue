<template>
    <page_title :title="'مدیران سیستم'"></page_title>
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
                                                <label  class="form-label">نام کامل</label>
                                                <input v-model="add.name" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'name').length}">
                                                <validation_errors :errors="errors" :field="'name'"></validation_errors>
                                            </div>
                                            <div class="mb-4 ">
                                                <label  class="form-label">شماره موبایل</label>
                                                <input v-model="add.phone" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'phone').length}">
                                                <validation_errors :errors="errors" :field="'phone'"></validation_errors>
                                            </div>
                                            <div class="mb-4 ">
                                                <label  class="form-label">کد ملی</label>
                                                <input v-model="add.national_code" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'national_code').length}">
                                                <validation_errors :errors="errors"  :field="'national_code'"></validation_errors>
                                            </div>
                                            <div class="mb-4 ">
                                                <label  class="form-label">سطح مدیریت </label>
                                                <select class="form-control" v-model="add.role">
                                                    <option value="1">مدیر ارشد</option>
                                                    <option value="2">مدیر داخلی</option>
                                                </select>
                                                <validation_errors :errors="errors"  :field="'role'"></validation_errors>
                                            </div>
                                            <div class="mb-4 ">
                                                <label class="form-label">آدرس ایمیل (اختیاری) </label>
                                                <input v-model="add.email" class="form-control" type="email" :class="{'is-invalid' : this.ValidationErrors(errors,'email').length}">
                                                <validation_errors :errors="errors" :field="'email'"></validation_errors>
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
                                <th>کد ملی</th>
                                <th>ایمیل</th>
                                <th>سطح مدیریت</th>
                                <th>وضعیت</th>
                                <th>ابزار</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr class="app-fade-in" v-for="(item,index) in SearchItem" :key="index">
                                <td>
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
                                    {{ item.national_code }}
                                </td>
                                <td>
                                    {{ item.email }}
                                </td>
                                <td>
                                    <span v-if="item.role === 1" class="badge rounded-pill bg-danger font-size-12 p-2">مدیر ارشد</span>
                                    <span v-else class="badge rounded-pill bg-purple font-size-12 p-2">مدیر داخلی</span>
                                </td>
                                <td class="text-center">
                                    <div class="square-switch">
                                        <input @change="ChangeActivation(item.id)" type="checkbox" :id="'square-switch3'+item.id" switch="bool" :checked="item.is_active">
                                        <label :for="'square-switch3'+item.id" data-on-label="YES" data-off-label="NO"></label>
                                    </div>
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
                                                        <label  class="form-label">نام کامل</label>
                                                        <input v-model="edit.name[item.id]" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'name').length}">
                                                        <validation_errors :errors="errors" :field="'name'"></validation_errors>
                                                    </div>
                                                    <div class="mb-4 ">
                                                        <label  class="form-label">شماره موبایل</label>
                                                        <input v-model="edit.phone[item.id]" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'phone').length}">
                                                        <validation_errors :errors="errors" :field="'phone'"></validation_errors>
                                                    </div>
                                                    <div class="mb-4 ">
                                                        <label  class="form-label">کد ملی</label>
                                                        <input v-model="edit.national_code[item.id]" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'national_code').length}">
                                                        <validation_errors :errors="errors"  :field="'national_code'"></validation_errors>
                                                    </div>
                                                    <div class="mb-4 ">
                                                        <label  class="form-label">سطح مدیریت </label>
                                                        <select class="form-control" v-model="edit.role[item.id]">
                                                            <option value="1">مدیر ارشد</option>
                                                            <option value="2">مدیر داخلی</option>
                                                        </select>
                                                        <validation_errors :errors="errors"  :field="'role'"></validation_errors>
                                                    </div>
                                                    <div class="mb-4 ">
                                                        <label class="form-label">آدرس ایمیل (اختیاری) </label>
                                                        <input v-model="edit.email[item.id]" class="form-control" type="email" :class="{'is-invalid' : this.ValidationErrors(errors,'email').length}">
                                                        <validation_errors :errors="errors" :field="'email'"></validation_errors>
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
    name: "Manage_Users",

    created() {
        this.GetItems();
    },

    data(){
        return {
            add : {
                name : null,
                phone : null,
                national_code : null,
                email : null,
                role : 2,
            },
            edit:{
                name : [],
                phone : [],
                national_code : [],
                email : [],
                role : [],
            },
            add_loading:false,
            item_loading:false,
            items : [],
            errors:[],
            search:'',

        }
    },

    methods:{
        GetItems(){
            this.item_loading=true;
            axios.get('/api/management/users').then(res => {
                this.item_loading=false;
                this.items=res.data;
                res.data.forEach(item=>{
                    this.edit.name[item.id] = item.name;
                    this.edit.phone[item.id] = item.phone;
                    this.edit.national_code[item.id] = item.national_code;
                    this.edit.email[item.id] = item.email;
                    this.edit.role[item.id] = item.role;
                })

            }).catch(error => {
                this.item_loading=false;
                Sweet.SweetServerErrorMessage();
            })
        },

        CreateItem(){
            this.add_loading=true;
            if (this.add.phone !== null){this.add.phone = this.NumberToEn(this.add.phone)}
            if (this.add.national_code !== null){this.add.national_code = this.NumberToEn(this.add.national_code)}
            axios.post('/api/management/users',this.add).then(res => {
                $('#new_item').modal('hide');
                Sweet.SweetEditItem();
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
            if (this.edit.phone[id] !== null){this.edit.phone[id] = this.NumberToEn(this.edit.phone[id])}
            if (this.edit.national_code[id] !== null){this.edit.national_code[id] = this.NumberToEn(this.edit.national_code[id])}

            let data = {
                name : this.edit.name[id],
                phone : this.edit.phone[id],
                national_code : this.edit.national_code[id],
                email : this.edit.email[id],
                role : this.edit.role[id],
            }

            axios.put('/api/management/users/'+id,data).then(res => {
                this.GetItems();
                $('#edit_item'+id).modal('hide');
                Sweet.SweetAddItem();
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
                    axios.delete('/api/management/users/'+id).then(res =>{
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
                phone : null,
                national_code : null,
                email : null,
                role : 2,
            }
        },

        ChangeActivation(id){
            axios.get('/api/management/users/activation/'+id).then(res => {
                this.GetItems();
                Sweet.SweetToastMessage(res.data);
            }).catch(error => {
                this.item_loading=false;
                Sweet.SweetServerErrorMessage();
            })
        }

    },

    computed:{
        SearchItem(){
            return this.items.filter(item => {
                return item.name !== null && item.name.match(this.search)
                    ||  item.phone !== null && item.phone.match(this.search)
                    ||  item.national_code !== null && item.national_code.match(this.search)
                    ||  item.email !== null && item.email.match(this.search)
            })

        }
    }





}
</script>

<style scoped>

</style>
