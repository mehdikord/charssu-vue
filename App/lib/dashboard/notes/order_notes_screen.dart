import 'package:charssu/providers/dashboard.dart';
import 'package:charssu/widget/bg_widget.dart';
import 'package:charssu/widget/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderNotesScreen extends StatefulWidget {
  const OrderNotesScreen({Key? key}) : super(key: key);

  static const routeName = "/orders/show/notes";

  @override
  State<OrderNotesScreen> createState() => _OrderNotesScreenState();
}

class _OrderNotesScreenState extends State<OrderNotesScreen> {
  @override
  Widget build(BuildContext context) {
    Image backMobileImage;
    var _isLoading = false;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                      right: 15.0,
                    ),
                    color: const Color(0xfff5f5f5),
                    child: Consumer<Dashboard>(
                      builder: (context, dashboard, _) {
                        if (dashboard.notes.isNotEmpty) {
                          return SingleChildScrollView(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: dashboard.notes.length,
                              itemBuilder: (context, i) => Card(
                                elevation: 8,
                                color: Colors.lightGreen,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "مشتری: ${dashboard.order['customer']['name']}",
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      const Divider(
                                        color: Colors.black,
                                      ),
                                      Text(
                                        "گزارش:\n${dashboard.notes[i]['note']}",
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: AlertDialog(
                                                  title: const Text(
                                                    "بله",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  content: const Text(
                                                    "آیا مطمئن هستید؟",
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text(
                                                        "خیر",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        dashboard
                                                            .deleteOrderNote(
                                                                dashboard.notes[
                                                                    i]['id']);
                                                        dashboard
                                                            .findSingleOrderNotes(
                                                                dashboard.order[
                                                                    'id']);
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: _isLoading
                                                          ? const CircularProgressIndicator()
                                                          : const Text(
                                                              "تایید",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green),
                                                            ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                            setState(() {
                                              _isLoading = false;
                                            });
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                              Colors.red,
                                            ),
                                          ),
                                          child: _isLoading
                                              ? const CircularProgressIndicator()
                                              : const Text("حذف"),
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
            ],
          ),
        ),
      ),
    );
  }
}
