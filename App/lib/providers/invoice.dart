import 'package:charssu/providers/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'dart:async';

class Invoice with ChangeNotifier {
  Future<void> makeOrderInvoice(orderId) async {
    final url = Uri.parse(
        "http://10.0.2.2:8000/api/app/serviceman/orders/make-invoice/$orderId");
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('userData')) {
        return;
      }
      final extractedUserData =
          json.decode(prefs.getString('userData').toString());
      final response = await http.get(
        url,
        headers: {
          "authorization": extractedUserData['token'],
          'Content-type': 'application/json',
        },
      );
      final extractedData = json.decode(response.body);
      if (extractedData == null) {
        return;
      }
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  List _items = [];

  List get items {
    return [..._items];
  }

  Future<void> fetchAndSetOrderInvoice(orderId) async {
    final url = Uri.parse(
        "http://10.0.2.2:8000/api/app/serviceman/orders/get-invoice/$orderId");
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('userData')) {
        return;
      }
      final extractedUserData =
          json.decode(prefs.getString('userData').toString());
      final response = await http.get(
        url,
        headers: {
          "authorization": extractedUserData['token'],
          'Content-type': 'application/json',
        },
      );
      final extractedData = json.decode(response.body);
      if (extractedData == null) {
        return;
      }
      _items = extractedData;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> deleteOrderInvoice(orderId) async {
    final url = Uri.parse(
        "http://10.0.2.2:8000/api/app/serviceman/orders/delete-invoice/$orderId");
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('userData')) {
        return;
      }
      final extractedUserData =
          json.decode(prefs.getString('userData').toString());
      final response = await http.get(
        url,
        headers: {
          "authorization": extractedUserData['token'],
          'Content-type': 'application/json',
        },
      );
      final extractedData = json.decode(response.body);
      if (extractedData == null) {
        return;
      }
      notifyListeners();
      return extractedData;
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> setDoneOrderInvoice(orderId) async {
    final url = Uri.parse(
        "http://10.0.2.2:8000/api/app/serviceman/orders/set/done/$orderId");
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('userData')) {
        return;
      }
      final extractedUserData =
          json.decode(prefs.getString('userData').toString());
      final response = await http.get(
        url,
        headers: {
          "authorization": extractedUserData['token'],
          'Content-type': 'application/json',
        },
      );
      final extractedData = json.decode(response.body);
      if (extractedData == null) {
        return;
      }
      notifyListeners();
      return extractedData;
    } catch (error) {
      rethrow;
    }
  }
}
