import 'dart:async';

import 'package:charssu/dashboard/new_order_screen.dart';
import 'package:charssu/providers/auth.dart';
import 'package:charssu/providers/dashboard.dart';
import 'package:charssu/widget/bg_widget.dart';
import 'package:charssu/widget/bottom_navbar.dart';
import 'package:charssu/widget/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderNotesScreen extends StatefulWidget {
  const OrderNotesScreen({Key? key}) : super(key: key);

  static const routeName = "/orders/show/notes";

  @override
  State<OrderNotesScreen> createState() => _OrderNotesScreenState();
}

class _OrderNotesScreenState extends State<OrderNotesScreen> {
  final _controller = TextEditingController();
  var _isLoadingSubmit = false;
  var _isLoadingDelete = false;

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
    final orderId = ModalRoute.of(context)!.settings.arguments;
    final order = Provider.of<Dashboard>(context, listen: false).order;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: const MainDrawer(),
        floatingActionButton: order['is_done'] == 1 || order['invoice'] == 1
            ? null
            : Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.1,
                ),
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.green,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (c) {
                        return Directionality(
                          textDirection: TextDirection.rtl,
                          child: StatefulBuilder(
                            builder: (context, setState) => AlertDialog(
                              title: const Text(
                                "ثبت گزارش",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "متن گزارش",
                                      style: TextStyle(
                                        color: Color(0xff253567),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextFormField(
                                      controller: _controller,
                                      decoration: const InputDecoration(
                                        enabledBorder: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(),
                                      ),
                                      textInputAction: TextInputAction.done,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 5,
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    if (_controller.value.text.isNotEmpty) {
                                      setState(() {
                                        _isLoadingSubmit = true;
                                      });
                                      await Provider.of<Dashboard>(
                                        context,
                                        listen: false,
                                      )
                                          .submitNewOrderNote(
                                        orderId,
                                        _controller.value.text,
                                      )
                                          .then((value) {
                                        setState(() {
                                          _controller.value =
                                              TextEditingValue.empty;
                                        });
                                      });
                                      Provider.of<Dashboard>(
                                        context,
                                        listen: false,
                                      ).findSingleOrderNotes(orderId);
                                      setState(() {
                                        _isLoadingSubmit = false;
                                      });
                                      Navigator.of(context).pop();
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            const Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: AlertDialog(
                                            title: Text(
                                              "خطا",
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 18,
                                              ),
                                            ),
                                            content: Text(
                                              "لطفا متن گزارش خود را وارد کنید.",
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: _isLoadingSubmit
                                      ? const SizedBox(
                                          width: 22.0,
                                          height: 22.0,
                                          child: CircularProgressIndicator(),
                                        )
                                      : const Text("ثبت"),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  label: const Text(
                    "ثبت جدید",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        body: SizedBox(
          child: Stack(
            fit: StackFit.expand,
            children: [
              const BGWidget(),
              SingleChildScrollView(
                child: Column(
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
                                      "گزارشات سفارش: ${dashboard.order['code']}",
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
                                  "assets/images/Icon-Service.png",
                                  width:
                                      MediaQuery.of(context).size.width * 0.13,
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
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        left: 15.0,
                        right: 15.0,
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xfff5f5f5),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(30),
                        ),
                      ),
                      child: Consumer<Dashboard>(
                        builder: (context, dashboard, _) {
                          if (dashboard.orderNotes.isNotEmpty) {
                            return SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: dashboard.orderNotes.length,
                                itemBuilder: (context, i) => Card(
                                  elevation: 8,
                                  color: const Color.fromARGB(170, 33, 70, 189),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "گزارش:\n${dashboard.orderNotes[i]['note']}",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                        if (order['is_done'] == 0 &&
                                            order['invoice'] == 0)
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      Directionality(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    child: StatefulBuilder(
                                                      builder:
                                                          (context, setState) =>
                                                              AlertDialog(
                                                        title: const Text(
                                                          "هشدار",
                                                          style: TextStyle(
                                                            color:
                                                                Colors.orange,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                        content: const Text(
                                                          "آیا مطمئن هستید؟",
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                              "خیر",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed:
                                                                () async {
                                                              setState(() {
                                                                _isLoadingDelete =
                                                                    true;
                                                              });
                                                              await dashboard
                                                                  .deleteOrderNote(
                                                                      dashboard.orderNotes[
                                                                              i]
                                                                          [
                                                                          'id'])
                                                                  .then((value) =>
                                                                      dashboard.findSingleOrderNotes(
                                                                          dashboard.order[
                                                                              'id']))
                                                                  .then((value) =>
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop());
                                                              setState(() {
                                                                _isLoadingDelete =
                                                                    false;
                                                              });
                                                            },
                                                            child: _isLoadingDelete
                                                                ? const SizedBox(
                                                                    width: 22.0,
                                                                    height:
                                                                        22.0,
                                                                    child:
                                                                        CircularProgressIndicator(),
                                                                  )
                                                                : const Text(
                                                                    "بله",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .green),
                                                                  ),
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
                                                  Colors.red,
                                                ),
                                              ),
                                              child: const Text("حذف"),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return const Center(
                              child: Text(
                                "گزارشی ثبت نشده است!",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }
                        },
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
