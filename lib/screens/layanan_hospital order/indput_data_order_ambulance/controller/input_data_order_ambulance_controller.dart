import 'dart:convert';
import 'dart:developer';

import 'package:bionmed_app/screens/layanan_nurse_home/controller/input_layanan_controller.dart';
import 'package:bionmed_app/screens/login/controller_login.dart';
import 'package:bionmed_app/screens/payment/controller_payment.dart';
import 'package:bionmed_app/screens/pesanan/maps.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant/string.dart';
import '../../../../constant/url.dart';
import '../../../layanan_nurse_home/controller/waiting_respon_nurse_controller.dart';

class InputDataOrderAmbulanceController extends GetxController {
  RxInt serviceAmbulance = 0.obs;
  RxBool isPesanSekarang = false.obs;
  RxBool isLoadingAlamat = false.obs;
  RxBool isLoading = false.obs;
  RxBool isCrs = false.obs;
  RxString tanggalOrder = ''.obs;
  RxInt isCrsFromOrder = 0.obs;
  RxString endCityCsr = ''.obs;
  TextEditingController tanggalC = TextEditingController();
  final inputC = Get.find<InputLayananController>();
  final mapC = Get.find<MapsController>();
  final waitingC = Get.put(WaitingResponNurseController());


  Future<dynamic> checkCsr({required String startCity}) async {
    final params = <String, dynamic>{
      "servicePriceId": inputC.servicePriceIdAmbulance.value,
      "start_city": startCity,
      "end_city":endCityCsr.value
    };
    // isloading(true);
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}ambulance/order/check/csr', Method.POST, params);
      // ignore: unused_local_variable
      final dataCsr = json.decode(result.toString());
      isCrs.value = dataCsr['isCSR'];
      log('loh ko bisaa${isCrs.value}');

      // listPaketDataNurse.value = listNursePaketFromFilter['data'];

      // jadwalDokter = jadwal['data']['doctor_schedules'];
      // }

      // isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print('ZAZAZA $e');
    }
  }

  Future<dynamic> addOrderAmbulance({
    required String endDistrict,
    required String endCity,
    required String endProvince,
    required String endCountry,
    required double endLat,
    required double endLong,
    required int servicePriceAmbulanceId,
    required int totalPrice,
    required int discount,
    required int ambulanceId
  }) async {
    final params = <String, dynamic>{
      "customerId": Get.find<ControllerLogin>().costumerId.value,
      "start_districts": mapC.desa.value,
      "start_city": mapC.city.value,
      "start_province": mapC.kabupaten.value,
      "start_country": mapC.negara.value,
      "start_lat": mapC.lat.value,
      "start_long": mapC.long.value,
      "end_districts": endDistrict,
      "end_city": endCity,
      "end_province": endProvince,
      "end_country": endCountry,
      "end_lat": endLat,
      "end_long": endLong,
      "serviceId": 8,
      "servicePriceAmbulanceId": servicePriceAmbulanceId,
      "is_csr": isCrs.isFalse ? 0 : 1,
      "startDate": tanggalOrder.value,
      "ambulanceId": ambulanceId,
      "status": 0,
      "date": tanggalOrder.value,
      "totalPrice": totalPrice,
      "discount": discount
    };
    isLoading(true);
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}ambulance/order', Method.POST, params);
      // ignore: unused_local_variable
      final dataOrder = json.decode(result.toString());
      waitingC.orderId.value = dataOrder['data']['id'];
      isCrsFromOrder.value = dataOrder['data']['is_csr'];
      log('loh ko bisaa===========$dataOrder');
       Get.find<ControllerPayment>().dataOrder.value = dataOrder['data'];
      Get.find<ControllerPayment>().codeOrder.value =
      Get.find<ControllerPayment>().dataOrder['code'];
      log("message id Order ${waitingC.orderId.value}");
    isLoading(false);



      // listPaketDataNurse.value = listNursePaketFromFilter['data'];

      // jadwalDokter = jadwal['data']['doctor_schedules'];
      // }

      // isloading(false);
    } on Exception catch (e) {
    isLoading(false);

      // ignore: avoid_print
      print('ZAZAZA $e');
    }
  }

  Future<dynamic> batalkanPesanan({required int statusRespone}) async {
    final params = <String, dynamic>{"ambulance_receive_status": statusRespone};

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}ambulance/update/order/${waitingC.orderId.value}',
          Method.POST,
          params);
      final order = json.decode(result.toString());
      // stopTime.value = true;

      log('zaeehahaa $order');

      // ignore: empty_catches, unused_catch_clause
    } on Exception catch (e) {
      // ignore: avoid_print
      print('zaeejaja $e');
    }
  }

  Future<dynamic> updateStatusBatalAmbulance(
      {required int status}) async {
    final params = <String, dynamic>{"status": status};
    // loadingButton(true);

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}ambulance/update/order/${waitingC.orderId.value}', Method.POST, params);
      final status = json.decode(result.toString());
      // ratingDoctor.value = status['data']['rating'];
      print('zezeze $status');
      // }
      // loadingButton(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print("Cek error =-=-=$e");
    }
  }
}
