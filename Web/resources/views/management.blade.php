<!doctype html>
<html lang="en" style="direction: rtl;">

<head>

    <meta charset="utf-8" />
    <title>مدیریت چارسو</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta content="Premium Multipurpose Admin & Dashboard Template" name="description" />
    <meta content="Themesbrand" name="author" />
    <!-- App favicon -->
    <link rel="shortcut icon" href="{{ asset('manage/images/favicon.ico') }}">

    <!-- preloader css -->
    <link rel="stylesheet" href="{{ asset('manage/css/preloader.min.css') }}" type="text/css" />

    <!-- Bootstrap Css -->
    <link href="{{ asset('manage/css/bootstrap-rtl.min.css') }}" rel="stylesheet" type="text/css" />
    <!-- Icons Css -->
    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/@mdi/font@6.9.96/css/materialdesignicons.min.css">
    <link href='https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css' rel='stylesheet'>


    <!-- App Css-->
    <link href="{{ asset('manage/css/app-rtl.min.css') }}" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="{{ asset('manage/css/custom.css') }}">

</head>

<body data-topbar="dark">

<!-- <body data-layout="horizontal"> -->

<!-- Begin page -->
<div id="layout-wrapper">
<div id="app">

    <manage_template_top_bar></manage_template_top_bar>

    <!-- ========== Left Sidebar Start ========== -->
    <manage_template_menu></manage_template_menu>
    <!-- Left Sidebar End -->


    <!-- ============================================================== -->
    <!-- Start right Content here -->
    <!-- ============================================================== -->
    <div class="main-content">

        <manage_template_main_content></manage_template_main_content>

        <!-- End Page-content -->

        <footer class="footer">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-sm-6">

                    </div>
                    <div class="col-sm-6">
                        <div class="text-sm-end d-none d-sm-block">
                            طراحی ، توسعه و پشتیبانی : <a  class="text-decoration-underline">HirkaNet</a>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
    </div>
    <!-- end main content-->
</div>



</div>
<!-- END layout-wrapper -->




<!-- Right bar overlay-->
<div class="rightbar-overlay"></div>

<!-- JAVASCRIPT -->
<script src="{{ asset('manage/libs/jquery/jquery.min.js') }}"></script>
<script src="{{ asset('manage/libs/bootstrap/js/bootstrap.bundle.min.js') }}"></script>
<script src="{{ asset('manage/libs/metismenu/metisMenu.min.js') }}"></script>
<script src="{{ asset('manage/libs/simplebar/simplebar.min.js') }}"></script>
<script src="{{ asset('manage/libs/node-waves/waves.min.js') }}"></script>
<script src="{{ asset('manage/libs/feather-icons/feather.min.js') }}"></script>
<!-- pace js -->
<script src="{{ asset('manage/libs/pace-js/pace.min.js') }}"></script>

<script src="{{ asset('manage/js/app.js') }}"></script>

<script src="{{ asset('js/management.js') }}" defer></script>

</body>

</html>
