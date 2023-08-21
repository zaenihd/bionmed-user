// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bionmed_app/constant/string.dart';
import 'package:bionmed_app/screens/login/controller_login.dart';
import 'package:bionmed_app/widgets/other/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ControllerProfile extends GetxController {
  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  // ignore: prefer_typing_uninitialized_variables
  var files;
  final box = GetStorage();

  Future<bool> updateImage(File imageFile) async {
    // ignore: unused_local_variable
    String id = await box.read('userId');
    print("id : $id");
    final String url = "${MainUrl.urlApi}users/photo-profile/$id";
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));
    var res = await request.send();
    // ignore: unused_local_variable
    final respStr = await res.stream.bytesToString();
    print("cek  : ${res.statusCode}");
    if (res.statusCode == 200) {
      log('zazaza $res');
      // setCurrentUser(respStr);
      // currentUser = authModelFromJson(respStr);
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> updateProfile(String name, String alamat, String brithdayDate) async {
    try {
      isLoading(true);
      String id = await box.read('userId');
      final String url = "${MainUrl.urlApi}users/update-profile/$id";
      final payload = <String, dynamic>{
        "name": name,
        "address": alamat,
        "brithdayDate": brithdayDate
        // "phoneNumber": noHp
      };

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Connection': 'keep-alive',
        },
        body: jsonEncode(payload),
      );
      isLoading(false);
      print("Cek${response.body}");
      if (response.statusCode == 200) {
        showPopUp(
          onTap: () {
                            Get.back();
                          },description: "Update profile berhasil");
        Get.find<ControllerLogin>().name.value = name;
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        showPopUp(
          onTap: () {
                            Get.back();
                          },
            description: "Update profile gagal\n${response.body}");

        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      print("err : $e");
      rethrow;
    }
  }

  Future<dynamic> ketentuanPengguna(
  ) async {
    // ignore: deprecated_member_use, empty_statements
    if (await canLaunch('https://drive.google.com/file/d/1RQfsqPC_LnSZdlVESRORcq1l2SCbujN0/view?usp=share_link')) {;
      // ignore: deprecated_member_use
      await launch('https://drive.google.com/file/d/1RQfsqPC_LnSZdlVESRORcq1l2SCbujN0/view?usp=share_link');
    } else {
      throw 'Could not launch''https://drive.google.com/file/d/1RQfsqPC_LnSZdlVESRORcq1l2SCbujN0/view?usp=share_link';
    }

}
}
