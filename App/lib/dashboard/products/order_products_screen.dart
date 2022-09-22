import 'package:charssu/providers/dashboard.dart';
import 'package:charssu/widget/bg_widget.dart';
import 'package:charssu/widget/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';

class OrderProductsScreen extends StatefulWidget {
  const OrderProductsScreen({Key? key}) : super(key: key);

  static const routeName = "/orders/show/products";

  @override
  State<OrderProductsScreen> createState() => _OrderProductsScreenState();
}

class _OrderProductsScreenState extends State<OrderProductsScreen> {
  var _isLoading = false;
  final _paidController = TextEditingController();
  final _productController = TextEditingController();
  final _quantityController = TextEditingController();
  var _productId;

  @override
  Widget build(BuildContext context) {
    Image backMobileImage;
    final orderId = ModalRoute.of(context)!.settings.arguments;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.1,
          ),
          child: FloatingActionButton.extended(
            backgroundColor: Colors.green,
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (c) {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5 +
                          MediaQuery.of(context).viewInsets.bottom,
                      margin: const EdgeInsets.symmetric(
                        vertical: 40,
                        horizontal: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFormField(
                            controller: _productController,
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                              labelText: "انتخاب قطعه",
                            ),
                            readOnly: true,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (c) {
                                  return Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: AlertDialog(
                                      title: const Text(
                                        "لیست محصولات",
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      content: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Consumer<Dashboard>(
                                          builder: (context, dashboard, _) =>
                                              Column(
                                            children: [
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount:
                                                    dashboard.products.length,
                                                itemBuilder: (context, i) =>
                                                    Card(
                                                  color: Colors.lightGreen,
                                                  elevation: 18,
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        _productController
                                                            .text = dashboard
                                                                .products[i]
                                                            ['name'];
                                                        _productId = dashboard
                                                            .products[i]['id'];
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Text(
                                                        dashboard.products[i]
                                                            ['name'],
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SelectFormField(
                                controller: _paidController,
                                decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(),
                                  labelText: "پرداخت توسط",
                                ),
                                items: const [
                                  {
                                    'value': 'serviceman',
                                    'label': 'سرویس کار',
                                  },
                                  {
                                    'value': 'customer',
                                    'label': 'مشتری',
                                  },
                                  {
                                    'value': 'nobody',
                                    'label': 'هیچکدام',
                                  },
                                ],
                              ),
                            ],
                          ),
                          TextFormField(
                            controller: _quantityController,
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                              labelText: "تعداد",
                            ),
                            textInputAction: TextInputAction.done,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_paidController.value.text.isNotEmpty &&
                                    _quantityController.value.text.isNotEmpty) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  Provider.of<Dashboard>(
                                    context,
                                    listen: false,
                                  )
                                      .submitNewOrderProduct(
                                    orderId,
                                    _productId,
                                    _paidController.value.text,
                                    _quantityController.value.text,
                                  )
                                      .then((value) {
                                    setState(() {
                                      _productController.value =
                                          TextEditingValue.empty;
                                      _paidController.value =
                                          TextEditingValue.empty;
                                      _quantityController.value =
                                          TextEditingValue.empty;
                                    });
                                  });
                                  Provider.of<Dashboard>(
                                    context,
                                    listen: false,
                                  ).findSingleOrderProducts(orderId);
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  Navigator.of(context).pop();
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) => const Directionality(
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
                                          "لطفا اطلاعات را با دقت وارد کنید.",
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: _isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text("ثبت"),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
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
                                    "قطعات سفارش: ${dashboard.order['code']}",
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
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      color: Color(0xfff5f5f5),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(30),
                      ),
                    ),
                    child: Consumer<Dashboard>(
                      builder: (context, dashboard, _) {
                        if (dashboard.orderProducts.isNotEmpty) {
                          return SingleChildScrollView(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: dashboard.orderProducts.length,
                              itemBuilder: (context, i) => Card(
                                elevation: 8,
                                color: Color.fromARGB(170, 33, 70, 189),
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
                                        "نام قطعه: ${dashboard.orderProducts[i]['products']['name']}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "تعداد: ${dashboard.orderProducts[i]['quantity']} عدد",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "پرداخت توسط: ${dashboard.orderProducts[i]['paid'] == "serviceman" ? "سرویس کار" : (dashboard.orderProducts[i]['paid'] == "customer" ? "مشتری" : "هیچکدام")}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
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
                                                child: AlertDialog(
                                                  title: const Text(
                                                    "هشدار",
                                                    style: TextStyle(
                                                      color: Colors.orange,
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
                                                            .deleteOrderProduct(
                                                                dashboard
                                                                        .orderProducts[
                                                                    i]['id']);
                                                        dashboard
                                                            .findSingleOrderProducts(
                                                                dashboard.order[
                                                                    'id']);
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text(
                                                        "تایید",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    ),
                                                  ],
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
                              "قطعه‌ای ثبت نشده است!",
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
