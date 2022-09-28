import 'package:charssu/dashboard/dashboard_screen.dart';
import 'package:charssu/providers/auth.dart';
import 'package:charssu/widget/bg_widget.dart';
import 'package:charssu/widget/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({Key? key}) : super(key: key);

  static const routeName = "/order/new";

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: const MainDrawer(),
        body: SizedBox(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                const BGWidget(),
                Consumer<Auth>(
                  builder: (context, auth, _) => Column(
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
                                    Text(
                                      "کد سفارش: ${auth.newOrder['code']}",
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
                      SizedBox(
                        height: MediaQuery.of(context).viewPadding.top,
                      ),
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.95 -
                            MediaQuery.of(context).viewPadding.top * 2,
                        color: const Color(0xfff5f5f5),
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "آیا مایل به دریافت سفارش زیر هستید؟",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              itemRow("عنوان", auth.newOrder['title']),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              itemRow(
                                  "مشتری", auth.newOrder['customer']['name']),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              itemRow("منطقه", auth.newOrder['zone']['name']),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              itemRow(
                                  "دستگاه", auth.newOrder['device']['name']),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              itemRow(
                                "گارانتی",
                                auth.newOrder['warranty'] == "1"
                                    ? "دارد"
                                    : "ندارد",
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              itemRow(
                                  "مشکل", auth.newOrder['problem']['problem']),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    "توضیحات:",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff62bbd8),
                                    ),
                                  ),
                                  Text(
                                    "${auth.newOrder['description']}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // No Button
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (c) {
                                            return Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: AlertDialog(
                                                content: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.3,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 15.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "لطفا دلیل لغو کردن سفارش را بنویسید.",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff253567),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextFormField(
                                                        controller: _controller,
                                                        decoration:
                                                            const InputDecoration(
                                                          enabledBorder:
                                                              OutlineInputBorder(),
                                                          focusedBorder:
                                                              OutlineInputBorder(),
                                                        ),
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        keyboardType:
                                                            TextInputType
                                                                .multiline,
                                                        maxLines: 5,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      if (_controller.value.text
                                                          .isNotEmpty) {
                                                        Navigator.of(context)
                                                            .pop();
                                                        Navigator.of(context)
                                                            .pushReplacementNamed(
                                                                DashboardScreen
                                                                    .routeName);
                                                        auth.setNewOrderCancel(
                                                            auth.orderServiceman[
                                                                'id'],
                                                            _controller
                                                                .value.text);
                                                      } else {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              const Directionality(
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            child: AlertDialog(
                                                              title: Text(
                                                                "خطا",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 18,
                                                                ),
                                                              ),
                                                              content: Text(
                                                                "لطفا دلیل لغو سفارش را وارد کنید.",
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
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
                                        "خیر",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Yes Button
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                DashboardScreen.routeName);
                                        auth.setNewOrderAccept(
                                            auth.orderServiceman['id']);
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
                                      child: const Text(
                                        "بله",
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  itemRow(txt1, txt2) {
    return Row(
      children: [
        Text(
          "$txt1: ",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff62bbd8),
          ),
        ),
        Text(
          txt2,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
