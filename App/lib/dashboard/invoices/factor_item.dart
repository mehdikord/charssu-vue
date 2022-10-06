import 'package:charssu/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class FactorItem extends StatefulWidget {
  const FactorItem(this.invoiceItem, {Key? key}) : super(key: key);

  final invoiceItem;

  @override
  State<FactorItem> createState() => _FactorItemState();
}

class _FactorItemState extends State<FactorItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 8.0),
            decoration: BoxDecoration(
              color:
                  widget.invoiceItem['is_pay'] == 1 ? Colors.green : Colors.red,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
            ),
            child: Text(
              widget.invoiceItem['is_pay'] == 1 ? "پرداخت شد" : "پرداخت نشده",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "کد:‌ ${widget.invoiceItem['id']}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.invoiceItem['type'] == "customer"
                      ? "مشتری"
                      : "سرویس کار",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              "قیمت: ${MyHomePage.numberFormat.format(int.parse(widget.invoiceItem['price']))} تومان",
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            ),
          ),
          // --- Show Items List ---
          if (_expanded)
            Container(
              width: double.infinity,
              height:
                  min(widget.invoiceItem['details'].length * 20.0 + 60, 200),
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ListView.builder(
                itemCount: widget.invoiceItem['details'].length,
                itemBuilder: (ctx, i) => Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.invoiceItem['details'][i]['title'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: double.infinity,
                              padding: const EdgeInsets.only(right: 5),
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: const Color(0xff62bbd8),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  "${MyHomePage.numberFormat.format(int.parse(widget.invoiceItem['details'][i]['price']))} تومان",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
