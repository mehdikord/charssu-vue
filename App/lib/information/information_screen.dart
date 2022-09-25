import 'dart:io';

import 'package:flutter/material.dart';
import 'package:charssu/dashboard/dashboard_screen.dart';
import 'package:charssu/providers/auth.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:album_image/album_image.dart';
import 'package:file_picker/file_picker.dart';

import '../widget/bg_widget.dart';
import 'information_input.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({Key? key}) : super(key: key);

  static const routeName = "/information";

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  late Future _dashboardBrandsFuture;
  late Future _dashboardProvincesFuture;

  String dateLabel = '';
  var testPickDate;

  String startTimeLabel = '';
  var testPickStartTime;

  String endTimeLabel = '';
  var testPickEndTime;

  Future _obtainDashboardBrandsFuture() {
    return Provider.of<Auth>(context, listen: false)
        .fetchAndSetDashboardBrands();
  }

  Future _obtainDashboardProvincesFuture() {
    return Provider.of<Auth>(context, listen: false)
        .fetchAndSetDashboardProvinces();
  }

  List? _myActivities;

  @override
  void initState() {
    _dashboardBrandsFuture = _obtainDashboardBrandsFuture();
    _dashboardProvincesFuture = _obtainDashboardProvincesFuture();
    super.initState();
    _myActivities = [];
  }

  final _formKey = GlobalKey<FormState>();
  final _familyFocusNode = FocusNode();
  final _nationalCodeFocusNode = FocusNode();
  final _birthdayFocusNode = FocusNode();
  // final _provinceFocusNode = FocusNode();
  // final _cityFocusNode = FocusNode();
  // final _zoneFocusNode = FocusNode();
  final _brandFocusNode = FocusNode();
  final _telephoneFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _startTimeFocusNode = FocusNode();
  final _endTimeFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _workAddressFocusNode = FocusNode();

  var _information = UserInformation(
    id: "",
    name: "",
    family: "",
    nationalCode: "",
    birthday: "",
    province: "",
    city: "",
    zone: [],
    brand: [],
    telephone: "",
    email: "",
    startTime: "",
    endTime: "",
    address: "",
    workAddress: "",
  );
  var _isInit = true;
  var _isLoading = false;

  Future<dynamic> dialog(var content, bool check) {
    return showDialog(
      context: context,
      builder: (c) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text(
              check ? "موفق" : "خطا",
              style: TextStyle(
                color: check ? Colors.green : Colors.red,
              ),
            ),
            content: Text(content.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  if (check) {
                    Navigator.of(context)
                        .pushReplacementNamed(DashboardScreen.routeName);
                  } else {
                    Navigator.of(c).pop();
                  }
                },
                child: const Text("تایید"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _information = Provider.of<Auth>(
        context,
        listen: false,
      ).findUser();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _familyFocusNode.dispose();
    _nationalCodeFocusNode.dispose();
    _birthdayFocusNode.dispose();
    // _provinceFocusNode.dispose();
    // _cityFocusNode.dispose();
    // _zoneFocusNode.dispose();
    _brandFocusNode.dispose();
    _telephoneFocusNode.dispose();
    _emailFocusNode.dispose();
    _startTimeFocusNode.dispose();
    _endTimeFocusNode.dispose();
    _addressFocusNode.dispose();
    _workAddressFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return dialog("لطفا اطلاعات موردنظر را پر کنید", false);
    }
    _formKey.currentState?.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(
        context,
        listen: false,
      ).updateUser(
        _information.id,
        _information,
      );
      await Provider.of<Auth>(context, listen: false).setUser();
      await dialog("ثبت اطلاعات با موفقیت انجام شد.", true);
    } catch (error) {
      await dialog(error, false);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Image backMobileImage;

    final _cityController = TextEditingController(
        text: Provider.of<Auth>(
      context,
      listen: false,
    ).findUser().city);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SizedBox(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                const BGWidget(),
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).viewPadding.top +
                          MediaQuery.of(context).size.height * 0.05,
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
                                  "assets/images/Icon-Tamirkar.png",
                                  width:
                                      MediaQuery.of(context).size.width * 0.13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Consumer<Auth>(
                      builder: (context, auth, _) {
                        return Form(
                          key: _formKey,
                          child: Container(
                            color: const Color(0xfff5f5f5),
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.95 -
                                backMobileImage.height! -
                                MediaQuery.of(context).viewPadding.top,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: Column(
                              children: [
                                const Text(
                                  "ثبت اطلاعات سرویسکار",
                                  style: TextStyle(
                                    color: Color(0xff253567),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        // Name Input
                                        InformationInput(
                                          title: "نام",
                                          input: TextFormField(
                                            initialValue: auth.findUser().name,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                            textInputAction:
                                                TextInputAction.next,
                                            onFieldSubmitted: (_) =>
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        _familyFocusNode),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'لطفا نام خود را وارد کنید!';
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              _information = UserInformation(
                                                id: _information.id,
                                                name: value.toString(),
                                                family: _information.family,
                                                nationalCode:
                                                    _information.nationalCode,
                                                birthday: _information.birthday,
                                                province: _information.province,
                                                city: _information.city,
                                                zone: _information.zone,
                                                brand: _information.brand,
                                                telephone:
                                                    _information.telephone,
                                                email: _information.email,
                                                startTime:
                                                    _information.startTime,
                                                endTime: _information.endTime,
                                                address: _information.address,
                                                workAddress:
                                                    _information.workAddress,
                                              );
                                            },
                                          ),
                                          required: true,
                                        ),
                                        // Family Input
                                        InformationInput(
                                          title: "نام خانوادگی",
                                          input: TextFormField(
                                            initialValue:
                                                auth.findUser().family,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                            textInputAction:
                                                TextInputAction.next,
                                            onFieldSubmitted: (_) =>
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        _nationalCodeFocusNode),
                                            focusNode: _familyFocusNode,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'لطفا نام خانوادگی خود را وارد کنید!';
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              _information = UserInformation(
                                                id: _information.id,
                                                name: _information.name,
                                                family: value.toString(),
                                                nationalCode:
                                                    _information.nationalCode,
                                                birthday: _information.birthday,
                                                province: _information.province,
                                                city: _information.city,
                                                zone: _information.zone,
                                                brand: _information.brand,
                                                telephone:
                                                    _information.telephone,
                                                email: _information.email,
                                                startTime:
                                                    _information.startTime,
                                                endTime: _information.endTime,
                                                address: _information.address,
                                                workAddress:
                                                    _information.workAddress,
                                              );
                                            },
                                          ),
                                          required: true,
                                        ),
                                        // NationalCode Input
                                        InformationInput(
                                          title: "کد ملی",
                                          input: TextFormField(
                                            initialValue:
                                                auth.findUser().nationalCode,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            onFieldSubmitted: (_) {
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      _birthdayFocusNode);
                                            },
                                            focusNode: _nationalCodeFocusNode,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'لطفا کد ملی خود را وارد کنید!';
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              _information = UserInformation(
                                                id: _information.id,
                                                name: _information.name,
                                                family: _information.family,
                                                nationalCode: value.toString(),
                                                birthday: _information.birthday,
                                                province: _information.province,
                                                city: _information.city,
                                                zone: _information.zone,
                                                brand: _information.brand,
                                                telephone:
                                                    _information.telephone,
                                                email: _information.email,
                                                startTime:
                                                    _information.startTime,
                                                endTime: _information.endTime,
                                                address: _information.address,
                                                workAddress:
                                                    _information.workAddress,
                                              );
                                            },
                                          ),
                                          required: true,
                                        ),
                                        // Birthday Input
                                        InformationInput(
                                          title: "تاریخ تولد",
                                          input: TextFormField(
                                            key: Key(dateLabel),
                                            onTap: () async {
                                              Jalali? picked =
                                                  await showPersianDatePicker(
                                                context: context,
                                                initialDatePickerMode:
                                                    PDatePickerMode.year,
                                                initialEntryMode:
                                                    DatePickerEntryMode
                                                        .calendar,
                                                initialDate:
                                                    dateLabel.isNotEmpty
                                                        ? testPickDate
                                                        : Jalali(1375, 1),
                                                firstDate: Jalali(1320, 1),
                                                lastDate: Jalali.now(),
                                              );
                                              if (picked != null &&
                                                  picked != Jalali.now()) {
                                                setState(() {
                                                  dateLabel =
                                                      picked.toJalaliDateTime();
                                                  testPickDate = picked;
                                                });
                                              }
                                            },
                                            initialValue: dateLabel.isNotEmpty
                                                ? dateLabel
                                                    .substring(0, 10)
                                                    .replaceAll(
                                                        RegExp(r'-'), '/')
                                                : auth.findUser().birthday,
                                            showCursor: false,
                                            keyboardType: TextInputType.none,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'انتخاب تاریخ تولد',
                                            ),
                                            // onFieldSubmitted: (_) =>
                                            //     FocusScope.of(context)
                                            //         .requestFocus(
                                            //             _addressFocusNode),
                                            // focusNode: _birthdayFocusNode,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'لطفا تاریخ تولد خود را وارد کنید!';
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              _information = UserInformation(
                                                id: _information.id,
                                                name: _information.name,
                                                family: _information.family,
                                                nationalCode:
                                                    _information.nationalCode,
                                                birthday: value.toString(),
                                                province: _information.province,
                                                city: _information.city,
                                                zone: _information.zone,
                                                brand: _information.brand,
                                                telephone:
                                                    _information.telephone,
                                                email: _information.email,
                                                startTime:
                                                    _information.startTime,
                                                endTime: _information.endTime,
                                                address: _information.address,
                                                workAddress:
                                                    _information.workAddress,
                                              );
                                            },
                                          ),
                                          required: true,
                                        ),
                                        // Province Input
                                        FutureBuilder(
                                          future: _dashboardProvincesFuture,
                                          builder: ((ctx, dataSnapShot) {
                                            return InformationInput(
                                              title: "استان",
                                              input: SelectFormField(
                                                initialValue:
                                                    auth.findUser().province,
                                                type:
                                                    SelectFormFieldType.dialog,
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.all(8.0),
                                                  label: Text(
                                                    "انتخاب استان",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  suffixIcon: Icon(
                                                      Icons.arrow_drop_down),
                                                  suffixIconColor: Colors.grey,
                                                ),
                                                // onFieldSubmitted: (_) =>
                                                //     FocusScope.of(context)
                                                //         .requestFocus(_cityFocusNode),
                                                // focusNode: _provinceFocusNode,
                                                dialogTitle: 'لیست استان ها',
                                                dialogCancelBtn: 'لغو',
                                                enableSearch: true,
                                                dialogSearchHint: 'جستجو',
                                                items: auth.provinces
                                                    .map(
                                                      (item) => ({
                                                        "value": item['id'],
                                                        "label": item['name'],
                                                      }),
                                                    )
                                                    .toList(),
                                                onChanged: (value) {
                                                  _cityController.clear();
                                                  auth.setCities(value);
                                                },
                                                onSaved: (value) {
                                                  _information =
                                                      UserInformation(
                                                    id: _information.id,
                                                    name: _information.name,
                                                    family: _information.family,
                                                    nationalCode: _information
                                                        .nationalCode,
                                                    birthday:
                                                        _information.birthday,
                                                    province: value.toString(),
                                                    city: _information.city,
                                                    zone: _information.zone,
                                                    brand: _information.brand,
                                                    telephone:
                                                        _information.telephone,
                                                    email: _information.email,
                                                    startTime:
                                                        _information.startTime,
                                                    endTime:
                                                        _information.endTime,
                                                    address:
                                                        _information.address,
                                                    workAddress: _information
                                                        .workAddress,
                                                  );
                                                },
                                              ),
                                              required: true,
                                              height: 50,
                                            );
                                          }),
                                        ),
                                        // City Input
                                        FutureBuilder(
                                          future: _dashboardProvincesFuture,
                                          builder: ((ctx, dataSnapShot) {
                                            return InformationInput(
                                              title: "شهر",
                                              input: SelectFormField(
                                                controller: _cityController,
                                                type:
                                                    SelectFormFieldType.dialog,
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.all(8.0),
                                                  label: Text(
                                                    "انتخاب شهر",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  suffixIcon: Icon(
                                                      Icons.arrow_drop_down),
                                                  suffixIconColor: Colors.grey,
                                                ),
                                                // onFieldSubmitted: (_) =>
                                                //     FocusScope.of(context)
                                                //         .requestFocus(
                                                //             _zoneFocusNode),
                                                // focusNode: _cityFocusNode,
                                                dialogTitle: 'لیست شهر ها',
                                                dialogCancelBtn: 'لغو',
                                                enableSearch: true,
                                                dialogSearchHint: 'جستجو',
                                                items: auth.cities.map((city) {
                                                  return ({
                                                    "value": city['id'],
                                                    "label": city['name'],
                                                  });
                                                }).toList(),
                                                onChanged: (value) {
                                                  auth.setZones(value);
                                                },
                                                onSaved: (value) {
                                                  _information =
                                                      UserInformation(
                                                    id: _information.id,
                                                    name: _information.name,
                                                    family: _information.family,
                                                    nationalCode: _information
                                                        .nationalCode,
                                                    birthday:
                                                        _information.birthday,
                                                    province:
                                                        _information.province,
                                                    city: value.toString(),
                                                    zone: _information.zone,
                                                    brand: _information.brand,
                                                    telephone:
                                                        _information.telephone,
                                                    email: _information.email,
                                                    startTime:
                                                        _information.startTime,
                                                    endTime:
                                                        _information.endTime,
                                                    address:
                                                        _information.address,
                                                    workAddress: _information
                                                        .workAddress,
                                                  );
                                                },
                                              ),
                                              required: true,
                                              height: 50,
                                            );
                                          }),
                                        ),
                                        // Zone Input
                                        InformationInput(
                                          title: "منطقه فعالیت",
                                          input: MultiSelectFormField(
                                            dialogShapeBorder:
                                                const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  12.0,
                                                ),
                                              ),
                                            ),
                                            title: const Text(
                                              "یک یا چند منطقه انتخاب کنید",
                                            ),
                                            dataSource: auth.zones
                                                .map((zone) {
                                                  return ({
                                                    "value": zone['id'],
                                                    "label": zone['name'],
                                                  });
                                                })
                                                .toList()
                                                .cast<dynamic>(),
                                            textField: 'label',
                                            valueField: 'value',
                                            okButtonLabel: 'تایید',
                                            cancelButtonLabel: 'لغو',
                                            hintWidget: const Text(''),
                                            initialValue: auth.findUser().zone,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'لطفا مناطق موردنظر را وارد کنید!';
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              // setState(() {
                                              //   _myActivities = value;
                                              //   print(_myActivities);
                                              //   print(auth.findUser().zone);
                                              //   print(_information.zone);
                                              // });
                                              _information = UserInformation(
                                                id: _information.id,
                                                name: _information.name,
                                                family: _information.family,
                                                nationalCode:
                                                    _information.nationalCode,
                                                birthday: _information.birthday,
                                                province: _information.province,
                                                city: _information.city,
                                                zone: value,
                                                brand: _information.brand,
                                                telephone:
                                                    _information.telephone,
                                                email: _information.email,
                                                startTime:
                                                    _information.startTime,
                                                endTime: _information.endTime,
                                                address: _information.address,
                                                workAddress:
                                                    _information.workAddress,
                                              );
                                            },
                                          ),
                                          height: 150,
                                        ),
                                        // Brand Input
                                        FutureBuilder(
                                          future: _dashboardBrandsFuture,
                                          builder: ((ctx, dataSnapShot) {
                                            return InformationInput(
                                              title: "برند فعالیت",
                                              input: MultiSelectFormField(
                                                dialogShapeBorder:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(
                                                      12.0,
                                                    ),
                                                  ),
                                                ),
                                                title: const Text(
                                                  "یک یا چند برند انتخاب کنید",
                                                ),
                                                dataSource: auth.brands
                                                    .map(
                                                      (item) => ({
                                                        "value": item['id'],
                                                        "label": item['name'],
                                                      }),
                                                    )
                                                    .toList()
                                                    .cast<dynamic>(),
                                                textField: 'label',
                                                valueField: 'value',
                                                okButtonLabel: 'تایید',
                                                cancelButtonLabel: 'لغو',
                                                hintWidget: const Text(''),
                                                initialValue: const [],
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'لطفا برند های موردنظر را وارد کنید!';
                                                  }
                                                  return null;
                                                },
                                                onSaved: (value) {
                                                  _information =
                                                      UserInformation(
                                                    id: _information.id,
                                                    name: _information.name,
                                                    family: _information.family,
                                                    nationalCode: _information
                                                        .nationalCode,
                                                    birthday:
                                                        _information.birthday,
                                                    province:
                                                        _information.province,
                                                    city: _information.city,
                                                    zone: _information.zone,
                                                    brand: value,
                                                    telephone:
                                                        _information.telephone,
                                                    email: _information.email,
                                                    startTime:
                                                        _information.startTime,
                                                    endTime:
                                                        _information.endTime,
                                                    address:
                                                        _information.address,
                                                    workAddress: _information
                                                        .workAddress,
                                                  );
                                                },
                                              ),
                                              height: 150,
                                              required: true,
                                            );
                                          }),
                                        ),
                                        // Telephone Input
                                        InformationInput(
                                          title: "شماره تلفن ثابت",
                                          input: TextFormField(
                                            initialValue:
                                                auth.findUser().telephone,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            onFieldSubmitted: (_) =>
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        _emailFocusNode),
                                            focusNode: _telephoneFocusNode,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'لطفا شماره تلفن ثابت خود را وارد کنید!';
                                              } else if (value.length != 11) {
                                                return 'شماره تلفن ثابت یک فرمت معتبر نیست!';
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              _information = UserInformation(
                                                id: _information.id,
                                                name: _information.name,
                                                family: _information.family,
                                                nationalCode:
                                                    _information.nationalCode,
                                                birthday: _information.birthday,
                                                province: _information.province,
                                                city: _information.city,
                                                zone: _information.zone,
                                                brand: _information.brand,
                                                telephone: value.toString(),
                                                email: _information.email,
                                                startTime:
                                                    _information.startTime,
                                                endTime: _information.endTime,
                                                address: _information.address,
                                                workAddress:
                                                    _information.workAddress,
                                              );
                                            },
                                          ),
                                        ),
                                        // Email Input
                                        InformationInput(
                                          title: "ایمیل",
                                          input: TextFormField(
                                            initialValue: auth.findUser().email,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            onFieldSubmitted: (_) {
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      _startTimeFocusNode);
                                            },
                                            focusNode: _emailFocusNode,
                                            onSaved: (value) {
                                              _information = UserInformation(
                                                id: _information.id,
                                                name: _information.name,
                                                family: _information.family,
                                                nationalCode:
                                                    _information.nationalCode,
                                                birthday: _information.birthday,
                                                province: _information.province,
                                                city: _information.city,
                                                zone: _information.zone,
                                                brand: _information.brand,
                                                telephone:
                                                    _information.telephone,
                                                email: value.toString(),
                                                startTime:
                                                    _information.startTime,
                                                endTime: _information.endTime,
                                                address: _information.address,
                                                workAddress:
                                                    _information.workAddress,
                                              );
                                            },
                                          ),
                                        ),
                                        // Start Time & End Time Inputs
                                        const Padding(
                                          padding: EdgeInsets.only(right: 20.0),
                                          child: Text(
                                            "زمان فعالیت",
                                            style: TextStyle(
                                              color: Color(0xff253567),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        // Start Time Input
                                        InformationInput(
                                          title: "از",
                                          input: TextFormField(
                                            key: Key(startTimeLabel.toString()),
                                            onTap: () async {
                                              await showModalBottomSheet(
                                                context: context,
                                                builder: (ctx) => SizedBox(
                                                  width: double.infinity,
                                                  height: 250,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        width: double.infinity,
                                                        height: 200,
                                                        child:
                                                            PCupertinoDatePicker(
                                                          mode:
                                                              PCupertinoDatePickerMode
                                                                  .time,
                                                          initialDateTime:
                                                              testPickStartTime,
                                                          onDateTimeChanged:
                                                              (Jalali
                                                                  dateTime) {
                                                            setState(() {
                                                              startTimeLabel =
                                                                  dateTime
                                                                      .toJalaliDateTime();
                                                              testPickStartTime =
                                                                  dateTime;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 10),
                                                        height: 30,
                                                        child: ElevatedButton(
                                                          child: const Text(
                                                              "تایید"),
                                                          onPressed: () =>
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                            initialValue: startTimeLabel
                                                    .isNotEmpty
                                                ? startTimeLabel
                                                    .substring(10, 16)
                                                    .toString()
                                                : auth
                                                        .findUser()
                                                        .startTime
                                                        .isNotEmpty
                                                    ? auth.findUser().startTime
                                                    : '',
                                            showCursor: false,
                                            keyboardType: TextInputType.none,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText:
                                                  'انتخاب زمان شروع فعالیت',
                                            ),
                                            // onFieldSubmitted: (_) =>
                                            //     FocusScope.of(context)
                                            //         .requestFocus(
                                            //             _addressFocusNode),
                                            // focusNode: _birthdayFocusNode,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'لطفا زمان شروع فعالیت خود را وارد کنید!';
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              _information = UserInformation(
                                                id: _information.id,
                                                name: _information.name,
                                                family: _information.family,
                                                nationalCode:
                                                    _information.nationalCode,
                                                birthday: _information.birthday,
                                                province: _information.province,
                                                city: _information.city,
                                                zone: _information.zone,
                                                brand: _information.brand,
                                                telephone:
                                                    _information.telephone,
                                                email: _information.email,
                                                startTime: value.toString(),
                                                endTime: _information.endTime,
                                                address: _information.address,
                                                workAddress:
                                                    _information.workAddress,
                                              );
                                            },
                                          ),
                                          width: 0.5,
                                          required: true,
                                        ),
                                        // End Time Input
                                        InformationInput(
                                          title: "تا",
                                          input: TextFormField(
                                            key: Key(endTimeLabel.toString()),
                                            onTap: () async {
                                              await showModalBottomSheet(
                                                context: context,
                                                builder: (ctx) => SizedBox(
                                                  width: double.infinity,
                                                  height: 250,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        width: double.infinity,
                                                        height: 200,
                                                        child:
                                                            PCupertinoDatePicker(
                                                          mode:
                                                              PCupertinoDatePickerMode
                                                                  .time,
                                                          initialDateTime:
                                                              testPickEndTime,
                                                          onDateTimeChanged:
                                                              (Jalali
                                                                  dateTime) {
                                                            setState(() {
                                                              endTimeLabel =
                                                                  dateTime
                                                                      .toJalaliDateTime();
                                                              testPickEndTime =
                                                                  dateTime;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 10),
                                                        height: 30,
                                                        child: ElevatedButton(
                                                          child: const Text(
                                                              "تایید"),
                                                          onPressed: () =>
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                            initialValue: endTimeLabel
                                                    .isNotEmpty
                                                ? endTimeLabel
                                                    .substring(10, 16)
                                                    .toString()
                                                : auth
                                                        .findUser()
                                                        .endTime
                                                        .isNotEmpty
                                                    ? auth.findUser().endTime
                                                    : '',
                                            showCursor: false,
                                            keyboardType: TextInputType.none,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText:
                                                  'انتخاب زمان پایان فعالیت',
                                            ),
                                            onFieldSubmitted: (_) =>
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        _addressFocusNode),
                                            // focusNode: _birthdayFocusNode,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'لطفا زمان پایان فعالیت خود را وارد کنید!';
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              _information = UserInformation(
                                                id: _information.id,
                                                name: _information.name,
                                                family: _information.family,
                                                nationalCode:
                                                    _information.nationalCode,
                                                birthday: _information.birthday,
                                                province: _information.province,
                                                city: _information.city,
                                                zone: _information.zone,
                                                brand: _information.brand,
                                                telephone:
                                                    _information.telephone,
                                                email: _information.email,
                                                startTime:
                                                    _information.startTime,
                                                endTime: value.toString(),
                                                address: _information.address,
                                                workAddress:
                                                    _information.workAddress,
                                              );
                                            },
                                          ),
                                          width: 0.5,
                                          required: true,
                                        ),
                                        // Address Input
                                        InformationInput(
                                          title: "آدرس منزل",
                                          input: TextFormField(
                                            initialValue:
                                                auth.findUser().address,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType:
                                                TextInputType.multiline,
                                            onFieldSubmitted: (_) =>
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        _workAddressFocusNode),
                                            focusNode: _addressFocusNode,
                                            maxLines: 5,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'لطفا آدرس منزل خود را وارد کنید!';
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              _information = UserInformation(
                                                id: _information.id,
                                                name: _information.name,
                                                family: _information.family,
                                                nationalCode:
                                                    _information.nationalCode,
                                                birthday: _information.birthday,
                                                province: _information.province,
                                                city: _information.city,
                                                zone: _information.zone,
                                                brand: _information.brand,
                                                telephone:
                                                    _information.telephone,
                                                email: _information.email,
                                                startTime:
                                                    _information.startTime,
                                                endTime: _information.endTime,
                                                address: value.toString(),
                                                workAddress:
                                                    _information.workAddress,
                                              );
                                            },
                                          ),
                                          height: 100,
                                          required: true,
                                        ),
                                        // Work Address Input
                                        InformationInput(
                                          title: "آدرس محل کار",
                                          input: TextFormField(
                                            initialValue:
                                                auth.findUser().workAddress,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                            textInputAction:
                                                TextInputAction.done,
                                            keyboardType:
                                                TextInputType.multiline,
                                            focusNode: _workAddressFocusNode,
                                            maxLines: 5,
                                            onSaved: (value) {
                                              _information = UserInformation(
                                                id: _information.id,
                                                name: _information.name,
                                                family: _information.family,
                                                nationalCode:
                                                    _information.nationalCode,
                                                birthday: _information.birthday,
                                                province: _information.province,
                                                city: _information.city,
                                                zone: _information.zone,
                                                brand: _information.brand,
                                                telephone:
                                                    _information.telephone,
                                                email: _information.email,
                                                startTime:
                                                    _information.startTime,
                                                endTime: _information.endTime,
                                                address: _information.address,
                                                workAddress: value.toString(),
                                              );
                                            },
                                          ),
                                          height: 100,
                                        ),
                                        // Technical License Input
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                right: 20.0,
                                                top: 20.0,
                                              ),
                                              child: Text(
                                                "بارگذاری مدارک فنی و حرفه‌ای :",
                                                style: TextStyle(
                                                  color: Color(0xff253567),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    right: 20.0,
                                                  ),
                                                  child: RaisedButton(
                                                    onPressed: () async {
                                                      FilePickerResult? result =
                                                          await FilePicker
                                                              .platform
                                                              .pickFiles(
                                                        type: FileType.custom,
                                                        allowedExtensions: [
                                                          'pdf',
                                                          'doc',
                                                        ],
                                                      );
                                                      if (result != null) {
                                                        File file = File(result
                                                            .files.single.path
                                                            .toString());
                                                        print(file);
                                                      } else {
                                                        // User canceled the picker
                                                      }
                                                    },
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    color:
                                                        const Color(0xff62bbd8),
                                                    textColor:
                                                        const Color(0xfff5f5f5),
                                                    child: const Text(
                                                      "فایل را انتخاب کنید",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {},
                                                  child: const Text(
                                                    "+",
                                                    style: TextStyle(
                                                      color: Color(0xff62bbd8),
                                                      fontSize: 32,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        // Police Certificate Input
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20.0),
                                              child: Text(
                                                "بارگذاری مدارک عدم سوپیشینه :",
                                                style: TextStyle(
                                                  color: Color(0xff253567),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    right: 20.0,
                                                  ),
                                                  child: RaisedButton(
                                                    onPressed: () async {
                                                      final ImagePicker
                                                          _picker =
                                                          ImagePicker();
                                                      // Pick an image
                                                      final XFile? image =
                                                          await _picker
                                                              .pickImage(
                                                        source:
                                                            ImageSource.gallery,
                                                      );
                                                      // // Capture a photo
                                                      // final XFile? photo =
                                                      //     await _picker.pickImage(
                                                      //         source:
                                                      //             ImageSource
                                                      //                 .camera);
                                                      // // Pick a video
                                                      // final XFile? clip =
                                                      //     await _picker.pickVideo(
                                                      //         source:
                                                      //             ImageSource
                                                      //                 .gallery);
                                                      // // Capture a video
                                                      // final XFile? video =
                                                      //     await _picker.pickVideo(
                                                      //         source:
                                                      //             ImageSource
                                                      //                 .camera);
                                                      // // Pick multiple images
                                                      // final List<XFile>?
                                                      //     images = await _picker
                                                      //         .pickMultiImage();
                                                      if (image != null) {
                                                        print(image.toString());
                                                      } else {
                                                        // User canceled the picker
                                                      }
                                                    },
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    color:
                                                        const Color(0xff62bbd8),
                                                    textColor:
                                                        const Color(0xfff5f5f5),
                                                    child: const Text(
                                                      "فایل را انتخاب کنید",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        // Non-Addictions Input
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                right: 20.0,
                                              ),
                                              child: Text(
                                                "بارگذاری مدارک عدم اعتیاد :",
                                                style: TextStyle(
                                                  color: Color(0xff253567),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    right: 20.0,
                                                  ),
                                                  child: RaisedButton(
                                                    onPressed: () async {
                                                      FilePickerResult? result =
                                                          await FilePicker
                                                              .platform
                                                              .pickFiles(
                                                        allowMultiple: true,
                                                        type: FileType.custom,
                                                        allowedExtensions: [
                                                          'pdf',
                                                          'doc',
                                                        ],
                                                      );
                                                      if (result != null) {
                                                        File file = File(result
                                                            .files.single.path
                                                            .toString());
                                                        print(file);
                                                      } else {
                                                        // User canceled the picker
                                                      }
                                                    },
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    color:
                                                        const Color(0xff62bbd8),
                                                    textColor:
                                                        const Color(0xfff5f5f5),
                                                    child: const Text(
                                                      "فایل را انتخاب کنید",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {},
                                                  child: const Text(
                                                    "+",
                                                    style: TextStyle(
                                                      color: Color(0xff62bbd8),
                                                      fontSize: 32,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        // Profile Input
                                        Column(
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20.0),
                                              child: Text(
                                                "بارگذاری عکس سرویس کار :",
                                                style: TextStyle(
                                                  color: Color(0xff253567),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  isScrollControlled: true,
                                                  enableDrag: true,
                                                  builder: (c) {
                                                    return Container(
                                                      margin: EdgeInsets.only(
                                                          top: MediaQuery.of(
                                                                  context)
                                                              .viewPadding
                                                              .top),
                                                      child: Directionality(
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        child: AlbumImagePicker(
                                                          onSelected: (items) {
                                                            print(items);
                                                          },
                                                          iconSelectionBuilder:
                                                              (_, selected,
                                                                  index) {
                                                            if (selected) {
                                                              return const CircleAvatar(
                                                                  radius: 10);
                                                            }
                                                            return Container();
                                                          },
                                                          selectedItemBackgroundColor:
                                                              Colors.red,
                                                          crossAxisCount: 3,
                                                          maxSelection: 1,
                                                          albumBackGroundColor:
                                                              Colors.white,
                                                          appBarHeight: 45,
                                                          itemBackgroundColor:
                                                              Colors.grey[100]!,
                                                          appBarColor:
                                                              Colors.white,
                                                          albumTextStyle:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                          ),
                                                          albumSubTextStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 10),
                                                          type: AlbumType.image,
                                                          closeWidget:
                                                              BackButton(
                                                            onPressed: () {
                                                              Navigator.of(c)
                                                                  .pop();
                                                            },
                                                            color: Colors.black,
                                                          ),
                                                          thumbnailQuality:
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width ~/
                                                                  3 *
                                                                  3,
                                                          appBarActionWidgets: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(c)
                                                                    .pop();
                                                              },
                                                              child: const Text(
                                                                  "تایید"),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: const CircleAvatar(
                                                radius: 50,
                                                backgroundImage: AssetImage(
                                                    "assets/images/Avatar-Upload-Pic.png"),
                                                backgroundColor:
                                                    Color(0x00000000),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Submit Button
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 20.0,
                                            ),
                                            child: RaisedButton(
                                              onPressed: _saveForm,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        (0.1),
                                                vertical: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.005,
                                              ),
                                              color: const Color(0xff76d862),
                                              textColor:
                                                  const Color(0xfff5f5f5),
                                              child: _isLoading
                                                  ? const SizedBox(
                                                      width: 22.0,
                                                      height: 22.0,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  : const Text(
                                                      "ثبت",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
