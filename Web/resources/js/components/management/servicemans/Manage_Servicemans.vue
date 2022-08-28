<template>
    <page_title :title="'لیست سرویس کاران فعال '"></page_title>
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
                            برای مشاهده اطلاعات و مدیریت کامل سرویس کار از دکمه مدیریت در ابزار استفاده کنید، علامت چشمک زن در کنار اسم سرویس کار نشان دهنده افلاین یا آنلاین بودن در حال حاضر است.
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
                                    <div v-if="item.is_online === 1" class="spinner-grow text-success" role="status">
                                        <span class="sr-only"></span>
                                    </div>
                                    <div v-else class="spinner-grow text-danger" role="status">
                                        <span class="sr-only"></span>
                                    </div>
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
                                    <router-link :to="{name : 'manage_servicemans_edit',params : { id : item.id}}" title="ویرایش آیتم" type="button" class="btn btn-sm btn-primary waves-effect waves-light me-2"><i class="bx bx-edit font-size-16 align-middle"></i></router-link>
                                    <button title="حذف آیتم" type="button" class="btn btn-sm btn-danger waves-effect waves-light me-2"><i class="bx bx-trash font-size-16 align-middle"></i></button>


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
export default {
name: "Manage_Servicemans",

    created() {
        this.GetItems();
    },
    data(){
        return{
            items :[],
            item_loading:false,
            search:'',
        }
    },
    methods : {
        GetItems(){
            this.item_loading=true;
            axios.get('/api/management/servicemans').then(res => {
                this.items = res.data;
                this.item_loading=false;
            }).catch(error => {
                this.item_loading=false;
                Sweet.SweetServerErrorMessage();
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
.spinner-grow{
    width: 17px!important;
    height: 17px!important;

}

</style>
