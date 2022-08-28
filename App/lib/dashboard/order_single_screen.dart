import 'package:charssu/dashboard/factor_screen.dart';
import 'package:charssu/main.dart';
import 'package:charssu/providers/auth.dart';
import 'package:charssu/providers/dashboard.dart';
import 'package:charssu/widget/bottom_navbar.dart';
import 'package:charssu/widget/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../widget/bg_widget.dart';

class OrderSingleScreen extends StatefulWidget {
  const OrderSingleScreen({Key? key}) : super(key: key);

  static const routeName = "/orders/show";

  @override
  State<OrderSingleScreen> createState() => _OrderSingleScreenState();
}

class _OrderSingleScreenState extends State<OrderSingleScreen> {
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
            content: Container(
              width: double.infinity,
              child: Column(
                children: [
                  // Add Button
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ElevatedButton(
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
                        "ثبت",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  // All Button
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      child: const Text(
                        "مشاهده",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Image backMobileImage;
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final order = Provider.of<Dashboard>(context, listen: false)
        .findSingleOrder(arguments['id']);

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
                                  "جزئیات سفارش: ۱۲۳۴۵۶",
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
                                "assets/images/Icon-Service.png",
                                width: MediaQuery.of(context).size.width * 0.13,
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Service (Order) Name
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.05,
                            padding: const EdgeInsets.only(right: 10),
                            decoration: const BoxDecoration(
                              color: Color(0xff62bbd8),
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(30),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "نام سرویس",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.68,
                                  height: double.infinity,
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "تعمیر پکیج دیواری مدل MR45",
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
                          // Order Details
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: const BoxDecoration(
                              color: Color(0xffbcdeea),
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(30),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Problem Title
                                Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  padding: const EdgeInsets.only(right: 5),
                                  margin: const EdgeInsets.only(bottom: 10),
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
                                        "عنوان مشکل",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.65,
                                        height: double.infinity,
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "روشن نشدن شمعک",
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Warranty
                                Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  padding: const EdgeInsets.only(right: 5),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: const BoxDecoration(
                                    color: Color(0xffd8c662),
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(30),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "دستگاه گارانتی",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 30),
                                      Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            height: double.infinity,
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            margin: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: const Color(0xff6ac04f),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "دارد",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            height: double.infinity,
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            margin: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "ندارد",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // Warranty Date
                                Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  padding: const EdgeInsets.only(right: 5),
                                  margin: const EdgeInsets.only(bottom: 10),
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
                                        "تاریخ گارانتی",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.65,
                                        height: double.infinity,
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "۱۴۰۱/۰۳/۱۵",
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Description
                                Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.width * 0.3,
                                  padding: const EdgeInsets.only(right: 5),
                                  margin: const EdgeInsets.only(bottom: 10),
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
                                        "توضیح کامل",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.65,
                                        height: double.infinity,
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: const SingleChildScrollView(
                                          child: Text(
                                            "مدتی است که شمعک پکیج روشن نمی شود و یا اگر روشن شود در مدت زمان کوتاهی خاموش می شود. مدتی است که شمعک پکیج روشن نمی شود و یا اگر روشن شود در مدت زمان کوتاهی خاموش می شود. مدتی است که شمعک پکیج روشن نمی شود و یا اگر روشن شود در مدت زمان کوتاهی خاموش می شود.",
                                            style: TextStyle(
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
                          // Customer Details
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: const BoxDecoration(
                              color: Color(0xffbcdeea),
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(30),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Name
                                Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  padding: const EdgeInsets.only(right: 5),
                                  margin: const EdgeInsets.only(bottom: 10),
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
                                        "نام مشتری",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.65,
                                        height: double.infinity,
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "رضا حسینی",
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Mobile
                                Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  padding: const EdgeInsets.only(right: 5),
                                  margin: const EdgeInsets.only(bottom: 10),
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
                                        "شماره موبایل",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.65,
                                        height: double.infinity,
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "۰۹۳۵۶۲۱۲۵۵۵",
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Address
                                Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.width * 0.3,
                                  padding: const EdgeInsets.only(right: 5),
                                  margin: const EdgeInsets.only(bottom: 10),
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
                                        "آدرس مشتری",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.65,
                                        height: double.infinity,
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: const SingleChildScrollView(
                                          child: Text(
                                            "تست آدرس کامل و دقیق مشتری",
                                            style: TextStyle(
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
                          // Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Report Button
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: ElevatedButton(
                                  onPressed: () => dialog("گزارش"),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      const Color(0xffd86262),
                                    ),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    "گزارش",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              // Part Button
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: ElevatedButton(
                                  onPressed: () => dialog("قطعه"),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    "قطعه",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Submit Button
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            margin: const EdgeInsets.only(bottom: 10),
                            child: ElevatedButton(
                              onPressed: () => Navigator.of(context).pushNamed(
                                FactorScreen.routeName,
                              ),
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
                                "صدور فاکتور و اتمام سرویس",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.005,
                  ),
                  const BottomNavbar(1),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}