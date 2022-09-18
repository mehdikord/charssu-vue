import 'package:charssu/dashboard/dashboard_screen.dart';
import 'package:charssu/information/information_screen.dart';
import 'package:charssu/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'dart:async';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../widget/bg_widget.dart';

class SmsCodeScreen extends StatefulWidget {
  const SmsCodeScreen({Key? key}) : super(key: key);

  static const routeName = '/auth/check';

  @override
  State<SmsCodeScreen> createState() => _SmsCodeScreenState();
}

class _SmsCodeScreenState extends State<SmsCodeScreen> {
  TextEditingController textEditingController = TextEditingController();
  final CountdownController _controller = CountdownController(autoStart: true);
  bool timerEnabled = true;

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    "phone": "",
    "code": "",
  };

  var _isLoading = false;

  Future<dynamic> dialog(var content) {
    return showDialog(
      context: context,
      builder: (ctx) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: const Text(
              "خطا",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            content: Text(content.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text("تایید"),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _submit() async {
    if (!formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(
        context,
        listen: false,
      ).loginCheck(
        _authData['phone']!,
        _authData['code']!,
      );
      await Provider.of<Auth>(context, listen: false).setUser();
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed(
        Provider.of<Auth>(context, listen: false).findUser().name.isEmpty
            ? InformationScreen.routeName
            : DashboardScreen.routeName,
      );
      // await Navigator.of(context).pushReplacementNamed(MyHomePage.routeName);
    } catch (error) {
      await dialog(error);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Image backMobileImage;
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, String?>;
    final phone = arguments['phone'];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            const BGWidget(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      backMobileImage = Image.asset(
                        "assets/images/Back-Mobile.png",
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height *
                                    0.35 *
                                    0.1,
                              ),
                              child: Image.asset(
                                "assets/images/Icon-Code.png",
                                width: MediaQuery.of(context).size.width * 0.11,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            const Text(
                              "لطفا کد ارسال شده را وارد نمایید",
                              style: TextStyle(
                                color: Color(0xff646464),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Form(
                            //   key: _formKey,
                            //   child: SingleChildScrollView(
                            //     child: Column(
                            //       children: [
                            //         SizedBox(
                            //           width: backMobileImage.width! * 0.8,
                            //           child: TextFormField(
                            //             decoration: const InputDecoration(
                            //                 labelText:
                            //                     "کد تایید را وارد کنید"),
                            //             keyboardType: TextInputType.number,
                            //             validator: (value) {
                            //               if (value!.isEmpty) {
                            //                 return 'کد تایید را لطفا پر کنید!';
                            //               } else if (value.length != 6) {
                            //                 return 'کد تایید باید 6 رقم باشد!';
                            //               }
                            //               return null;
                            //             },
                            //             onSaved: (value) {
                            //               _authData['phone'] = phone!;
                            //               _authData['code'] = value!;
                            //             },
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    Container(
                                      width: backMobileImage.width! / 1.5,
                                      child: PinCodeTextField(
                                        // dialogConfig: DialogConfig(
                                        //   dialogTitle: "چسباندن کد",
                                        //   dialogContent:
                                        //       "آیا مطمئن هستید می خواهید عبارت زیر را بچسبانید؟\n",
                                        //   affirmativeText: "بله",
                                        //   negativeText: "خیر",
                                        // ),
                                        appContext: context,
                                        pastedTextStyle: TextStyle(
                                          color: Colors.green.shade600,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        length: 6,
                                        animationType: AnimationType.scale,
                                        // validator: (v) {
                                        //   if (v!.length < 6) {
                                        //     return "I'm from validator";
                                        //   } else {
                                        //     return null;
                                        //   }
                                        // },
                                        pinTheme: PinTheme(
                                          shape: PinCodeFieldShape.underline,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          fieldHeight: 40,
                                          fieldWidth: 30,
                                          inactiveColor:
                                              const Color(0xff224372),
                                        ),
                                        cursorColor: Colors.black,
                                        animationDuration:
                                            const Duration(milliseconds: 300),
                                        errorAnimationController:
                                            errorController,
                                        controller: textEditingController,
                                        keyboardType: TextInputType.number,
                                        autoDismissKeyboard: true,
                                        onCompleted: (value) {
                                          _authData['phone'] = phone!;
                                          _authData['code'] = value;
                                        },
                                        // onTap: () {
                                        //   print("Pressed");
                                        // },
                                        onChanged: (value) {
                                          setState(() {
                                            currentText = value;
                                          });
                                        },
                                        beforeTextPaste: (text) {
                                          return false;
                                        },
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.35 *
                                                0.02,
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.35 *
                                                0.08,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.35 *
                                                0.02,
                                          ),
                                          child: RaisedButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  (0.05),
                                              vertical: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.005,
                                            ),
                                            color: const Color(0xffd8c662),
                                            textColor: const Color(0xfff5f5f5),
                                            child: const Text(
                                              "ویرایش شماره",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (timerEnabled)
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.35 *
                                                  0.02,
                                              bottom: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.35 *
                                                  0.08,
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.35 *
                                                  0.02,
                                            ),
                                            child: RaisedButton(
                                              onPressed: () {
                                                formKey.currentState!
                                                    .validate();
                                                // conditions for validating
                                                if (currentText.length != 6) {
                                                  errorController!.add(
                                                    ErrorAnimationType.shake,
                                                  ); // Triggering error shake animation
                                                  setState(
                                                      () => hasError = true);
                                                } else {
                                                  setState(
                                                    () {
                                                      hasError = false;
                                                    },
                                                  );
                                                  _submit();
                                                }
                                              },
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        (0.1),
                                                vertical: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.005,
                                              ),
                                              color: const Color(0xff76d862),
                                              textColor:
                                                  const Color(0xfff5f5f5),
                                              child: _isLoading
                                                  ? const SizedBox(
                                                      width: 25,
                                                      height: 25,
                                                      child:
                                                          CircularProgressIndicator(),
                                                    )
                                                  : const Text(
                                                      "ثبت",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // ==== TIMER =====
            if (timerEnabled)
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom == 0
                          ? MediaQuery.of(context).size.height * 0.15
                          : 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: const Color(0xff4ae3ed),
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color(0x00000000),
                      foregroundColor: const Color(0xff4ae3ed),
                      child: Countdown(
                        // controller: _controller,
                        seconds: 120,
                        build: (context, double time) => Text(
                          time.ceil().toString(),
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        interval: const Duration(seconds: 1),
                        onFinished: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('زمان وارد کردن کد به پایان رسید!'),
                            ),
                          );
                          setState(() {
                            timerEnabled = !timerEnabled;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
