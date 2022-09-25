import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'dart:async';

import '../models/http_exception.dart';

class UserInformation with ChangeNotifier {
  final String id,
      code,
      name,
      family,
      nationalCode,
      birthday,
      province,
      city,
      telephone,
      email,
      startTime,
      endTime,
      address,
      workAddress;
  final List zone, brand;
  final bool isAccepted, isOnline;

  UserInformation({
    this.id = "",
    this.code = "",
    this.name = "",
    this.family = "",
    this.nationalCode = "",
    this.birthday = "",
    this.province = "",
    this.city = "",
    this.zone = const [],
    this.brand = const [],
    this.telephone = "",
    this.email = "",
    this.startTime = "",
    this.endTime = "",
    this.address = "",
    this.workAddress = "",
    this.isAccepted = false,
    this.isOnline = true,
  });
}

class Auth with ChangeNotifier {
  var _token, _userId, _expiryDate, _authTimer, _name, _phone, _newOrder;
  UserInformation _user = UserInformation();

  List<dynamic> _brands = [];

  List<Map<String, dynamic>> get brands {
    return [..._brands];
  }

  Future<void> fetchAndSetDashboardBrands() async {
    final url = Uri.parse("http://10.0.2.2:8000/api/helpers/get/brands");

    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      if (responseData.toString().contains('error')) {
        throw HttpException(responseData['error'].toString());
      }
      _brands = responseData;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  List<dynamic> _provinces = [];

  List<Map<String, dynamic>> get provinces {
    return [..._provinces];
  }

  List<dynamic> _cities = [];

  List<Map<String, dynamic>> get cities {
    return [..._cities];
  }

  List<dynamic> _zones = [];

  List<Map<String, dynamic>> get zones {
    return [..._zones];
  }

  Future<void> fetchAndSetDashboardProvinces() async {
    final url = Uri.parse("http://10.0.2.2:8000/api/helpers/get/provinces");

    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      if (responseData.toString().contains('error')) {
        throw HttpException(responseData['error'].toString());
      }
      _provinces = responseData;
      setCities(findUser().province.isNotEmpty ? findUser().province : "8");
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> setCities(String provinceId) async {
    _cities = await provinces.firstWhere(
        (province) => province['id'] == int.parse(provinceId))['cities'];
    setZones(findUser().city.isNotEmpty ? findUser().city : "100");
    notifyListeners();
  }

  Future<void> setZones(String cityId) async {
    _zones = await cities
        .firstWhere((city) => city['id'] == int.parse(cityId))['zones'];
    notifyListeners();
  }

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_token != null && _expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  String? get username {
    if (_name != null) {
      return _name;
    }
    return null;
  }

  String? get phone {
    if (_phone != null) {
      return _phone;
    }
    return null;
  }

  Future<void> login(String phone) async {
    final url = Uri.parse("http://10.0.2.2:8000/api/app/serviceman/auth");
    final body = {"phone": phone};

    try {
      final response = await http.post(url, body: body);
      final responseData = json.decode(response.body);
      if (responseData.toString().contains('error')) {
        throw HttpException(responseData['error'].toString());
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> loginCheck(String phone, String code) async {
    final url = Uri.parse("http://10.0.2.2:8000/api/app/serviceman/auth/check");
    final body = {
      "phone": phone,
      "code": code,
    };

    try {
      final response = await http.post(url, body: body);
      final responseData = json.decode(response.body);
      if (responseData.toString().contains('error')) {
        throw HttpException(responseData['error']);
      }
      _token = responseData['response']['api_token'];
      _userId = responseData['response']['id'].toString();
      _name = responseData['response']['name'].toString();
      _phone = responseData['response']['phone'].toString();
      _expiryDate = DateTime.now().add(
        const Duration(hours: 12),
      );
      await fetchAndSetOrderServiceman();
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'name': _name,
        'phone': _phone,
        'expiryDate': _expiryDate.toIso8601String(),
      });
      prefs.setString('userData', userData);
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }

    final extractedUserData = json
        .decode(prefs.getString('userData').toString()) as Map<String, dynamic>;
    final expiryDate =
        DateTime.parse(extractedUserData['expiryDate'].toString());
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _name = extractedUserData['name'];
    _phone = extractedUserData['phone'];
    _expiryDate = expiryDate;
    await setUser();
    notifyListeners();
    _autoLogout();
    return true;
  }

  void logout() async {
    _token = null;
    _userId = null;
    _name = null;
    _phone = null;
    _orderServiceman = null;
    _newOrder = null;
    _expiryDate = DateTime.now();
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  UserInformation findUser() {
    return _user;
  }

  Future<void> setUser() async {
    final url = Uri.parse("http://10.0.2.2:8000/api/app/serviceman/profile");
    try {
      final response = await http.get(
        url,
        headers: {
          "authorization": token.toString(),
        },
      );
      final user = json.decode(response.body);
      dynamic fullname, firstName, lastName;
      if (user['response']['name'] != null) {
        fullname = user['response']['name'].split(' ');
        firstName = fullname[0];
        if (fullname.length > 1) {
          lastName = fullname[1];
        }
      }
      UserInformation data = UserInformation(
        id: user['response']['id'].toString(),
        code: user['response']['code'] != null
            ? user['response']['code'].toString()
            : "---",
        name: firstName,
        family: lastName,
        nationalCode: user['response']['national_code'].toString(),
        birthday: user['response']['birthday'].toString(),
        province: user['response']['province_id'].toString(),
        city: user['response']['city_id'].toString(),
        zone: [],
        brand: [],
        telephone: user['response']['tel'] != null
            ? user['response']['tel'].toString()
            : "",
        email: user['response']['email'],
        startTime: user['response']['start_time'],
        endTime: user['response']['end_time'],
        address: user['response']['address'],
        workAddress: user['response']['work_address'],
        isAccepted: user['response']['is_accepted'] == 1 ? true : false,
        isOnline: user['response']['is_online'] == 1 ? true : false,
      );
      _user = data;
      await fetchAndSetOrderServiceman();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateUser(String id, UserInformation newInfo) async {
    final url = Uri.parse("http://10.0.2.2:8000/api/app/serviceman/profile");
    print("====================================================");
    print("id: ${newInfo.id}");
    print("province: ${newInfo.province}");
    print("city: ${newInfo.city}");
    print("name: ${newInfo.name}");
    print("family: ${newInfo.family}");
    print("nationalCode: ${newInfo.nationalCode}");
    print("email: ${newInfo.email}");
    print("birthday: ${newInfo.birthday}");
    print("address: ${newInfo.address}");
    print("workAddress: ${newInfo.workAddress}");
    print("telephone: ${newInfo.telephone}");
    print("startTime: ${newInfo.startTime}");
    print("endTime: ${newInfo.endTime}");
    print("zone: ${newInfo.zone}");
    print("brand: ${newInfo.brand}");
    print("isAccepted: ${newInfo.isAccepted}");
    print("isOnline: ${newInfo.isOnline}");
    print("====================================================");
    final response = await http.post(
      url,
      body: json.encode({
        "province_id": newInfo.province,
        "city_id": newInfo.city,
        "name": "${newInfo.name} ${newInfo.family}",
        "national_code": newInfo.nationalCode,
        "email": newInfo.email,
        'birthday': newInfo.birthday,
        "address": newInfo.address,
        "work_address": newInfo.workAddress,
        "tel": newInfo.telephone,
        'start_time': newInfo.startTime,
        'end_time': newInfo.endTime,
        "brands": newInfo.brand,
        "zones": newInfo.zone,
      }),
      headers: {
        "authorization": token.toString(),
        'Content-type': 'application/json',
      },
    );
    final responseData = json.decode(response.body);
    if (responseData['errors'] != null) {
      throw responseData['errors'];
    }
    final prefs = await SharedPreferences.getInstance();
    _phone = _phone;
    prefs.remove('userData');
    _token = token;
    _userId = newInfo.id;
    _name = newInfo.name;
    _expiryDate = DateTime.now().add(
      const Duration(hours: 12),
    );
    final userData = json.encode({
      'token': token,
      'userId': newInfo.id,
      'name': newInfo.name,
      'phone': _phone,
      'expiryDate': _expiryDate.toIso8601String(),
    });
    prefs.setString('userData', userData);
    notifyListeners();
  }

  get newOrder {
    if (_newOrder != null) {
      return _newOrder;
    }
    return null;
  }

  var _orderServiceman;

  get orderServiceman {
    return _orderServiceman;
  }

  bool get hasNewOrder {
    return _newOrder != null;
  }

  Future<void> fetchAndSetOrderServiceman() async {
    final urlOrderServiceman =
        Uri.parse("http://10.0.2.2:8000/api/app/serviceman/orders/new");
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('userData')) {
        return;
      }
      final extractedUserData =
          json.decode(prefs.getString('userData').toString());
      final responseOrderServiceman = await http.get(
        urlOrderServiceman,
        headers: {
          "authorization": extractedUserData['token'],
          'Content-type': 'application/json',
        },
      );
      final extractedDataOrderServiceman =
          json.decode(responseOrderServiceman.body);
      if (extractedDataOrderServiceman == null) {
        return;
      }
      _orderServiceman = extractedDataOrderServiceman;
      if (_orderServiceman.isNotEmpty) {
        final urlSingleOrder = Uri.parse(
            "http://10.0.2.2:8000/api/app/serviceman/orders/single/${_orderServiceman['order_id']}");
        final responseSingleOrder = await http.get(
          urlSingleOrder,
          headers: {
            "authorization": extractedUserData['token'],
            'Content-type': 'application/json',
          },
        );
        final extractedDataSingleOrder = json.decode(responseSingleOrder.body);
        if (extractedDataSingleOrder == null) {
          return;
        }
        _newOrder = extractedDataSingleOrder;
      } else {
        _newOrder = null;
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
      await fetchAndSetOrderServiceman();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> setNewOrderCancel(orderServicemanId) async {
    final url =
        Uri.parse("http://10.0.2.2:8000/api/app/serviceman/orders/cancel");
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
      // =======================
      final urlReason = Uri.parse(
          "http://10.0.2.2:8000/api/app/serviceman/orders/cancel-reason");
      final responseReason = await http.post(
        urlReason,
        headers: {
          "authorization": extractedUserData['token'],
          'Content-type': 'application/json',
        },
        body: json.encode({
          'order_serviceman_id': orderServicemanId,
          'cancel_reason': "test cancel reason",
        }),
      );
      final extractedDataReason = json.decode(responseReason.body);
      if (extractedDataReason == null) {
        return;
      }
      // =======================
      await fetchAndSetOrderServiceman();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
