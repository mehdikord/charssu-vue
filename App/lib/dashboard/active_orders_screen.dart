import 'package:charssu/dashboard/order_single_screen.dart';
import 'package:charssu/dashboard/service_item.dart';
import 'package:charssu/main.dart';
import 'package:charssu/providers/auth.dart';
import 'package:charssu/providers/dashboard.dart';
import 'package:charssu/widget/bottom_navbar.dart';
import 'package:charssu/widget/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../widget/bg_widget.dart';

class ActiveOrdersScreen extends StatefulWidget {
  const ActiveOrdersScreen({Key? key}) : super(key: key);

  static const routeName = "/orders/active";

  @override
  State<ActiveOrdersScreen> createState() => ActiveOrdersScreenState();
}

class ActiveOrdersScreenState extends State<ActiveOrdersScreen> {
  late Future _dashboardActiveOrdersFuture;

  Future _obtainDashboardActiveOrdersFuture() {
    return Provider.of<Dashboard>(context, listen: false)
        .fetchAndSetDashboardActiveOrders();
  }

  @override
  void initState() {
    _dashboardActiveOrdersFuture = _obtainDashboardActiveOrdersFuture();
    super.initState();
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
                                Consumer<Auth>(
                                  builder: (ctx, auth, _) => Text(
                                    "کد سرویسکار: ${auth.findUser().code}",
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
                                "assets/images/Icon-Tamirkar.png",
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
                    child: Consumer<Auth>(
                      builder: (context, auth, _) => Column(
                        children: [
                          Text(
                            "${auth.findUser().name} ${auth.findUser().family}",
                            style: const TextStyle(
                              color: Color(0xff253567),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (auth.findUser().isAccepted) ...[
                            const SizedBox(
                              height: 50,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  const Text(
                                    "سرویس های فعال",
                                    style: TextStyle(
                                      color: Color(0xff253567),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Divider(),
                                  FutureBuilder(
                                    future: _dashboardActiveOrdersFuture,
                                    builder: ((context, dataSnapShot) {
                                      if (dataSnapShot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Padding(
                                          padding: EdgeInsets.only(
                                            top: 100.0,
                                          ),
                                          child: CircularProgressIndicator(),
                                        );
                                      } else {
                                        if (dataSnapShot.error != null) {
                                          return const Padding(
                                            padding: EdgeInsets.only(
                                              top: 100.0,
                                            ),
                                            child: Text(
                                              "متاسفانه خطایی رخ داده است!",
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 24,
                                              ),
                                            ),
                                          );
                                        } else {
                                          return Consumer<Dashboard>(
                                            builder: (ctx, dashbord, _) {
                                              if (dashbord.orders.isNotEmpty) {
                                                return Column(
                                                  children: [
                                                    ServiceItem(
                                                      "ردیف",
                                                      "شماره",
                                                      "نام مشتری",
                                                      Container(
                                                        height: 35,
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 2),
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              Color(0xff62bbd8),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .horizontal(
                                                            left:
                                                                Radius.circular(
                                                                    30),
                                                          ),
                                                        ),
                                                        child: const Center(
                                                          child: Text(
                                                            "توضیحات",
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xfff5f5f5),
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const Color(0xff62bbd8),
                                                    ),
                                                    ListView.builder(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      itemCount: dashbord.orders
                                                                  .length >
                                                              7
                                                          ? 7
                                                          : dashbord
                                                              .orders.length,
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemBuilder:
                                                          (context, i) =>
                                                              ServiceItem(
                                                        dashbord.orders[i]
                                                                ['order']['id']
                                                            .toString(),
                                                        dashbord.orders[i]
                                                                ['order']
                                                                ['code']
                                                            .toString(),
                                                        dashbord.orders[i]
                                                                ['order']
                                                                ['customer']
                                                                ['name']
                                                            .toString(),
                                                        InkWell(
                                                          onTap: () {
                                                            Provider.of<Dashboard>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .findSingleOrder(dashbord
                                                                        .orders
                                                                        .first[
                                                                    'order']['id'])
                                                                .then(
                                                                  (value) => Navigator.of(
                                                                          context)
                                                                      .pushNamed(
                                                                          OrderSingleScreen
                                                                              .routeName),
                                                                );
                                                          },
                                                          child: Container(
                                                            height: 35,
                                                            margin:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        2),
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: Color(
                                                                  0xffacacac),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .horizontal(
                                                                left: Radius
                                                                    .circular(
                                                                        30),
                                                              ),
                                                            ),
                                                            child: const Center(
                                                              child: Text(
                                                                "نمایش",
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xfff5f5f5),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const Color(0xffacacac),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              } else {
                                                return const Padding(
                                                  padding: EdgeInsets.only(
                                                    top: 100.0,
                                                  ),
                                                  child: Text(
                                                    "سرویسی یافت نشد!",
                                                    style: TextStyle(
                                                      color: Colors.orange,
                                                      fontSize: 24,
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          );
                                        }
                                      }
                                    }),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ] else ...[
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 4,
                            ),
                            const Text(
                              "در انتظار تایید حساب",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.005,
                  ),
                  const BottomNavbar(0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
