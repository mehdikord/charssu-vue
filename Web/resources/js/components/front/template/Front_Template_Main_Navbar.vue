<template>
    <div class="navbar-area">
        <div class="plamb-responsive-nav">
            <div class="container">
                <div class="plamb-responsive-menu">
                    <div class="logo">
                        <a>
                            <img src="/logo-name.png" width="55" class="white-logo" alt="logo">
                            <img src="/logo.png" width="55" class="black-logo" alt="logo">
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="plamb-nav">
            <div class="container">
                <nav class="navbar navbar-expand-md navbar-light">
                    <a class="navbar-brand" >
                        <img src="/logo-name.png" width="55" class="white-logo" alt="logo">
                        <img src="/logo.png" width="55" class="black-logo" alt="logo">
                    </a>
                    <div class="collapse navbar-collapse mean-menu" id="navbarSupportedContent">
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <router-link :to="{name: 'front_index'}" >
                                    صفحه اصلی
                                </router-link>
                            </li>

                            <li class="nav-item">
                                <a href="#" class="nav-link">
                                    لیست خدمات
                                    <i class="mdi mdi-arrow-down"></i>
                                </a>
                                <ul class="dropdown-menu">
                                    <li class="nav-item">
                                        <router-link :to="{name : 'front_orders_new'}"  class="nav-link">
                                            تعمیر پکیج
                                        </router-link>
                                    </li>
                                </ul>
                            </li>
                            <li class="nav-item">
                                <a  class="nav-link" >
                                    فروشگاه چارسو
                                </a>
                            </li>
                            <li class="nav-item">
                                <a  class="nav-link " >
                                    درباره چارسو
                                </a>
                            </li>
                            <li class="nav-item">
                                <a  class="nav-link">
                                    قوانین
                                </a>
                            </li>

                        </ul>
                        <div class="other-option">

                            <a class="default-btn bg-success" href="#support_call">
                                <i class="fas fa-headset"></i> تماس با پشتیبان
                                <span></span>
                            </a>

                            <router-link :to="{name : 'front_auth'}" class="default-btn mr-3">
                                حساب کاربری
                                <span></span>
                            </router-link>

                        </div>
                    </div>
                </nav>
            </div>
        </div>

    </div>
</template>

<script>
export default {
    name: "Front_Template_Main_Navbar"
}
</script>

<style scoped>

</style>
