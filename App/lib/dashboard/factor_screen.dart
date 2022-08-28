import 'package:charssu/main.dart';
import 'package:charssu/providers/auth.dart';
import 'package:charssu/widget/bottom_navbar.dart';
import 'package:charssu/widget/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../widget/bg_widget.dart';

class FactorScreen extends StatefulWidget {
  const FactorScreen({Key? key}) : super(key: key);

  static const routeName = "/orders/factor";

  @override
  State<FactorScreen> createState() => _FactorScreenState();
}

class _FactorScreenState extends State<FactorScreen> {
  Future<dynamic> dialog(title) {
    return showDialog(
      context: context,
      builder: (c) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text(
              title,
              style: const TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text("تست"),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Image backMobileImage;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: const MainDrawer(),
        body: SizedBox(
          child: Stack(
            fit: StackFit.expand,
            children: [
              const BGWidget(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).viewPadding.top,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/Back-Number.png",
                                ),
                                const Text(
                                  "فاکتور سفارش: ۱۲۳۴۵۶",
                                  style: TextStyle(
                                    color: Color(0xff4ae3ed),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Builder(builder: (context) {
                              return InkWell(
                                onTap: () => Scaffold.of(context).openDrawer(),
                                child: Column(
                                  children: [
                                    for (var i = 1; i <= 3; i++)
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                        height: 3,
                                        margin: const EdgeInsets.only(
                                          top: 5.0,
                                        ),
                                        decoration: const BoxDecoration(
                                          color: Color(0xff4ae3ed),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      backMobileImage = Image.asset(
                        "assets/images/Back-Header-Up.png",
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.13,
                      ),
                      SizedBox(
                        height: backMobileImage.height!,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: backMobileImage.height! * 0.2,
                              ),
                              child: Image.asset(
                                "assets/images/Icon-Factor.png",
                                width: MediaQuery.of(context).size.width * 0.1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.85 -
                        backMobileImage.height! -
                        MediaQuery.of(context).viewPadding.top,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: const BoxDecoration(
                      color: Color(0xfff5f5f5),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Factor Number
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.05,
                          padding: const EdgeInsets.only(right: 10),
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xff62bbd8),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "صدور فاکتور شماره",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: double.infinity,
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Center(
                                  child: Text(
                                    "۱۲۳۴۵۶",
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
                        // Price Details
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(vertical: 40),
                          decoration: const BoxDecoration(
                            color: Color(0xffbcdeea),
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            children: [
                              // Extra
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                padding: const EdgeInsets.only(right: 5),
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(30),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "ایاب و ذهاب",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height: double.infinity,
                                      padding: const EdgeInsets.only(right: 5),
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: const Color(0xff62bbd8),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${MyHomePage.numberFormat.format(300000)} ریال",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Part
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                padding: const EdgeInsets.only(right: 5),
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(30),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "قطعه",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height: double.infinity,
                                      padding: const EdgeInsets.only(right: 5),
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: const Color(0xff62bbd8),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${MyHomePage.numberFormat.format(800000)} ریال",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Salary
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                padding: const EdgeInsets.only(right: 5),
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(30),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "دستمزد",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height: double.infinity,
                                      padding: const EdgeInsets.only(right: 5),
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: const Color(0xff62bbd8),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${MyHomePage.numberFormat.format(950000)} ریال",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Coupon
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                padding: const EdgeInsets.only(right: 5),
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(30),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "کد تخفیف",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height: double.infinity,
                                      padding: const EdgeInsets.only(right: 5),
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: const Color(0xff62bbd8),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Total
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                padding: const EdgeInsets.only(right: 5),
                                margin: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 5,
                                ),
                                decoration: const BoxDecoration(
                                  color: Color(0xffd8c662),
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(30),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "جمع کل",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height: double.infinity,
                                      padding: const EdgeInsets.only(right: 5),
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${MyHomePage.numberFormat.format(2050000)} ریال",
                                          style: const TextStyle(
                                            fontSize: 16,
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
                        // Submit Button
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color(0xff6ac04f),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          child: const Text(
                            "ثبت فاکتور",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.005,
                  ),
                  const BottomNavbar(2),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
