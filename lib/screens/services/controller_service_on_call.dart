import 'dart:convert';

import 'package:bionmed_app/constant/url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/string.dart';

class ControllerServiceOnCall extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController controllerSearch = TextEditingController();


  RxList searchDoctor = [].obs;
  Future<dynamic> serviceSearch() async {
    final params = <String, dynamic>{};
    RxBool isloading = false.obs;
    // ignore: unused_local_variable
    RxInt statusOrderChat = 0.obs;

    isloading(true);
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}doctor/service/1?search=${controllerSearch.value.text}', Method.GET, params);
      final servisSearch = json.decode(result.toString());
      searchDoctor.value = servisSearch['data'];
     
      // dataGetOrder = servis['data'];
      // ignore: avoid_print, invalid_use_of_protected_member
      print("WHOO ${searchDoctor.value}" );

      if (servisSearch['code'] == 200) {
        // print("cek data order get DariAPI =======" + name.toString());
        isloading(false);
      }
      isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
}