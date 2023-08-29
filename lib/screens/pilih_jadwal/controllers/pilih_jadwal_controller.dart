// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:bionmed_app/constant/string.dart';
import 'package:bionmed_app/constant/url.dart';
import 'package:bionmed_app/screens/payment/controller_payment.dart';
import 'package:bionmed_app/screens/pesanan/controller_pesanan.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../layanan_nurse_home/controller/input_layanan_controller.dart';

class PilihJadwalController extends GetxController {
  @override
  void onInit() {
    getSchedule();
    // ignore: todo
    // TODO: implement onInit
    super.onInit();
  }

  jadwalTerlewat3Jam(String title) {
    return Get.bottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        backgroundColor: Colors.white,
        SizedBox(
            height: 400,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 18, top: 14),
                          width: Get.width / 1.9,
                          height: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xffEDEDED)),
                        ),
                        const Text(
                          'Pemberitahuan',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Image.asset('assets/icons/ic_jadwal_penuh.png'),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const SizedBox(
                          height: 14.0,
                        ),
                        const Text(
                          'Maaf, jika ingin konsultasi\nmohon pilih jadwal 4 jam sebelum pemesanan',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ButtonGradient(
                            label: title,
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        )
                      ])
                ])));
  }

  //------------DETAIL PESANAN-----------
  RxString namaLayanan = "".obs;
  RxInt servicePriceId = 0.obs;
  RxInt serviceId = 0.obs;
  RxInt docterId = 0.obs;
  RxString jenisLayanan = "".obs;
  RxString durasiLayanan = "".obs;
  RxString hargaKonsultasi = "".obs;
  RxString startDate = "".obs;
  RxString endTime = "".obs;
  RxInt diskon = 0.obs;
  RxDouble totalBiaya = 0.0.obs;
  RxInt totalBiayaFix = 0.obs;
  RxDouble totalBiayaFixWithVoucher = 0.0.obs;
  //------------------------------
  RxBool isloading = false.obs;
  RxString day = ''.obs;
  RxList dataJadwal = [].obs;
  RxInt idService = 0.obs;
  RxInt doctorScheduleId = 0.obs;

  Future<dynamic> getSchedule() async {
    final params = <String, dynamic>{};

    isloading(true);
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}doctor/schedule/day/${docterId.value}/${Get.find<ControllerPayment>().serviceId.value}?day=${day.value}&lat=${Get.find<ControllerPayment>().lat.value}&long=${Get.find<ControllerPayment>().long.value}',
          Method.GET,
          params);
      final jadwal = json.decode(result.toString());
      dataJadwal.value = jadwal['data'];

      print('ZZZZ$dataJadwal');

      isloading(false);
      // ignore: empty_catches, unused_catch_clause
    } on Exception catch (e) {}
  }

  Future<dynamic> getJadwalNurse() async {
    final params = <String, dynamic>{};

    isloading(true);
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}nurse/schedule/day/${Get.find<InputLayananController>().idNurse.value}/${Get.find<ControllerPayment>().serviceId.value}?day=${day.value}&lat=${Get.find<ControllerPayment>().lat.value}&long=${Get.find<ControllerPayment>().long.value}',
          Method.GET,
          params);
      final jadwal = json.decode(result.toString());
      dataJadwal.value = jadwal['data'];
      log('data Za $dataJadwal');

      print('ZAZAZA  $dataJadwal');
      print('zaza=======================================================');
      print('ZAZAZA date : ${startDate.value}');
      print('ZAZAZA dateNow : ${dateTimeNow.value}');
      print(
          'ZAZAZA nurseId:  ${Get.find<InputLayananController>().detailNurse['id']}');
      print('ZAZAZA servicePriceNurseId:  ${servicePriceId.value}');
      print('ZAZAZA lat:  ${Get.find<ControllerPayment>().lat.value}');
      print('ZAZAZA long:  ${Get.find<ControllerPayment>().long.value}');
      print('zaza=======================================================');
      print('ZAZAZA nurseScheduleId : ${idService.value}');
      print('ZAZAZA serviceId :  ${serviceId.value}');

      isloading(false);
      // ignore: empty_catches, unused_catch_clause
    } on Exception catch (e) {}
  }

  //--------------------REGISTER SLOT----------------
  RxString dateTimeNow = ''.obs;
  RxString statusMassage = "".obs;
  RxString startDateCustomer = "".obs;
  RxString startDateCustomerHomeVisit = "".obs;
  RxString startHoursCustomer = "".obs;
  RxString startDateHomeVisit = "".obs;
  RxString endHoursCustomer = "".obs;
  RxString dateTimeNowHome = "".obs;
  RxBool readyBooking = false.obs;

  Future<dynamic> registerSlot({required String date}) async {
    final params = <String, dynamic>{
      "date": date,
      "dateNow": dateTimeNow.value,
      "doctorId": docterId.value,
      "servicePriceId": servicePriceId.value,
      "lat": Get.find<ControllerPayment>().lat.value,
      "long": Get.find<ControllerPayment>().long.value,
    };

    isloading(true);
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}order/register/slot/${idService.value}/${serviceId.value}',
          Method.POST,
          params);
      final dataRegisterSlot = json.decode(result.toString());
      statusMassage.value = dataRegisterSlot['message'];
      readyBooking.value = dataRegisterSlot['readyBooking'];
      startDateCustomer.value = dataRegisterSlot['startDateCustomer'] ?? "";
      startHoursCustomer.value = dataRegisterSlot['startHoursCustomer'] ?? "";
      endHoursCustomer.value = dataRegisterSlot['endHoursCustomer'] ?? "";

      print('DATA REGISTER SLOT $dataRegisterSlot');
      print('date dikirim  == $date');
      print('dateNow dikirim  == ${dateTimeNow.value}');
      print('servicePriceId  == ${servicePriceId.value}');

      isloading(false);
      // ignore: empty_catches, unused_catch_clause
    } on Exception catch (e) {
      print('uwu $e');
    }
  }

  RxInt orderId = 0.obs;

  Future<dynamic> updateOrder(
      {required int doctorIdValue,
      required String startDateCustomer,
      required int servicePriceId,
      required int serviceId,
      required int totalPrice}) async {
    final params = <String, dynamic>{
      "doctorId": doctorIdValue,
      "lat": Get.find<ControllerPayment>().lat.value,
      "long": Get.find<ControllerPayment>().long.value,
      "startDate": startDateCustomer,
      "servicePriceId": servicePriceId,
      "serviceId": serviceId,
      "totalPrice": totalPrice
    };

    isloading(true);
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}order/reschedule/${Get.find<ControllerPesanan>().orderIdDetail.value}',
          Method.POST,
          params);
      final updateJadwal = json.decode(result.toString());

      print('UWWU$updateJadwal');

      isloading(false);
      // ignore: empty_catches, unused_catch_clause
    } on Exception catch (e) {
      print("UWWU $e");
    }
  }

  Future<dynamic> updateStatus(
      {required int status, required int orderId}) async {
    final params = <String, dynamic>{"status": status};
    isloading(true);

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}order/update/status/$orderId', Method.POST, params);
      final status = json.decode(result.toString());

      print("yu atu bisa masuk order ===opopopopop====$status");
      // }
      isloading(false);
    } on Exception catch (e) {
      print("Cek error =-=-=$e");
    }
  }

  Future<dynamic> updateStatusReminder({
    required int statusOrder,
    required int statusPayment,
  }) async {
    final params = <String, dynamic>{
      "statusOrder": statusOrder.toInt(),
      "statusPayment": statusPayment.toInt(),
      "reminder_status": 0
    };

    isloading(true);

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}order/update/data/${Get.find<ControllerPesanan>().idOrder}',
          Method.POST,
          params);
      // ignore: unused_local_variable
      final statusChat = json.decode(result.toString());
      // statusOrderChat = statusChat['data'];

      print("Cek update status chat$statusOrder");

      isloading(false);
    } on Exception catch (e) {
      print("Cek error =-=-=$e");
    }
  }

  //============================== NURSE ======================================

  Future<dynamic> registerSlotNurse({required String date}) async {
    final params = <String, dynamic>{
      "date": date,
      "dateNow": dateTimeNow.value,
      "nurseId": Get.find<InputLayananController>().detailNurse['id'],
      "servicePriceNurseId": servicePriceId.value,
      "lat": Get.find<ControllerPayment>().lat.value,
      "long": Get.find<ControllerPayment>().long.value,
    };

    isloading(true);
    log('masuuuk');

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}nurse/order/register/slot/${idService.value}/${Get.find<ControllerPayment>().sequenceId.value}',
          Method.POST,
          params);
      final dataRegisterSlot = json.decode(result.toString());
      if (dataRegisterSlot['code'] == 200) {
        
        // ignore: prefer_interpolation_to_compose_strings
        log('vvvvv ' +
            idService.toString() +
            " . " +
            servicePriceId.toString());

        statusMassage.value = dataRegisterSlot['message'];
        readyBooking.value = dataRegisterSlot['readyBooking'];
        startDateCustomer.value = dataRegisterSlot['startDateCustomer'] ?? "";
        startHoursCustomer.value = dataRegisterSlot['startHoursCustomer'] ?? "";
        endHoursCustomer.value = dataRegisterSlot['endHoursCustomer'] ?? "";
      }
        log('UWU HAHAHAAH$dataRegisterSlot');

      isloading(false);
      // ignore: empty_catches, unused_catch_clause
    } on Exception catch (e) {
      Get.defaultDialog(title: e.toString(), middleText: e.toString());
      print('uwu $e');
    }
  }

  Future<dynamic> updateOrderNurse(
      {required int doctorIdValue,
      required String startDateCustomer,
      required int servicePriceId,
      required int serviceId,
      required int totalPrice}) async {
    final params = <String, dynamic>{
      "nurseId": doctorIdValue,
      "lat": Get.find<ControllerPayment>().lat.value,
      "long": Get.find<ControllerPayment>().long.value,
      "startDate": startDateCustomer,
      "servicePriceNurseId": servicePriceId,
      "serviceId": serviceId,
      "total_price": totalPrice
    };

    isloading(true);
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}nurse/order/reschedule/${Get.find<ControllerPesanan>().orderIdDetail.value}',
          Method.POST,
          params);
      final updateJadwal = json.decode(result.toString());

      print('========= $updateJadwal');

      isloading(false);
      // ignore: empty_catches, unused_catch_clause
    } on Exception catch (e) {
      log("======== $e");
    }
  }
}
