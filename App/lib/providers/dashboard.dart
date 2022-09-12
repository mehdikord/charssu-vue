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

  Map _order = {};

  Map get order {
    return {..._order};
  }

  Future<void> findSingleOrder(orderId) async {
    final url = Uri.parse(
        "http://10.0.2.2:8000/api/app/serviceman/orders/single/$orderId");
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
      _order = extractedData;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchAndSetDashboardActiveOrders() async {
    final url =
        Uri.parse("http://10.0.2.2:8000/api/app/serviceman/orders/active");
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
      _orders = extractedData;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchAndSetDashboardDoneOrders() async {
    final url =
        Uri.parse("http://10.0.2.2:8000/api/app/serviceman/orders/done");
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
      _orders = extractedData;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> changeOnline() async {
    final url = Uri.parse("http://10.0.2.2:8000/api/app/serviceman/activation");
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
      if (extractedData['response'] == null) {
        return;
      }
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> setNewOrder() async {
    final url = Uri.parse("http://10.0.2.2:8000/api/app/serviceman/orders/new");
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

  Future<void> setNewOrderAccept(orderServicemanId) async {
    final url =
        Uri.parse("http://10.0.2.2:8000/api/app/serviceman/orders/accept");
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('userData')) {
        return;
      }
      final extractedUserData =
          json.decode(prefs.getString('userData').toString());
      final response = await http.post(
        url,
        headers: {
          "authorization": extractedUserData['token'],
          'Content-type': 'application/json',
        },
        body: json.encode({
          'order_serviceman_id': orderServicemanId,
        }),
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
}
