<!doctype html>
<html lang="fa">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="enamad" content="834882"/>

    <!-- Bootstrap Min CSS -->
    <link rel="stylesheet" href="{{asset('template/css/bootstrap.min.css')}}">
    <!-- Animate Min CSS -->
    <link rel="stylesheet" href="{{asset('template/css/animate.min.css')}}">
    <!-- FlatIcon CSS -->
    <!-- Odometer Min CSS -->
    <link rel="stylesheet" href="{{asset('template/css/odometer.min.css')}}">
    <!-- MeanMenu CSS -->
    <link rel="stylesheet" href="{{asset('template/css/meanmenu.css')}}">
    <!-- Magnific Popup Min CSS -->
    <link rel="stylesheet" href="{{asset('template/css/magnific-popup.min.css')}}">
    <!-- Nice Select Min CSS -->
{{--    <link rel="stylesheet" href="{{asset('template/css/nice-select.min.css')}}">--}}
<!-- Owl Carousel Min CSS -->
    <link rel="stylesheet" href="{{asset('template/css/owl.carousel.min.css')}}">
    <!-- Font Awesome Min CSS -->
    <!-- Style CSS -->
    <link rel="stylesheet" href="{{asset('template/css/style.css')}}">
    <!-- RTL CSS -->

    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/@mdi/font@6.9.96/css/materialdesignicons.min.css">

    <link rel="stylesheet" href="{{asset('template/css/rtl.css')}}">
    <!-- Responsive CSS -->

    <link rel="stylesheet" href="{{asset('template/css/responsive.css')}}">
    <link rel="stylesheet" href="{{asset('fonts/fonts.css')}}">
    <link rel="stylesheet" href="{{asset('template/css/custom.css')}}">
    <title>چارسو</title>
    <link rel="icon"  href="{{asset('logo.png')}}">
</head>

<body>

<!-- Preloader -->
<div class="preloader">
    <div class="loader">
        <div class="shadow"></div>
        <div class="box"></div>
    </div>
</div>
<!-- End Preloader -->

<!-- Start Navbar Area -->
<div id="app">

    <front_template_main_navbar></front_template_main_navbar>
    <!-- End Navbar Area -->


    <router-view></router-view>


    <!-- Start Footer Section -->
    <front_template_main_footer></front_template_main_footer>
    <!-- End Footer Section -->


</div>



<!-- Start Copy Right Section -->
<div class="copyright-area">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6 col-md-6">
                <p>
                    <i class="far fa-copyright"></i>
                    طراحی، توسعه و پشتیبانی :
                    <a href="" target="_blank">
                        هیرکانت - Hirkanet
                    </a>
                </p>
            </div>

            <div class="col-lg-6 col-md-6">
                <ul>
                    <li>
                        <a href="">قوانین و مقررات</a>
                    </li>
                    <li>
                        <a href="">حفظ حریم خصوصی</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
<!-- End Copy Right Section -->

<!-- Start Go Top Section -->
<div class="go-top">
    <i class="fas fa-chevron-up"></i>
    <i class="fas fa-chevron-up"></i>
</div>
<!-- End Go Top Section -->

<!-- jQuery Min JS -->
<script src="{{asset('template/js/jquery.min.js')}}"></script>
<!-- Popper Min JS -->
<script src="{{asset('template/js/popper.min.js')}}"></script>
<!-- Bootstrap Min JS -->
<script src="{{asset('template/js/bootstrap.min.js')}}"></script>

<!-- MeanMenu JS  -->
<script src="{{asset('template/js/jquery.meanmenu.js')}}"></script>
<!-- Appear Min JS -->
<script src="{{asset('template/js/jquery.appear.min.js')}}"></script>
<!-- Odometer Min JS -->
<script src="{{asset('template/js/odometer.min.js')}}"></script>
<!-- Owl Carousel Min JS -->
<script src="{{asset('template/js/owl.carousel.min.js')}}"></script>
<!-- Magnific Popup Min JS -->
<script src="{{asset('template/js/jquery.magnific-popup.min.js')}}"></script>

<script src="{{asset('template/js/jquery.ajaxchimp.min.js')}}"></script>
<!-- WOW Min JS -->
<script src="{{asset('template/js/wow.min.js')}}"></script>
<!-- Form Validator Min JS -->
<script src="{{asset('template/js/form-validator.min.js')}}"></script>
<!-- Contact Form Min JS -->
<script src="{{asset('template/js/contact-form-script.js')}}"></script>

<script src="{{asset('template/js/main.js')}}"></script>
<script src="{{asset('js/app.js')}}" defer></script>

</body>

</html>
