<!doctype html>
<html lang="fa">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>خطا در مراحل تراکنش - چارسو</title>
    <link rel="stylesheet" href="{{asset('template/css/bootstrap.min.css')}}">
    <link rel="stylesheet" href="{{asset('template/css/rtl.css')}}">
    <link rel="stylesheet" href="{{asset('template/css/custom.css')}}">

</head>
<body>
    <div class="container">
        <div class="mt-5">
            <div class="row justify-content-center">

                <div class="col-md-8 mt-4">
                    <div class="card shadow">
                        <div class="card-header bg-danger">
                            <h6 class="p-1 text-light">خطا در مراحل تراکنش</h6>
                        </div>
                        <div class="card-body">
                            <div class="mt-3">
                                <p class="text-danger">
                                    کاربر گرامی در مراحل انجام تراکنش بانکی خطایی رخ داده است ، لطفا مجدد تلاش فرمایید.
                                </p>
                                <h6 class="mt-5 text-secondary">خطای موردنظر :</h6>
                                <p class="text-center text-justify">{{$error ?? 'ناشناخته !'}}</p>
                            </div>
                        </div>
                        <div class="card-footer">
                            <div class="text-center">
                                <a href="/panel/invoices" class="btn btn-info">بازگشت به پنل کاربری چارسو</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
