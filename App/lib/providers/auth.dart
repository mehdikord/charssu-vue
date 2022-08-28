import 'dart:math';
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
      zone,
      brand,
      telephone,
      email,
      startTime,
      endTime,
      address,
      workAddress;
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
    this.zone = "",
    this.brand = "",
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
  var _token, _userId, _expiryDate, _authTimer, _name, _phone;
  UserInformation _user = UserInformation();

  List<dynamic> _brands = [];

  List<Map<String, dynamic>> get brands {
    return [..._brands];
  }

  Future<void> fetchAndSetDashboardBrands() async {
    final url = Uri.parse("http://10.0.2.2:8000/api/helper/get/brands");

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

  List<dynamic> _zones = [];

  List<Map<String, dynamic>> get zones {
    return [..._zones];
  }

  Future<void> fetchAndSetDashboardZones() async {
    final url = Uri.parse("http://10.0.2.2:8000/api/helper/get/zones");

    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      if (responseData.toString().contains('error')) {
        throw HttpException(responseData['error'].toString());
      }
      _zones = responseData;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
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
    final url = Uri.parse("http://10.0.2.2:8000/api/serviceman/auth");
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
    final url = Uri.parse("http://10.0.2.2:8000/api/serviceman/auth/check");
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
      print(responseData);
      _token = responseData['response']['api_token'];
      _userId = responseData['response']['id'].toString();
      _name = responseData['response']['name'].toString();
      _phone = responseData['response']['phone'].toString();
      _expiryDate = DateTime.now().add(
        const Duration(hours: 12),
      );
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
      print("================================");
      print(user['response']);
      print("================================");
      UserInformation data = UserInformation(
        id: user['response']['id'].toString(),
        code: user['response']['code'] != null
            ? user['response']['code'].toString()
            : "---",
        name: firstName ?? "",
        family: lastName ?? "",
        nationalCode: user['response']['national_code'].toString(),
        birthday: "",
        province: "8",
        city: "100",
        zone: "",
        brand: "",
        telephone: user['response']['tel'] != null
            ? user['response']['tel'].toString()
            : "",
        email: user['response']['email'] ?? "",
        startTime: "",
        endTime: "",
        address: user['response']['address'] ?? "",
        workAddress: user['response']['work_address'] ?? "",
        isAccepted: user['response']['is_accepted'] == 1 ? true : false,
        isOnline: user['response']['is_online'] == 1 ? true : false,
      );
      print(user['response'].toString());
      _user = data;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateUser(String id, UserInformation newInfo) async {
    final url = Uri.parse("http://10.0.2.2:8000/api/serviceman/profile");
    int randomNumber = Random().nextInt(100);
    print("====================================================");
    print("id: ${newInfo.id}");
    print("name: ${newInfo.name}");
    print("family: ${newInfo.family}");
    print("nationalCode: ${newInfo.nationalCode}");
    print("birthday: ${newInfo.birthday}");
    print("province: ${newInfo.province}");
    print("city: ${newInfo.city}");
    print("zone: ${newInfo.zone}");
    print("brand: ${newInfo.brand}");
    print("telephone: ${newInfo.telephone}");
    print("email: ${newInfo.email}");
    print("startTime: ${newInfo.startTime}");
    print("endTime: ${newInfo.endTime}");
    print("address: ${newInfo.address}");
    print("workAddress: ${newInfo.workAddress}");
    print("isAccepted: ${newInfo.isAccepted}");
    print("isOnline: ${newInfo.isOnline}");
    print("code: $randomNumber");
    print("====================================================");
    final response = await http.post(
      url,
      body: {
        "province_id": newInfo.province,
        "city_id": newInfo.city,
        "name": "${newInfo.name} ${newInfo.family}",
        "national_code": newInfo.nationalCode,
        "email": newInfo.email,
        "code": randomNumber.toString(),
        "tel": newInfo.telephone,
        "address": newInfo.address,
        "work_address": newInfo.workAddress,
        "brands": newInfo.brand,
        "zones": newInfo.zone,
      },
      headers: {
        "authorization": token.toString(),
      },
    );
    final responseData = json.decode(response.body);
    print(responseData);
    if (responseData['errors'] != null) {
      throw responseData['errors'];
    }
    print(
        "response workAddress: ${responseData['serviceman']['work_address']}");
    print("---------------");
    print("workAddress: ${newInfo.workAddress}");
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
}
