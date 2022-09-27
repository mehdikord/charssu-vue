import 'dart:async';

import 'package:charssu/dashboard/factor_screen.dart';
import 'package:charssu/dashboard/new_order_screen.dart';
import 'package:charssu/dashboard/notes/order_notes_screen.dart';
import 'package:charssu/dashboard/products/order_products_screen.dart';
import 'package:charssu/providers/auth.dart';
import 'package:charssu/providers/dashboard.dart';
import 'package:charssu/providers/invoice.dart';
import 'package:charssu/widget/bottom_navbar.dart';
import 'package:charssu/widget/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/bg_widget.dart';

class OrderSingleScreen extends StatefulWidget {
  const OrderSingleScreen({Key? key}) : super(key: key);

  static const routeName = "/orders/show";

  @override
  State<OrderSingleScreen> createState() => _OrderSingleScreenState();
}

class _OrderSingleScreenState extends State<OrderSingleScreen> {
  final _controller = TextEditingController();
  var _isLoadingProduct = false;
  var _isLoadingNote = false;
  var _isLoadingFactor = false;

  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 1);
    return Timer(duration, route);
  }

  route() {
    if (Provider.of<Auth>(context, listen: false).hasNewOrder) {
      Navigator.pushReplacementNamed(context, NewOrderScreen.routeName);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                                Consumer<Dashboard>(
                                  builder: (context, dashboard, _) => Text(
                                    "جزئیات سفارش: ${dashboard.order['code']}",
                                    style: const TextStyle(
                                      color: Color(0xff4ae3ed),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                    child: Consumer<Dashboard>(
                      builder: (context, dashboard, _) => Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.55,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  // Service (Order) Name
                                  Container(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    padding: const EdgeInsets.only(right: 10),
                                    decoration: const BoxDecoration(
                                      color: Color(0xff62bbd8),
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(30),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.68,
                                          height: double.infinity,
                                          margin: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Center(
                                            child: Text(
                                              dashboard.order['title'],
                                              style: const TextStyle(
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
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    decoration: const BoxDecoration(
                                      color: Color(0xffbcdeea),
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(30),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Problem Title
                                        Container(
                                          width: double.infinity,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          decoration: const BoxDecoration(
                                            color: Color(0xffd8c662),
                                            borderRadius:
                                                BorderRadius.horizontal(
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
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.65,
                                                height: double.infinity,
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                margin: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    dashboard.order['problem']
                                                        ['problem'],
                                                    style: const TextStyle(
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          decoration: const BoxDecoration(
                                            color: Color(0xffd8c662),
                                            borderRadius:
                                                BorderRadius.horizontal(
                                              left: Radius.circular(30),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
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
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                    height: double.infinity,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    margin:
                                                        const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color: dashboard.order[
                                                                  'warranty'] ==
                                                              "1"
                                                          ? const Color(
                                                              0xff6ac04f)
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "دارد",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: dashboard.order[
                                                                      'warranty'] ==
                                                                  "1"
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                    height: double.infinity,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    margin:
                                                        const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color: dashboard.order[
                                                                  'warranty'] !=
                                                              "1"
                                                          ? const Color(
                                                              0xff6ac04f)
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "ندارد",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: dashboard.order[
                                                                      'warranty'] !=
                                                                  "1"
                                                              ? Colors.white
                                                              : Colors.black,
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          decoration: const BoxDecoration(
                                            color: Color(0xffd8c662),
                                            borderRadius:
                                                BorderRadius.horizontal(
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
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.65,
                                                height: double.infinity,
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                margin: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    dashboard
                                                        .order['warranty_date'],
                                                    style: const TextStyle(
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          decoration: const BoxDecoration(
                                            color: Color(0xffd8c662),
                                            borderRadius:
                                                BorderRadius.horizontal(
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
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.65,
                                                height: double.infinity,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                margin: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: SingleChildScrollView(
                                                  child: Text(
                                                    dashboard
                                                        .order['description'],
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
                                  // Customer Details
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    decoration: const BoxDecoration(
                                      color: Color(0xffbcdeea),
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(30),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Name
                                        Container(
                                          width: double.infinity,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          decoration: const BoxDecoration(
                                            color: Color(0xffd8c662),
                                            borderRadius:
                                                BorderRadius.horizontal(
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
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.65,
                                                height: double.infinity,
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                margin: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    dashboard.order['customer']
                                                        ['name'],
                                                    style: const TextStyle(
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          decoration: const BoxDecoration(
                                            color: Color(0xffd8c662),
                                            borderRadius:
                                                BorderRadius.horizontal(
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
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.65,
                                                height: double.infinity,
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                margin: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    dashboard.order['customer']
                                                        ['phone'],
                                                    style: const TextStyle(
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          decoration: const BoxDecoration(
                                            color: Color(0xffd8c662),
                                            borderRadius:
                                                BorderRadius.horizontal(
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
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.65,
                                                height: double.infinity,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                margin: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: SingleChildScrollView(
                                                  child: Text(
                                                    dashboard.order['customer']
                                                        ['address'],
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
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              // Buttons
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // Report Button
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        setState(() {
                                          _isLoadingNote = true;
                                        });
                                        await Navigator.of(context).pushNamed(
                                          OrderNotesScreen.routeName,
                                          arguments:
                                              dashboard.order['id'].toString(),
                                        );
                                        setState(() {
                                          _isLoadingNote = false;
                                        });
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          const Color(0xffd86262),
                                        ),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                      ),
                                      child: _isLoadingNote
                                          ? const SizedBox(
                                              width: 22.0,
                                              height: 22.0,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            )
                                          : const Text(
                                              "گزارش",
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                    ),
                                  ),
                                  // Part Button
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        setState(() {
                                          _isLoadingProduct = true;
                                        });
                                        await dashboard
                                            .fetchAndSetProducts()
                                            .then((value) => dashboard
                                                .fetchAndSetProductCategories())
                                            .then(
                                              (val) => Navigator.of(context)
                                                  .pushNamed(
                                                OrderProductsScreen.routeName,
                                                arguments: dashboard.order['id']
                                                    .toString(),
                                              ),
                                            );
                                        setState(() {
                                          _isLoadingProduct = false;
                                        });
                                      },
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                      ),
                                      child: _isLoadingProduct
                                          ? const SizedBox(
                                              width: 22.0,
                                              height: 22.0,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            )
                                          : const Text(
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
                                  onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) => Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: StatefulBuilder(
                                        builder: (context, setState) =>
                                            AlertDialog(
                                          title: const Text(
                                            "صدور فاکتور",
                                            style: TextStyle(
                                              color: Colors.green,
                                            ),
                                          ),
                                          content: const Text(
                                            "آیا مطمئن هستید؟",
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                "خیر",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                setState(() {
                                                  _isLoadingFactor = true;
                                                });
                                                await Provider.of<Invoice>(
                                                        context,
                                                        listen: false)
                                                    .makeOrderInvoice(
                                                        dashboard.order['id'])
                                                    .then(
                                                      (value) => Provider.of<
                                                                  Invoice>(
                                                              context,
                                                              listen: false)
                                                          .fetchAndSetOrderInvoice(
                                                              dashboard
                                                                  .order['id'])
                                                          .then(
                                                        (val) {
                                                          Navigator.of(context)
                                                              .pushReplacementNamed(
                                                            FactorScreen
                                                                .routeName,
                                                          );
                                                        },
                                                      ),
                                                    );
                                                setState(() {
                                                  _isLoadingFactor = false;
                                                });
                                              },
                                              child: _isLoadingFactor
                                                  ? const SizedBox(
                                                      width: 22.0,
                                                      height: 22.0,
                                                      child:
                                                          CircularProgressIndicator(),
                                                    )
                                                  : const Text(
                                                      "بله",
                                                      style: TextStyle(
                                                          color: Colors.green),
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
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
                                  child: _isLoadingFactor
                                      ? const SizedBox(
                                          width: 22.0,
                                          height: 22.0,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : Text(
                                          dashboard.order['is_done'] == 1
                                              ? "نمایش فاکتور"
                                              : "صدور فاکتور و اتمام سرویس",
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                ),
                              ),
                            ],
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
