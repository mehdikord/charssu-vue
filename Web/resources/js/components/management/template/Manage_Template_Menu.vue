<template>
    <div class="vertical-menu">

        <div data-simplebar class="h-100">
            <!--- Sidemenu -->
            <div id="sidebar-menu">
                <!-- Left Menu Start -->
                <ul class="metismenu list-unstyled" id="side-menu">
                    <li class="menu-title" data-key="t-menu">داشبورد</li>

                    <li>
                        <router-link :to="{name : 'manage_dashboard'}">
                            <i class="mdi mdi-monitor-dashboard"></i>
                            <span class="badge rounded-pill bg-soft-success text-success float-end">9+</span>
                            <span data-key="t-dashboard">داشبورد مدیریت</span>
                        </router-link>
                    </li>

                    <li class="menu-title text-danger" data-key="t-users">کاربران سیستم</li>
                    <li>
                        <router-link :to="{name : 'manage_users'}">
                            <i class="mdi mdi-account-star"></i>
                            <span data-key="t-managers">مدیران</span>
                        </router-link>
                    </li>
                    <li>
                        <router-link :to="{name : 'manage_customers'}">
                            <i class="mdi mdi-account-group"></i>
                            <span data-key="t-customers">مشتریان</span>
                        </router-link>
                    </li>
                    <li class="menu-title text-danger" data-key="t-servicemans">مدیریت سرویس کاران</li>
                    <li>
                        <router-link :to="{name : 'manage_servicemans_create'}">
                            <i class="mdi mdi-account-plus"></i>
                            <span data-key="t-serviceman-new">سرویس کار جدید</span>
                        </router-link>
                    </li>
                    <li>
                        <router-link :to="{name : 'manage_servicemans'}">
                            <i class="mdi mdi-account-plus"></i>
                            <span data-key="t-serviceman-active">سرویس کاران فعال</span>
                        </router-link>
                    </li>
                    <li class="menu-title text-danger" data-key="t-zones">برند ها و دستگاه ها</li>

                    <li>
                        <router-link :to="{name : 'manage_devices_brands'}">
                            <i class="mdi mdi-label-multiple"></i>
                            <span data-key="t-devices-brands">برند ها</span>
                        </router-link>
                    </li>

                    <li class="menu-title text-danger" data-key="t-zones">مناطق کاری</li>
                    <li>
                        <router-link :to="{name : 'manage_zones'}">
                            <i class="mdi mdi-city"></i>
                            <span data-key="t-zones-manage">منطقه ها</span>
                        </router-link>
                    </li>



                </ul>


            </div>
            <!-- Sidebar -->
        </div>

    </div>
</template>

<script>
export default {
    name: "Manage_Template_Menu"
}
</script>

<style scoped>
i{
    font-size: 24px!important;
}

</style>
