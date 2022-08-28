<template>
    <page_title :title="'لیست سرویس کاران در انتظار تایید '"></page_title>
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
                                <router-link :to="{name : 'manage_servicemans_create'}" class="btn btn-danger btn-rounded waves-effect waves-light mb-2 me-2"><i class="mdi mdi-plus font-size-15 me-1"></i> افزودن سرویس کار جدید</router-link>
                            </div>
                        </div>
                    </div>
                    <div class="mt-3 mb-3">
                        <div class="alert alert-primary alert-border-left alert-dismissible fade show" role="alert">
                            <i class="mdi mdi-help-box me-2  align-middle"></i><strong>راهنما : </strong>
                            برای مشاهده اطلاعات و مدیریت کامل سرویس کار از دکمه مدیریت در ابزار استفاده کنید.
                        </div>
                    </div>

                    <div v-if="item_loading === false" class="table-responsive">
                        <table v-if="SearchItem.length > 0" class="table align-middle table-nowrap table-bordered">
                            <thead>
                            <tr>
                                <th>#</th>
                                <th>
                                    نام
                                </th>
                                <th>موبایل</th>
                                <th>کدملی</th>
                                <th>کد چارسو</th>
                                <th>استان</th>
                                <th>شهر</th>
                                <th>تاریخ</th>
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
                                    {{item.name}}
                                </td>
                                <td>
                                    {{item.phone}}
                                </td>
                                <td>
                                    {{item.national_code}}
                                </td>
                                <td>
                                    <span class="badge rounded-pill badge-soft-danger font-size-12 fw-medium p-2">
                                        {{ item.code }}
                                    </span>
                                </td>
                                <td>
                                    {{item.province.name}}
                                </td>
                                <td>
                                    {{item.city.name}}
                                </td>
                                <td>
                                    <span class="badge rounded-pill badge-soft-dark font-size-11 fw-medium">

                                        {{ this.$filters.date(item.create_at)}}
                                    </span>
                                </td>
                                <td>
                                    <router-link to="" title="مدیریت کامل" type="button" class="btn btn-sm btn-purple waves-effect waves-light me-2"><i class="bx bx-cog font-size-16 align-middle"></i></router-link>
                                    <button @click="AcceptItem(item.id)" title="تایید سرویس کار" type="button" class="btn btn-sm btn-success waves-effect waves-light me-2"><i class="bx bx-check font-size-16 align-middle"></i></button>
                                    <button data-bs-toggle="modal" :data-bs-target="'#edit_item'+item.id" title="رد کردن سرویس کار" type="button" class="btn btn-sm btn-danger waves-effect waves-light me-2"><i class="bx bx-x font-size-16 align-middle"></i></button>
                                    <router-link :to="{name : 'manage_servicemans_edit',params : { id : item.id}}" title="ویرایش آیتم" type="button" class="btn btn-sm btn-primary waves-effect waves-light me-2"><i class="bx bx-edit font-size-16 align-middle"></i></router-link>
                                    <button title="حذف آیتم" type="button" class="btn btn-sm btn-danger waves-effect waves-light me-2"><i class="bx bx-trash font-size-16 align-middle"></i></button>


                                    <div class="modal fade" :id="'edit_item'+item.id" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                                        <div class="modal-dialog ">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">رد کردن سرویس کار : {{ item.name }}</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="mt-3">
                                                        <label class="form-label">دلیل رد کردن سرویس کار</label>
                                                        <textarea class="form-control" rows="7" v-model="reject_message" placeholder="مثال : ناقص بودن اطلاعات آدرس محل سکونت"></textarea>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary waves-effect" data-bs-dismiss="modal">
                                                        <i class="bx bx-x font-size-18 align-middle"></i> بستن
                                                    </button>
                                                    <button type="button" class="btn btn-danger waves-effect waves-light">
                                                        <i class="bx bx-check font-size-18 align-middle" ></i>  رد کردن
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
    name: "Manage_Servicemans_Waiting",
    created() {
        this.GetItems();
    },
    data(){
        return{
            items :[],
            item_loading:false,
            reject_message:null,
            search:'',
        }
    },
    methods : {
        GetItems(){
            this.item_loading=true;
            axios.get('/api/management/servicemans/waiting').then(res => {
                this.items = res.data;
                this.item_loading=false;
            }).catch(error => {
                this.item_loading=false;
                Sweet.SweetServerErrorMessage();
            })
        },

        AcceptItem(id){
            Swal.fire({
                title: 'آیا مطمئن هستید',
                text: "سرویس کار مورد نظر تایید و در وضعیت سرویس گیری قرار بگیرد ؟",
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: '#26a852',
                cancelButtonColor: '#d33',
                cancelButtonText : 'خیر',
                confirmButtonText: 'تایید شود'
            }).then((result) => {
                if (result.isConfirmed) {
                    axios.get('/api/management/servicemans/set/accept/'+id).then(res =>{
                        Sweet.SweetDeleteItem()
                        this.GetItems();
                    }).catch(e=>{
                        Sweet.SweetServerErrorMessage();
                    })
                }
            })
        },

    },
    computed:{
        SearchItem(){
            return this.items.filter(item => {
                return item.name !== null && item.name.match(this.search)
                    || item.phone !== null && item.phone.match(this.search)
                    || item.code !== null && item.code.match(this.search)
                    || item.national_code !== null && item.national_code.match(this.search)
            })

        }
    }
}
</script>

<style scoped>

</style>
