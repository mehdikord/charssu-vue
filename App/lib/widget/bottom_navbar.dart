import 'package:charssu/dashboard/active_orders_screen.dart';
import 'package:charssu/dashboard/dashboard_screen.dart';
import 'package:charssu/dashboard/done_orders_screen.dart';
import 'package:charssu/information/information_screen.dart';
import 'package:charssu/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar(this.count, {Key? key}) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, auth, _) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              if (auth.findUser().isAccepted) {
                for (var i = 0; i < count; i++) {
                  Navigator.of(context).pop();
                }
                Navigator.of(context)
                    .pushNamed(InformationScreen.routeName);
              }
            },
            child: Column(
              children: [
                Image.asset("assets/images/Icon-Profile.png", width: 40),
                const Text(
                  "پروفایل",
                  style: TextStyle(
                    color: Color(0xfff5f5f5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              if (auth.findUser().isAccepted) {
                for (var i = 0; i < count; i++) {
                  Navigator.of(context).pop();
                }
                Navigator.of(context)
                    .pushReplacementNamed(ActiveOrdersScreen.routeName);
              }
            },
            child: Column(
              children: [
                Image.asset("assets/images/Icon-Faale.png", width: 40),
                const Text(
                  "فعال",
                  style: TextStyle(
                    color: Color(0xfff5f5f5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              if (auth.findUser().isAccepted) {
                for (var i = 0; i < count; i++) {
                  Navigator.of(context).pop();
                }
                Navigator.of(context)
                    .pushReplacementNamed(DoneOrdersScreen.routeName);
              }
            },
            child: Column(
              children: [
                Image.asset("assets/images/Icon-Anjam.png", width: 40),
                const Text(
                  "انجام شده",
                  style: TextStyle(
                    color: Color(0xfff5f5f5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              if (auth.findUser().isAccepted) {
                for (var i = 0; i < count; i++) {
                  Navigator.of(context).pop();
                }
                Navigator.of(context)
                    .pushReplacementNamed(DashboardScreen.routeName);
              }
            },
            child: Column(
              children: [
                Image.asset("assets/images/Icon-Home.png", width: 40),
                const Text(
                  "خانه",
                  style: TextStyle(
                    color: Color(0xfff5f5f5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
