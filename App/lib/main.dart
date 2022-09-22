import 'package:charssu/auth/sms_code_screen.dart';
import 'package:charssu/dashboard/active_orders_screen.dart';
import 'package:charssu/dashboard/dashboard_screen.dart';
import 'package:charssu/dashboard/done_orders_screen.dart';
import 'package:charssu/dashboard/factor_screen.dart';
import 'package:charssu/dashboard/notes/order_notes_screen.dart';
import 'package:charssu/dashboard/order_single_screen.dart';
import 'package:charssu/dashboard/products/order_products_screen.dart';
import 'package:charssu/information/information_screen.dart';
import 'package:charssu/providers/auth.dart';
import 'package:charssu/providers/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' show NumberFormat;

import 'auth/auth_screen.dart';
import 'loading_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Dashboard(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          // debugShowCheckedModeBanner: false,
          title: 'Charssu',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Vazirmatn',
          ),
          routes: {
            MyHomePage.routeName: (ctx) => const MyHomePage(),
            AuthScreen.routeName: (ctx) => const AuthScreen(),
            SmsCodeScreen.routeName: (ctx) => const SmsCodeScreen(),
            InformationScreen.routeName: (ctx) => const InformationScreen(),
            DashboardScreen.routeName: (ctx) => const DashboardScreen(),
            DoneOrdersScreen.routeName: (ctx) => const DoneOrdersScreen(),
            ActiveOrdersScreen.routeName: (ctx) => const ActiveOrdersScreen(),
            OrderSingleScreen.routeName: (ctx) => const OrderSingleScreen(),
            OrderNotesScreen.routeName: (ctx) => const OrderNotesScreen(),
            OrderProductsScreen.routeName: (ctx) => const OrderProductsScreen(),
            FactorScreen.routeName: (ctx) => const FactorScreen(),
          },
          home: auth.isAuth
              ? auth.findUser().name.isNotEmpty
                  ? const DashboardScreen()
                  : const InformationScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: ((c, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? const LoadingScreen()
                          : const MyHomePage()),
                  // const MyHomePage()),
                ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  static const routeName = "/home";

  static var numberFormat = NumberFormat('###,###', 'fa');

  static Future<dynamic> setNewOrderDialog(context, newOrder) {
    return showDialog(
      context: context,
      builder: (c) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: const Text(
              "سفارش جدید",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            content: Text(
                "آیا مایل به دریافت سفارش \"${newOrder['title']}\" هستید؟"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(c).pop();
                  showDialog(
                    context: context,
                    builder: (c) {
                      return Directionality(
                        textDirection: TextDirection.rtl,
                        child: AlertDialog(
                          // title: const Text(
                          //   "سفارش جدید",
                          //   style: TextStyle(
                          //     color: Colors.blue,
                          //   ),
                          // ),
                          content: Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "لطفا دلیل لغو کردن سفارش را بنویسید.",
                                  style: TextStyle(
                                    color: Color(0xff253567),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextFormField(
                                  // controller: _controller,
                                  decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(),
                                  ),
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  // onChanged: (value) {
                                  //   setState(() {
                                  //     reasonText = value.toString();
                                  //   });
                                  // },
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(c).pop();
                              },
                              child: const Text(
                                "ثبت",
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
                },
                child: const Text(
                  "خیر",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
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
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: AuthScreen(),
      ),
    );
  }
}
