import 'package:charssu/auth/sms_code_screen.dart';
import 'package:charssu/dashboard/active_orders_screen.dart';
import 'package:charssu/dashboard/dashboard_screen.dart';
import 'package:charssu/dashboard/done_orders_screen.dart';
import 'package:charssu/dashboard/factor_screen.dart';
import 'package:charssu/dashboard/new_order_screen.dart';
import 'package:charssu/dashboard/notes/order_notes_screen.dart';
import 'package:charssu/dashboard/order_single_screen.dart';
import 'package:charssu/dashboard/products/order_products_screen.dart';
import 'package:charssu/information/information_screen.dart';
import 'package:charssu/providers/auth.dart';
import 'package:charssu/providers/dashboard.dart';
import 'package:charssu/providers/invoice.dart';
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
        ChangeNotifierProvider(
          create: (ctx) => Invoice(),
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
            NewOrderScreen.routeName: (ctx) => const NewOrderScreen(),
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
