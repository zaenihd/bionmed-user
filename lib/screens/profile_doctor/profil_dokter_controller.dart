// ignore_for_file: avoid_print, duplicate_ignore

import 'dart:convert';

import 'package:bionmed_app/constant/url.dart';
import 'package:bionmed_app/screens/layanan_nurse_home/controller/input_layanan_controller.dart';
import 'package:bionmed_app/screens/payment/controller_payment.dart';
import 'package:get/get.dart';

import '../../constant/string.dart';
import '../login/controller_login.dart';

class ProfileJadwalController extends GetxController {

  RxList dataJadwalDokter = [].obs; 
  Future<dynamic> jadwalDokter() async {
    final params = <String, dynamic>{
      // "serviceId": serviceId,
    };

    // ignore: duplicate_ignore
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}doctor/data/schedule/${Get.find<ControllerLogin>().doctorIdDetail.value}/${Get.find<ControllerPayment>().serviceId.value}?lat=${Get.find<ControllerPayment>().lat.value}&long=${Get.find<ControllerPayment>().long.value}',
          Method.GET,
          params);
      final jadwal = json.decode(result.toString());
      // ignore: avoid_print
      print("WAWA$jadwal");
      print("WAW");

      if (jadwal['code'] == 200) {
        dataJadwalDokter.value = jadwal['data'];
        // dataListOrder.value = order['data'];
        // statusOrder.value = order['data']['order']['statusOrder'];
      } else {
        // dataListOrder.clear();
      }
    } on Exception catch (e) {
      //  notif();
      // reminder(Get.context!);
      print("WAWAWAW $e");
    }
  }
  Future<dynamic> jadwalNurse() async {
    final params = <String, dynamic>{
      // "serviceId": serviceId,
    };

    // ignore: duplicate_ignore
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}nurse/data/schedule/${Get.find<InputLayananController>().idNurse.value}/${Get.find<ControllerPayment>().serviceId.value}?lat=${Get.find<ControllerPayment>().lat.value}&long=${Get.find<ControllerPayment>().long.value}',
          Method.GET,
          params);
      final jadwal = json.decode(result.toString());
      // ignore: avoid_print
      print("WAWA$jadwal");
      print("WAW");

      if (jadwal['code'] == 200) {
        dataJadwalDokter.value = jadwal['data'];
        // dataListOrder.value = order['data'];
        // statusOrder.value = order['data']['order']['statusOrder'];
      } else {
        // dataListOrder.clear();
      }
    } on Exception catch (e) {
      //  notif();
      // reminder(Get.context!);
      print("WAWAWAW $e");
    }
  }

  // Future<dynamic> jadwalNurse() async {
  //   final params = <String, dynamic>{
  //     // "serviceId": serviceId,
  //   };

  //   // ignore: duplicate_ignore
  //   try {
  //     final result = await RestClient().request(
  //         '${MainUrl.urlApi}doctor/data/schedule/${Get.find<ControllerLogin>().doctorIdDetail.value}/${Get.find<ControllerPayment>().serviceId.value}?lat=${Get.find<ControllerPayment>().lat.value}&long=${Get.find<ControllerPayment>().long.value}',
  //         Method.GET,
  //         params);
  //     final jadwal = json.decode(result.toString());
  //     // ignore: avoid_print
  //     print("WAWA$jadwal");
  //     print("WAW");

  //     if (jadwal['code'] == 200) {
  //       dataJadwalDokter.value = jadwal['data'];
  //       // dataListOrder.value = order['data'];
  //       // statusOrder.value = order['data']['order']['statusOrder'];
  //     } else {
  //       // dataListOrder.clear();
  //     }
  //   } on Exception catch (e) {
  //     //  notif();
  //     // reminder(Get.context!);
  //     print("WAWAWAW $e");
  //   }
  // }
}
