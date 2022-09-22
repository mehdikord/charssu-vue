<template>
    <page_title :title="'مدیریت هزینه های اعمال شده در فاکتور'"></page_title>
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
                                                <label  class="form-label">عنوان هزینه</label>
                                                <input v-model="add.title" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'title').length}">
                                                <validation_errors :errors="errors" :field="'title'"></validation_errors>
                                            </div>

                                            <div class="mb-4 ">
                                                <label  class="form-label">مبلغ قابل پرداخت (تومان)</label>
                                                <input v-model="add.price" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'price').length}">
                                                <validation_errors :errors="errors" :field="'price'"></validation_errors>
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
                                <th>عنوان هزینه</th>
                                <th>هزینه تعمیر</th>
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
                                    {{ item.title }}
                                </td>
                                <td>
                                    <strong class="font-size-14 text-success">{{this.NumberFormatter(item.price)}}</strong> <span>تومان</span>
                                </td>
                                <td>
                                    <button @click="EditSelectCity(item.id)" data-bs-toggle="modal" :data-bs-target="'#edit_item'+item.id" title="ویرایش آیتم" type="button" class="btn btn-sm btn-primary waves-effect waves-light me-2"><i class="bx bx-edit font-size-16 align-middle"></i></button>
                                    <button @click="DelItem(item.id)" title="حذف آیتم" type="button" class="btn btn-sm btn-danger waves-effect waves-light me-2"><i class="bx bx-trash font-size-16 align-middle"></i></button>

                                    <div class="modal fade" :id="'edit_item'+item.id" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
                                         aria-hidden="true">
                                        <div class="modal-dialog ">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">ویرایش آیتم : {{ item.id }}</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="mb-4 ">
                                                        <label  class="form-label">عنوان هزینه</label>
                                                        <input v-model="edit.title[item.id]" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'title').length}">
                                                        <validation_errors :errors="errors" :field="'title'"></validation_errors>
                                                    </div>
                                                    <div class="mb-4 ">
                                                        <label  class="form-label">مبلغ قابل پرداخت (تومان)</label>
                                                        <input v-model="edit.price[item.id]" class="form-control" type="text" :class="{'is-invalid' : this.ValidationErrors(errors,'price').length}">
                                                        <validation_errors :errors="errors" :field="'price'"></validation_errors>
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
    name: "Manage_Costs",
    created() {
        this.GetItems();
    },

    data(){
        return {
            add : {
                title : null,
                price : null,
            },
            edit:{
                title : [],
                price : [],
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
            axios.get('/api/management/costs').then(res => {
                this.item_loading=false;
                this.items=res.data;
                res.data.forEach(item=>{
                    this.edit.title[item.id] = item.title;
                    this.edit.price[item.id] = item.price;
                })

            }).catch(error => {
                this.item_loading=false;
                Sweet.SweetServerErrorMessage();
            })
        },

        CreateItem(){
            this.add_loading=true;
            if (this.add.price !== null){this.add.price = this.NumberToEn(this.add.price)}

            axios.post('/api/management/costs',this.add).then(res => {
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

            let data = {
                title : this.edit.title[id],
                price : this.edit.price[id],
            }

            axios.put('/api/management/costs/'+id,data).then(res => {
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
                    axios.delete('/api/management/costs/'+id).then(res =>{
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
                problem : null,
            }
        },

    },

    computed:{
        SearchItem(){
            return this.items.filter(item => {
                return item.title !== null && item.title.match(this.search)
            })

        }
    }
}
</script>

<style scoped>

</style>
