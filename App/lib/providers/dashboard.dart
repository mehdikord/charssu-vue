import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'dart:async';

class Dashboard with ChangeNotifier {
  List _orders = [];

  List get orders {
    return [..._orders];
  }

  var _order;
  Map get course {
    return {..._order};
  }

  Future<void> findSingleOrder(orderId) async {
    final url =
        Uri.parse("http://10.0.2.2:8000/api/serviceman/orders/show/$orderId");
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
        },
      );
      final extractedData = json.decode(response.body);
      if (extractedData == null) {
        return;
      }
      _order = extractedData;
      notifyListeners();
    } catch (error) {}
  }

  Future<void> fetchAndSetDashboardActiveOrders() async {
    final url = Uri.parse("http://10.0.2.2:8000/api/serviceman/orders/active");
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
        },
      );
      final extractedData = json.decode(response.body);
      if (extractedData['response'] == null) {
        return;
      }
      _orders = extractedData['response'];
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchAndSetDashboardDoneOrders() async {
    final url = Uri.parse("http://10.0.2.2:8000/api/serviceman/orders/done");
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
        },
      );
      final extractedData = json.decode(response.body);
      if (extractedData['response'] == null) {
        return;
      }
      _orders = extractedData['response'];
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> changeOnline() async {
    final url = Uri.parse("http://10.0.2.2:8000/api/serviceman/activation");
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
        },
      );
      final extractedData = json.decode(response.body);
      if (extractedData['response'] == null) {
        return;
      }
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
