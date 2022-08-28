<template>
    <div class="contact-section ptb-100">
        <div class="container" id="support_call">
            <h3 class="font-45 ">تماس با پشتیبانی چارسو</h3>
            <p class="font-15 mt-3">برای تماس با پشتیبانان چارسو کافیه شماره تماس و موضوع مورد نظر خود را در کادر وارد کنید <br> تا پشتیبانان چارسو در سریع ترین زمان ممکن با شما تماس بگیرند</p>

            <div class="row align-items-center">
                <div class="col-lg-6">
                    <div class="contact-image">
                        <img src="/template/img/default/support-image.svg" alt="image">
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="contact-form">
                        <form  action="" method="post">
                            <div class="row">
                                <div class="col-lg-6 col-md-6">
                                    <div class="form-group">
                                        <input type="text" name="name" id="name" class="form-control" required placeholder="نام شما">
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6">
                                    <div class="form-group">
                                        <input type="text" name="phone" id="phone" required class="form-control" placeholder="شماره تماس">
                                    </div>
                                </div>
                                <div class="col-lg-12 col-md-12">
                                    <div class="form-group">
                                        <select name="zone_id"  class="form-control" required id="">
                                            <option selected disabled>منطقه خود را انتخاب کنید</option>

                                        </select>
                                    </div>
                                </div>
                                <div class="col-lg-12 col-md-12">
                                    <div class="form-group">
                                        <textarea name="message" required class="form-control" id="message" cols="30" rows="6" placeholder="پیام شما ..."></textarea>
                                    </div>
                                </div>

                                <div class="col-lg-12 col-md-12">
                                    <button type="submit" class="submit-btn">درخواست پشتیبانی</button>
                                    <div id="msgSubmit" class="h3 text-center hidden"></div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: "Front_Index_Contact"
}
</script>

<style scoped>

</style>
