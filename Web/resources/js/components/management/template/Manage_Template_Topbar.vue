<template>
    <header id="page-topbar">
        <div class="navbar-header">
            <div class="d-flex">
                <!-- LOGO -->
                <div class="navbar-brand-box">
                    <a href="" class="logo logo-dark">
                            <span class="logo-sm">
                                <img src="/logo.png" alt="" height="30">
                            </span>
                        <span class="logo-lg">
                                <img src="/logo.png" alt="" height="24"> <span
                            class="logo-txt">چارسو</span>
                            </span>
                    </a>

                    <a href="" class="logo logo-light">
                            <span class="logo-sm">
                                <img src="/logo.png" alt="" height="30">
                            </span>
                        <span class="logo-lg">
                                <img src="/logo.png" alt="" height="24"> <span
                            class="logo-txt">چارسو</span>
                            </span>
                    </a>
                </div>

                <button type="button" class="btn btn-sm px-3 font-size-16 header-item" id="vertical-menu-btn">
                    <i class="mdi mdi-view-list mdi-24px"></i>
                </button>

                <!-- App Search-->
                <form class="app-search d-none d-lg-block">
                    <div class="position-relative">
                        <input type="search" class="form-control" placeholder="جستجو">
                        <button class="btn btn-primary" type="button"><i
                            class="bx bx-search-alt align-middle"></i></button>
                    </div>
                </form>
            </div>

            <div class="d-flex">

                <div class="dropdown d-inline-block d-lg-none ms-2">
                    <button type="button" class="btn header-item" id="page-header-search-dropdown"
                            data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i data-feather="search" class="icon-lg"></i>
                    </button>
                    <div class="dropdown-menu dropdown-menu-lg dropdown-menu-end p-0"
                         aria-labelledby="page-header-search-dropdown">

                        <form class="p-3">
                            <div class="form-group m-0">
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="Search ..."
                                           aria-label="Search Result">

                                    <button class="btn btn-primary" type="submit"><i
                                        class="mdi mdi-magnify"></i></button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>


                <div class="dropdown d-none d-sm-inline-block">
                    <button type="button" class="btn header-item" id="mode-setting-btn">
                        <i data-feather="moon" class="icon-lg layout-mode-dark"></i>
                        <i data-feather="sun" class="icon-lg layout-mode-light"></i>
                    </button>
                </div>
                <template v-if="UserAuthCheck()">
                    <div class="dropdown d-inline-block">
                        <button type="button" class="btn header-item noti-icon position-relative"
                                id="page-header-notifications-dropdown" data-bs-toggle="dropdown" aria-haspopup="true"
                                aria-expanded="false">
                            <i data-feather="bell" class="icon-lg"></i>
                            <span class="badge bg-success rounded-pill">5</span>
                        </button>
                        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-end p-0"
                             aria-labelledby="page-header-notifications-dropdown">
                            <div class="p-3">
                                <div class="row align-items-center">
                                    <div class="col">
                                        <h6 class="m-0"> اعلانات </h6>
                                    </div>

                                </div>
                            </div>
                            <div data-simplebar style="max-height: 230px;">
                                <a href="#!" class="text-reset notification-item">
                                    <div class="d-flex">
                                        <div class="flex-shrink-0 me-3">
                                            <img src="/images/default/user.png" class="rounded-circle avatar-sm"
                                                 alt="user-pic">
                                        </div>
                                        <div class="flex-grow-1">
                                            <h6 class="mb-1">James Lemire</h6>
                                            <div class="font-size-13 text-muted">
                                                <p class="mb-1">It will seem like simplified English.</p>
                                                <p class="mb-0"><i class="mdi mdi-clock-outline"></i> <span>1 hours
                                                        ago</span></p>
                                            </div>
                                        </div>
                                    </div>
                                </a>

                            </div>
                            <div class="p-2 border-top d-grid">
                                <a class="btn btn-sm btn-link font-size-14 text-center" href="javascript:void(0)">
                                    <i class="mdi mdi-arrow-right-circle me-1"></i> <span>مشاهده همه</span>
                                </a>
                            </div>
                        </div>
                    </div>


                    <div class="dropdown d-inline-block">
                        <button type="button" class="btn header-item bg-soft-light border-start border-end"
                                id="page-header-user-dropdown" data-bs-toggle="dropdown" aria-haspopup="true"
                                aria-expanded="false">
                            <img class="rounded-circle header-profile-user" src="/images/default/user.png"
                                 alt="Header Avatar">
                            <span class="d-none d-xl-inline-block ms-1 fw-medium">{{UserAuthGet().name}}</span>
                            <i class="mdi mdi-chevron-down d-none d-xl-inline-block"></i>
                        </button>
                        <div class="dropdown-menu dropdown-menu-end">
                            <!-- item-->
                            <a class="dropdown-item" href=""><i class="mdi mdi-face-profile font-size-16 align-middle me-1"></i> پروفایل کاربری</a>

                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item text-danger" href=""><i class="mdi mdi-logout font-size-16 align-middle me-1"></i> خروج از حساب</a>
                        </div>
                    </div>
                </template>


            </div>
        </div>
    </header>
</template>

<script>
export default {
    name: "Manage_Template_Topbar"
}
</script>

<style scoped>

</style>
