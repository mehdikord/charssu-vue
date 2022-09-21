import 'package:charssu/dashboard/order_single_screen.dart';
import 'package:charssu/main.dart';
import 'package:charssu/providers/auth.dart';
import 'package:charssu/providers/dashboard.dart';
import 'package:charssu/widget/bottom_navbar.dart';
import 'package:charssu/widget/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/bg_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  static const routeName = "/dashboard";

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late Future _dashboardOrdersFuture;
  late AnimationController _animationController;
  late var newOrder;

  Future _obtainDashboardOrdersFuture() async {
    return Provider.of<Dashboard>(context, listen: false)
        .fetchAndSetDashboardActiveOrders();
  }

  @override
  void initState() {
    _dashboardOrdersFuture = _obtainDashboardOrdersFuture();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animationController.repeat(reverse: true);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Provider.of<Dashboard>(
        context,
        listen: false,
      ).fetchAndSetOrderServiceman().then(
        (value) {
          newOrder = Provider.of<Dashboard>(context, listen: false).newOrder;
          if (newOrder != null) {
            MyHomePage.setNewOrderDialog(context, newOrder);
          }
        },
      ),
    );
  }

  Future<void> changeOnline() async {
    await Provider.of<Dashboard>(context, listen: false).changeOnline();
    await Provider.of<Auth>(context, listen: false).setUser();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('وضعیت دریافت سفارش تغییر یافت.'),
        duration: const Duration(seconds: 5),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Future<dynamic> changeOnlineDialog() {
    return showDialog(
      context: context,
      builder: (c) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: const Text(
              "تغییر وضعیت",
              style: TextStyle(
                color: Colors.orange,
              ),
            ),
            content:
                const Text("آیا وضعیت دریافت سفارش را می خواهید تغییر دهید؟"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(c).pop();
                },
                child: const Text(
                  "خیر",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await changeOnline();
                  Navigator.of(c).pop();
                },
                child: const Text(
                  "تایید",
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
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
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "وضعیت: ",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  if (auth.findUser().isOnline)
                                    FadeTransition(
                                      opacity: _animationController,
                                      child: RaisedButton(
                                        onPressed: () => changeOnlineDialog(),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        color: const Color(0xff6ac04f),
                                        child: const Text(
                                          "فعال",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    )
                                  else
                                    RaisedButton(
                                      onPressed: () => changeOnlineDialog(),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      color: Colors.red,
                                      child: const Text(
                                        "غیرفعال",
                                        style: TextStyle(
                                          color: Color(0xfff5f5f5),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  const Text(
                                    "سرویس در حال انجام",
                                    style: TextStyle(
                                      color: Color(0xff253567),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  FutureBuilder(
                                    future: _dashboardOrdersFuture,
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
                                                fontSize: 18,
                                              ),
                                            ),
                                          );
                                        } else {
                                          return Consumer<Dashboard>(
                                            builder: (ctx, dashbord, _) {
                                              if (dashbord.orders.isNotEmpty) {
                                                return Container(
                                                  width: double.infinity,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0x11000000),
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                      bottom:
                                                          Radius.circular(20),
                                                    ),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Column(
                                                    children: [
                                                      infoRow(
                                                        "شماره: ",
                                                        dashbord.orders
                                                                .first['order']
                                                            ['code'],
                                                      ),
                                                      const Divider(
                                                        color: Colors.black,
                                                      ),
                                                      infoRow(
                                                        "نام مشتری: ",
                                                        dashbord.orders.first[
                                                                    'order']
                                                                ['customer']
                                                            ['name'],
                                                      ),
                                                      const Divider(
                                                        color: Colors.black,
                                                      ),
                                                      infoRow(
                                                        "شماره مشتری: ",
                                                        dashbord.orders.first[
                                                                    'order']
                                                                ['customer']
                                                            ['phone'],
                                                      ),
                                                      const Divider(
                                                        color: Colors.black,
                                                      ),
                                                      infoRow(
                                                        "توضیحات: ",
                                                        dashbord.orders
                                                                .first['order']
                                                            ['description'],
                                                      ),
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: ElevatedButton(
                                                          onPressed: () {
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
                                                          child: const Text(
                                                            "نمایش جزئیات",
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
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

infoRow(title, content) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        if (title == "توضیحات: ")
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                content,
                style: const TextStyle(
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
          )
        else
          Container(
            margin: const EdgeInsets.only(right: 5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              content,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
      ],
    ),
  );
}
