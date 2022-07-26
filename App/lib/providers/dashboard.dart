import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'dart:async';

class Dashboard with ChangeNotifier {
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
      await findSingleOrderNotes(orderId);
      await findSingleOrderProducts(orderId);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  List _orderNotes = [];

  List get orderNotes {
    return [..._orderNotes];
  }

  Future<void> findSingleOrderNotes(orderId) async {
    final url = Uri.parse(
        "http://10.0.2.2:8000/api/app/serviceman/orders/notes/$orderId");
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
      _orderNotes = extractedData;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> submitNewOrderNote(orderId, noteText) async {
    final url = Uri.parse(
        "http://10.0.2.2:8000/api/app/serviceman/orders/notes/$orderId");
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
          "note": noteText,
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

  Future<void> deleteOrderNote(noteId) async {
    final url = Uri.parse(
        "http://10.0.2.2:8000/api/app/serviceman/orders/notes/$noteId");
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('userData')) {
        return;
      }
      final extractedUserData =
          json.decode(prefs.getString('userData').toString());
      final response = await http.delete(
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

  List _products = [];

  List get products {
    return [..._products];
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse("http://10.0.2.2:8000/api/helpers/shop/products");
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
      _products = extractedData;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  List _productCategories = [];

  List get productCategories {
    return [..._productCategories];
  }

  Future<void> fetchAndSetProductCategories() async {
    final url =
        Uri.parse("http://10.0.2.2:8000/api/helpers/shop/products/categories");
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
      _productCategories = extractedData;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  List _orderProducts = [];

  List get orderProducts {
    return [..._orderProducts];
  }

  Future<void> findSingleOrderProducts(orderId) async {
    final url = Uri.parse(
        "http://10.0.2.2:8000/api/app/serviceman/orders/products/$orderId");
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
      _orderProducts = extractedData;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> submitNewOrderProduct(orderId, productId, paid, quantity) async {
    final url = Uri.parse(
        "http://10.0.2.2:8000/api/app/serviceman/orders/products/$orderId");
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
          'product_id': productId,
          'paid': paid,
          'quantity': quantity,
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

  Future<void> deleteOrderProduct(productId) async {
    final url = Uri.parse(
        "http://10.0.2.2:8000/api/app/serviceman/orders/products/$productId");
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('userData')) {
        return;
      }
      final extractedUserData =
          json.decode(prefs.getString('userData').toString());
      final response = await http.delete(
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

  Map _activeOrder = {};

  Map get activeOrder {
    return {..._activeOrder};
  }

  Future<void> fetchAndSetDashboardActiveOrder() async {
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
      if (extractedData.isEmpty) {
        _activeOrder = {};
      } else {
        _activeOrder = extractedData.first;
      }
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  List _orders = [];

  List get orders {
    return [..._orders];
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
}
