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
export default {
    name: "Manage_Servicemans_Edit"
}
</script>

<style scoped>

</style>
