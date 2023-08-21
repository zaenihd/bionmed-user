import 'dart:io';

import 'package:bionmed_app/constant/string.dart';
import 'package:bionmed_app/screens/home/home_controller.dart';
import 'package:bionmed_app/screens/login/controller_login.dart';
import 'package:bionmed_app/screens/register/api_register.dart';
import 'package:bionmed_app/screens/register/register_success.dart';
import 'package:bionmed_app/widgets/other/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  get context => null;
  RxBool isloading = false.obs;
  // ignore: prefer_typing_uninitialized_variables
  var dataUser;
  RxString phoneNumber = "".obs;
  datePickerBorn() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      // ignore: avoid_print
      print(pickedDate);
      String formattedDate = DateFormat('yyyy-mm-dd').format(pickedDate);
      // ignore: avoid_print
      print(formattedDate);
    } else {
      // ignore: avoid_print
      print("Date is not selected");
    }
  }

  Future<dynamic> registerApps(
      {required String name,
      required String brithdayDate,
      required String address,
      required String phoneNumber,
      required File? file,
      }) async {
    isloading(true);
    var value = await ApiRegister().registerApp(
        name: name,
        brithdayDate: brithdayDate,
        address: address,
        phoneNumber: phoneNumber);
    isloading(false);
    // ignore: avoid_print
    print("cek : $value");
    if (value['code'] == 200) {
      Get.find<HomeController>().dataUser = value['data'];
      Get.find<ControllerLogin>().name.value = value['data']['name'];
      updateImage(file!, value['data']['userId'].toString());
      Get.offAll(() => const RegisterSuccess());
    } else {
      showPopUp(
        onTap: () {
                            Get.back();
                          },
          imageAction: 'assets/json/eror.json',
          description: value['message'] + "\nregister your account ?",
          onPress: () {
            isloading(false);

            Get.back();
          });
    }
  }

  Future<bool> updateImage(File imageFile, String id) async {
    // ignore: unused_local_variable
    // String idDocter = Get.find<LoginController>().doctorIdImage.value;
    final String url = "${MainUrl.urlApi}users/photo-profile/$id";
    // ignore: avoid_print
    print("cek url : $url");
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));
    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      // setCurrentUser(respStr);
      // currentUser = authModelFromJson(respStr);
      return true;
    } else {
      // ignore: avoid_print
      print(respStr);
      // ignore: avoid_print
      print('Failed');
      return false;
    }
  }
}
