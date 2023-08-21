import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControllerArticel extends GetxController {
  final formKey = GlobalKey<FormState>();
  RxList dataOrder = [].obs;

  // Future<dynamic> getOrder(
  //     {required int idCustomer, required String token}) async {
  //   var value = await ApiLogin().getOrder(idCustomer: idCustomer, token: token);
  //   print("cek value order :  " + value.toString());
  //   if (value['code'] == 200) {
  //     dataOrder.value = value['data'];
  //   }
  // }
}
