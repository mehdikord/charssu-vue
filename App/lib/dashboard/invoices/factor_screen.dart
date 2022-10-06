import 'dart:async';

import 'package:charssu/dashboard/done_orders_screen.dart';
import 'package:charssu/dashboard/invoices/factor_item.dart';
import 'package:charssu/dashboard/new_order_screen.dart';
import 'package:charssu/main.dart';
import 'package:charssu/providers/auth.dart';
import 'package:charssu/providers/dashboard.dart';
import 'package:charssu/providers/invoice.dart';
import 'package:charssu/widget/bottom_navbar.dart';
import 'package:charssu/widget/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../widget/bg_widget.dart';

class FactorScreen extends StatefulWidget {
  const FactorScreen({Key? key}) : super(key: key);

  static const routeName = "/orders/factor";

  @override
  State<FactorScreen> createState() => _FactorScreenState();
}

class _FactorScreenState extends State<FactorScreen> {
  var _isLoadingDone = false;
  var _isLoadingDelete = false;
  var _isLoadingPayment = false;

  // @override
  // void initState() {
  //   super.initState();
  //   startTime();
  // }

  // startTime() async {
  //   var duration = const Duration(seconds: 1);
  //   return Timer(duration, route);
  // }

  // route() {
  //   if (Provider.of<Auth>(context, listen: false).hasNewOrder) {
  //     Navigator.pushReplacementNamed(context, NewOrderScreen.routeName);
  //   }
  // }

  Future<dynamic> dialog(result) {
    return showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text(
              result.runtimeType == String ? "موفق" : "خطا",
              style: TextStyle(
                color: result.runtimeType == String ? Colors.green : Colors.red,
              ),
            ),
            content:
                Text(result.runtimeType == String ? result : result['error']),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("تایید"),
              ),
            ],
          ),
        ),
      ),
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
              Consumer<Dashboard>(
                builder: (context, dashboard, _) => Column(
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
                          Consumer<Dashboard>(
                            builder: (context, dashboard, _) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/Back-Number.png",
                                    ),
                                    Text(
                                      "فاکتور سفارش: ${dashboard.order['code']}",
                                      style: const TextStyle(
                                        color: Color(0xff4ae3ed),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Builder(builder: (context) {
                                return InkWell(
                                  onTap: () =>
                                      Scaffold.of(context).openDrawer(),
                                  child: Column(
                                    children: [
                                      for (var i = 1; i <= 3; i++)
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
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
                      child: Consumer<Invoice>(
                        builder: (context, invoice, _) => Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.55,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: invoice.items.length,
                                      itemBuilder: (ctx, i) =>
                                          FactorItem(invoice.items[i]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Buttons
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Report Button
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: StatefulBuilder(
                                                builder: (context, setState) =>
                                                    AlertDialog(
                                                  title: const Text(
                                                    "هشدار",
                                                    style: TextStyle(
                                                      color: Colors.orange,
                                                    ),
                                                  ),
                                                  content: const Text(
                                                      "آیا مطمئن هستید؟"),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(),
                                                      child: const Text(
                                                        "خیر",
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        setState(() {
                                                          _isLoadingDelete =
                                                              true;
                                                        });
                                                        await Provider.of<
                                                                    Invoice>(
                                                                context,
                                                                listen: false)
                                                            .deleteOrderInvoice(
                                                                dashboard.order[
                                                                    'id'])
                                                            .then(
                                                          (result) {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            if (result
                                                                    .runtimeType ==
                                                                String) {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            }
                                                            dialog(result);
                                                          },
                                                        );
                                                        setState(() {
                                                          _isLoadingDelete =
                                                              false;
                                                        });
                                                      },
                                                      child: _isLoadingDelete
                                                          ? const SizedBox(
                                                              width: 22.0,
                                                              height: 22.0,
                                                              child:
                                                                  CircularProgressIndicator())
                                                          : const Text("بله"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
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
                                        child: const Text(
                                          "حذف",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Part Button
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            _isLoadingDone = true;
                                          });
                                          await Provider.of<Invoice>(context,
                                                  listen: false)
                                              .setDoneOrderInvoice(
                                                  dashboard.order['id'])
                                              .then(
                                            (result) {
                                              if (result.runtimeType ==
                                                  String) {
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        DoneOrdersScreen
                                                            .routeName);
                                              }
                                              dialog(result);
                                            },
                                          );
                                          setState(() {
                                            _isLoadingDone = false;
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
                                        child: _isLoadingDone
                                            ? const SizedBox(
                                                width: 22.0,
                                                height: 22.0,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                              )
                                            : const Text(
                                                "اتمام سرویس",
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        _isLoadingPayment = true;
                                      });
                                      setState(() {
                                        _isLoadingPayment = false;
                                      });
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        const Color(0xff6ac04f),
                                      ),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),
                                    child: _isLoadingPayment
                                        ? const SizedBox(
                                            width: 22.0,
                                            height: 22.0,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          )
                                        : const Text(
                                            "پرداخت",
                                            style: TextStyle(
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
                    const BottomNavbar(2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
