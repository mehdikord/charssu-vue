import 'dart:async';

import 'package:charssu/dashboard/new_order_screen.dart';
import 'package:charssu/providers/auth.dart';
import 'package:charssu/providers/dashboard.dart';
import 'package:charssu/widget/bg_widget.dart';
import 'package:charssu/widget/bottom_navbar.dart';
import 'package:charssu/widget/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';

class OrderProductsScreen extends StatefulWidget {
  const OrderProductsScreen({Key? key}) : super(key: key);

  static const routeName = "/products";

  @override
  State<OrderProductsScreen> createState() => _OrderProductsScreenState();
}

class _OrderProductsScreenState extends State<OrderProductsScreen> {
  final _paidController = TextEditingController();
  final _productController = TextEditingController();
  final _quantityController = TextEditingController();
  var _productId;

  var _isLoadingSubmit = false;
  var _isLoadingDelete = false;

  late var _allProducts;

  List _getProducts() {
    return Provider.of<Dashboard>(context, listen: false).products;
  }

  @override
  void dispose() {
    _paidController.dispose();
    _productController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  // This holds a list of fiction users
  // You can use data fetched from a database or a server as well
  // final List<Map<String, dynamic>> _allUsers = [
  //   {"id": 1, "name": "Andy", "age": 29},
  //   {"id": 2, "name": "Aragon", "age": 40},
  //   {"id": 3, "name": "Bob", "age": 5},
  //   {"id": 4, "name": "Barbara", "age": 35},
  //   {"id": 5, "name": "Candy", "age": 21},
  //   {"id": 6, "name": "Colin", "age": 55},
  //   {"id": 7, "name": "Audra", "age": 30},
  //   {"id": 8, "name": "Banana", "age": 14},
  //   {"id": 9, "name": "Caversky", "age": 100},
  //   {"id": 10, "name": "Becky", "age": 32},
  // ];

  // This list holds the data for the list view
  List _foundProducts = [];
  @override
  initState() {
    // at the beginning, all users are shown
    _allProducts = _getProducts();
    _foundProducts = _allProducts;
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
  Widget build(BuildContext context) {
    Image backMobileImage;
    final orderId = ModalRoute.of(context)!.settings.arguments;
    final order = Provider.of<Dashboard>(context, listen: false).order;

    // This function is called whenever the text field changes
    void _runSearch(String enteredKeyword) {
      List results = [];
      if (enteredKeyword.isEmpty) {
        // if the search field is empty or only contains white-space, we'll display all users
        results = _allProducts;
      } else {
        results = _allProducts
            .where((product) => product["name"]
                .toString()
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()))
            .toList();
        // we use the toLowerCase() method to make it case-insensitive
      }

      // Refresh the UI
      setState(() {
        _foundProducts = results;
      });
    }

    void _runFilterCategory(String selectedCategory) {
      List resultCategories = [];
      if (selectedCategory.isEmpty) {
        resultCategories = _allProducts;
      } else {
        resultCategories = _allProducts
            .where((product) => product["category"]["id"]
                .toString()
                .contains(selectedCategory.toString()))
            .toList();
      }
      setState(() {
        _foundProducts = resultCategories;
      });
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: const MainDrawer(),
        floatingActionButton: order['is_done'] == 1 || order['invoice'] == 1
            ? null
            : Container(
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
                        return StatefulBuilder(
                          builder: (context, setState) => Directionality(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                            child: StatefulBuilder(
                                              builder: (context, setState) =>
                                                  AlertDialog(
                                                title: const Text(
                                                  "لیست محصولات",
                                                  style: TextStyle(
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                content: SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        TextField(
                                                          onChanged: (value) =>
                                                              setState(() =>
                                                                  _runSearch(
                                                                      value)),
                                                          decoration:
                                                              const InputDecoration(
                                                                  labelText:
                                                                      'جستجو',
                                                                  suffixIcon:
                                                                      Icon(Icons
                                                                          .search)),
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        SelectFormField(
                                                          decoration:
                                                              const InputDecoration(
                                                            enabledBorder:
                                                                OutlineInputBorder(),
                                                            focusedBorder:
                                                                OutlineInputBorder(),
                                                            labelText:
                                                                "دسته بندی",
                                                          ),
                                                          onChanged: (value) =>
                                                              setState(
                                                            () =>
                                                                _runFilterCategory(
                                                                    value),
                                                          ),
                                                          items: Provider.of<
                                                                      Dashboard>(
                                                                  context,
                                                                  listen: false)
                                                              .productCategories
                                                              .map(
                                                                  (category) =>
                                                                      {
                                                                        "value":
                                                                            category['id'],
                                                                        "label":
                                                                            category['name'],
                                                                      })
                                                              .toList(),
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        _foundProducts
                                                                .isNotEmpty
                                                            ? ListView.builder(
                                                                shrinkWrap:
                                                                    true,
                                                                physics:
                                                                    const NeverScrollableScrollPhysics(),
                                                                itemCount:
                                                                    _foundProducts
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                            i) =>
                                                                        InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      _productController
                                                                          .text = _foundProducts[
                                                                              i]
                                                                          [
                                                                          'name'];
                                                                      _productId =
                                                                          _foundProducts[i]
                                                                              [
                                                                              'id'];
                                                                    });
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Card(
                                                                    key: ValueKey(
                                                                        _foundProducts[i]
                                                                            [
                                                                            "id"]),
                                                                    color: Colors
                                                                        .lightGreen,
                                                                    elevation:
                                                                        18,
                                                                    margin: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            10.0),
                                                                    child:
                                                                        ListTile(
                                                                      // leading: Text(
                                                                      //   _foundProducts[
                                                                      //           i]["id"]
                                                                      //       .toString(),
                                                                      //   style:
                                                                      //       const TextStyle(
                                                                      //           fontSize:
                                                                      //               24),
                                                                      // ),
                                                                      title: Text(
                                                                          _foundProducts[i]
                                                                              [
                                                                              'name']),
                                                                      subtitle:
                                                                          Text(
                                                                        _foundProducts[i]["category"]["name"]
                                                                            .toString(),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            : const Text(
                                                                'محصولی یافت نشد!',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        24),
                                                              ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
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
                                  TextFormField(
                                    controller: _quantityController,
                                    decoration: const InputDecoration(
                                      enabledBorder: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(),
                                      labelText: "تعداد",
                                    ),
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.number,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (_paidController
                                                .value.text.isNotEmpty &&
                                            _quantityController
                                                .value.text.isNotEmpty) {
                                          setState(() {
                                            _isLoadingSubmit = true;
                                          });
                                          await Provider.of<Dashboard>(
                                            context,
                                            listen: false,
                                          )
                                              .submitNewOrderProduct(
                                                orderId,
                                                _productId,
                                                _paidController.value.text,
                                                _quantityController.value.text,
                                              )
                                              .then((value) =>
                                                  Provider.of<Dashboard>(
                                                    context,
                                                    listen: false,
                                                  )
                                                      .findSingleOrderProducts(
                                                          orderId)
                                                      .then((value) {
                                                    setState(() {
                                                      _productController.value =
                                                          TextEditingValue
                                                              .empty;
                                                      _paidController.value =
                                                          TextEditingValue
                                                              .empty;
                                                      _quantityController
                                                              .value =
                                                          TextEditingValue
                                                              .empty;
                                                    });
                                                  }));
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
                                                  "لطفا اطلاعات را با دقت وارد کنید.",
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
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            )
                                          : const Text("ثبت"),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom,
                                    ),
                                  ),
                                ],
                              ),
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
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                            "خیر",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () async {
                                                            setState(() {
                                                              _isLoadingDelete =
                                                                  true;
                                                            });
                                                            await dashboard
                                                                .deleteOrderProduct(
                                                                    dashboard.orderProducts[
                                                                            i]
                                                                        ['id'])
                                                                .then((value) =>
                                                                    dashboard.findSingleOrderProducts(
                                                                        dashboard
                                                                            .order['id']));
                                                            setState(() {
                                                              _isLoadingDelete =
                                                                  false;
                                                            });
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: _isLoadingDelete
                                                              ? const SizedBox(
                                                                  width: 22.0,
                                                                  height: 22.0,
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
