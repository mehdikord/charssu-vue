import 'package:charssu/auth/sms_code_screen.dart';
import 'package:charssu/models/http_exception.dart';
import 'package:charssu/providers/auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../widget/bg_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static const routeName = '/auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final _formKey = GlobalKey<FormState>();
  final _phoneFocusNode = FocusNode();

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

  // final GlobalKey<FormState> __formKey = GlobalKey();
  Map<String, String> _authData = {"phone": ""};

  var _isLoading = false;

  Future<dynamic> dialog(String title, var content) {
    return showDialog(
      context: context,
      builder: (ctx) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text(
              title,
              style: TextStyle(
                color: title == "موفق" ? Colors.green : Colors.red,
              ),
            ),
            content: Text(content.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  if (title == "موفق") {
                    Navigator.of(ctx).pop();
                    Navigator.of(ctx).pushNamed(
                      SmsCodeScreen.routeName,
                      arguments: {
                        "phone": _authData["phone"],
                      },
                    );
                  } else {
                    Navigator.of(ctx).pop();
                  }
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
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(
        context,
        listen: false,
      ).login(
        _authData['phone']!,
      );
      await dialog("موفق", "کد تایید با موفقیت ارسال شد.");
    } on HttpException catch (error) {
      await dialog("خطا", error);
    } catch (error) {
      await dialog("خطا", error);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Image backMobileImage;

    return SizedBox(
      child: Stack(
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
                              "assets/images/Icon-Mobail.png",
                              width: MediaQuery.of(context).size.width * 0.1,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          const Text(
                            "شماره همراه خود را وارد نمایید",
                            style: TextStyle(
                              color: Color(0xff646464),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Form(
                          //   key: __formKey,
                          //   child: Column(
                          //     children: [
                          //       SizedBox(
                          //         width: backMobileImage.width! * 0.8,
                          //         child: TextFormField(
                          //           decoration: const InputDecoration(
                          //               labelText: "شماره همراه"),
                          //           keyboardType: TextInputType.phone,
                          //           validator: (value) {
                          //             if (value!.isEmpty) {
                          //               return 'لطفا این قسمت را پر کنید!';
                          //             } else if (value.length != 11) {
                          //               return 'شماره همراه یک فرمت معتبر نیست!';
                          //             }
                          //             return null;
                          //           },
                          //           onSaved: (value) {
                          //             _authData['phone'] = value!;
                          //           },
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: EdgeInsets.only(
                          //           bottom: MediaQuery.of(context).size.height * 0.35 * 0.08,
                          //         ),
                          //         child: _isLoading
                          //             ? const Padding(
                          //                 padding: EdgeInsets.only(top: 8.0),
                          //                 child: CircularProgressIndicator(),
                          //               )
                          //             : RaisedButton(
                          //                 onPressed: _submit,
                          //                 shape: RoundedRectangleBorder(
                          //                   borderRadius:
                          //                       BorderRadius.circular(20),
                          //                 ),
                          //                 padding: EdgeInsets.symmetric(
                          //                   horizontal: MediaQuery.of(context)
                          //                           .size
                          //                           .width *
                          //                       (0.1),
                          //                   vertical: MediaQuery.of(context)
                          //                           .size
                          //                           .width *
                          //                       0.005,
                          //                 ),
                          //                 color: const Color(0xff76d862),
                          //                 textColor: const Color(0xfff5f5f5),
                          //                 child: const Text(
                          //                   "ثبت",
                          //                   style: TextStyle(
                          //                     fontSize: 16,
                          //                     fontWeight: FontWeight.bold,
                          //                   ),
                          //                 ),
                          //               ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          InkWell(
                            onTap: () => FocusScope.of(context)
                                .requestFocus(_phoneFocusNode),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: MediaQuery.of(context).size.width * 0.11,
                              decoration: const BoxDecoration(
                                color: Color(0xff00828f),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                textDirection: TextDirection.ltr,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 2.0),
                                    child: Text(
                                      "0",
                                      style: TextStyle(
                                        color: Color(0xfff5f5f5),
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 5.0,
                                      right: 7.0,
                                      bottom: 2.0,
                                    ),
                                    child: const Text(
                                      "9",
                                      style: TextStyle(
                                        color: Color(0xfff5f5f5),
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Form(
                                      key: _formKey,
                                      child: Container(
                                        width: backMobileImage.width! / 2,
                                        height: double.infinity,
                                        alignment: Alignment.bottomCenter,
                                        padding: const EdgeInsets.only(top: 5),
                                        child: PinCodeTextField(
                                          focusNode: _phoneFocusNode,
                                          textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          appContext: context,
                                          pastedTextStyle: TextStyle(
                                            color: Colors.green.shade600,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          length: 9,
                                          animationType: AnimationType.scale,
                                          // validator: (v) {
                                          //   if (v!.length < 9) {
                                          //     return "اعداد باید ۹ رقم باشند";
                                          //   } else {
                                          //     return null;
                                          //   }
                                          // },
                                          pinTheme: PinTheme(
                                            shape: PinCodeFieldShape.underline,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            fieldHeight: 35,
                                            fieldWidth: 10,
                                            inactiveColor: Colors.white,
                                          ),
                                          cursorColor: Colors.white,
                                          animationDuration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          errorAnimationController:
                                              errorController,
                                          controller: textEditingController,
                                          keyboardType: TextInputType.number,
                                          autoDismissKeyboard: true,
                                          onCompleted: (value) {
                                            _authData['phone'] = "09$value";
                                          },
                                          // onTap: () {
                                          //   print("Pressed");
                                          // },
                                          onChanged: (value) {
                                            setState(() {
                                              currentText = value;
                                            });
                                          },
                                          // onSaved: (value) {
                                          //   _authData['phone'] = value!;
                                          // },
                                          beforeTextPaste: (text) {
                                            return false;
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height *
                                  0.35 *
                                  0.08,
                            ),
                            child: RaisedButton(
                              onPressed: () {
                                _formKey.currentState!.validate();
                                // conditions for validating
                                if (currentText.length != 9) {
                                  errorController!.add(
                                    ErrorAnimationType.shake,
                                  );
                                  setState(() => hasError = true);
                                } else {
                                  try {
                                    int.parse(currentText);
                                    setState(() => hasError = false);
                                    _submit();
                                  } catch (error) {
                                    errorController!.add(
                                      ErrorAnimationType.shake,
                                    );
                                    setState(() => hasError = true);
                                  }
                                }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.1,
                                vertical:
                                    MediaQuery.of(context).size.width * 0.005,
                              ),
                              color: const Color(0xff76d862),
                              textColor: const Color(0xfff5f5f5),
                              child: _isLoading
                                  ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      "ثبت",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
