import 'dart:developer';

import 'package:bionmed_app/constant/string.dart';
import 'package:bionmed_app/screens/login/controller_login.dart';
import 'package:bionmed_app/screens/payment/api_payment.dart';
import 'package:bionmed_app/screens/payment/payment_screen.dart';
import 'package:bionmed_app/screens/payment/payment_screen_detail.dart';
import 'package:bionmed_app/screens/pesanan/api_pesanan.dart';
import 'package:bionmed_app/screens/pesanan/maps.dart';
import 'package:bionmed_app/screens/pesanan/pesanan_status_nurse.dart';
import 'package:bionmed_app/screens/pesanan/pesanan_status_status.dart';
import 'package:bionmed_app/screens/pilih_jadwal/controllers/pilih_jadwal_controller.dart';
import 'package:bionmed_app/widgets/other/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ControllerPayment extends GetxController {
  final formKey = GlobalKey<FormState>();
  var now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

  RxString dateTimeNow = "".obs;
  RxString dateOrderHomeVisit = "".obs;

  RxString vaCode = "".obs;
  RxString vaValue = "".obs;
  RxString labelPay = "".obs;
  RxString logoPay = "".obs;

  RxBool loading = false.obs;

  //locationUser
  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;
  RxString districts = "".obs;
  RxString city = "".obs;
  RxString province = "".obs;
  RxString country = "".obs;

//dataordr
  RxMap dataPayloadOrder = {}.obs;
  RxMap dataOrder = {}.obs;
  RxMap dataOrderPayment = {}.obs;
  RxString codeOrder = "".obs;
  RxString nameService = "".obs;
  RxString imageService = "".obs;
  RxInt idOrder = 0.obs;
  RxInt voucherId = 0.obs;
  RxInt serviceId = 0.obs;
  RxInt sequenceId = 0.obs;
  RxInt dicount = 0.obs;
  RxString times = ''.obs;
  RxString dates = ''.obs;
  RxString datesDoctorCall = ''.obs;
  RxString timesDoctorCall = ''.obs;
  RxInt totalPriceDiskon = 0.obs;

  RxList dataServicePrice = [].obs;

  RxMap paymentChecked = {}.obs;

  Future<dynamic> findVoucher({required String code}) async {
    loading(true);
    var value = await ApiPayment()
        .findVoucher(code: code, lat: lat.value, long: long.value);
    loading(false);
    if (value['code'] == 200) {
      showPopUp(
          onTap: () async {
            await orderAddVocuher(
                orderId: idOrder.value, voucherId: value['data']['id']);
            Get.find<PilihJadwalController>().totalBiayaFixWithVoucher.value =
                totalPriceDiskon.value.toDouble();
            Get.back();
          },
          description: value['message'],
          imageAction: 'assets/json/succes.json',
          onPress: () async {
            dicount.value = value['data']['discount'];
            await orderAddVocuher(
                orderId: idOrder.value, voucherId: value['data']['id']);
            Get.find<PilihJadwalController>().totalBiayaFixWithVoucher.value =
                totalPriceDiskon.value.toDouble();
          });
    } else {
      showPopUp(
        onTap: () {
          Get.back();
        },
        description: value['message'],
        imageAction: 'assets/json/eror.json',
      );
    }
  }

  Future<dynamic> orderAddVocuher(
      {required int orderId, required int voucherId}) async {
    loading(true);

    var value = await ApiPayment()
        .orderAddVoucher(orderId: orderId, voucherId: voucherId);
    loading(false);

    if (value['code'] == 200) {
      idOrder.value = value['data']['id'];
      dataOrder.value = value['data'];
      totalPriceDiskon.value = value['data']['totalPrice'];
      Get.to(() => const PaymentScreen());
    }
  }

  Future<dynamic> addOrder(
      // {String? date, String? time}
      ) async {
    loading(true);
    var value = await ApiPayment().order(
        doctorScheduleId: Get.find<PilihJadwalController>().idService.value,
        customerId: Get.find<ControllerLogin>().costumerId.value,
        districts: districts.value,
        city: city.value,
        province: province.value,
        country: country.value,
        lat: lat.value,
        long: long.value,
        serviceId: Get.find<PilihJadwalController>().serviceId.value,
        servicePriceId: Get.find<PilihJadwalController>().servicePriceId.value,
        startDate: Get.find<PilihJadwalController>().startDateCustomer.value,
        doctorId: Get.find<PilihJadwalController>().docterId.value,
        date: formatter.format(now.toLocal()),
        totalPrice:
            Get.find<PilihJadwalController>().totalBiayaFix.value.toInt(),
        discount: Get.find<PilihJadwalController>().diskon.value);
    // print('CEKKKKK stts' + value.toString());

    loading(false);
    if (value['code'] == 200) {
      // ignore: avoid_print
      // log('DATA == $value');
      print('doctorScheduleId  :'  +Get.find<PilihJadwalController>().idService.value.toString());
      print('customerId  :'  +Get.find<ControllerLogin>().costumerId.value.toString());
      print('districts  :'  +districts.value.toString());
      print('city  :'  +city.value.toString());
      print('province  :'  +province.value.toString());
      print('country  :'  +country.value.toString());
      print('lat  :'  +lat.value.toString());
      print('lat  :'  +long.value.toString());
      print('serviceId  :'  +Get.find<PilihJadwalController>().serviceId.value.toString());
      print('servicePriceId  :'  +  Get.find<PilihJadwalController>().servicePriceId.value.toString());
      print('startDate  :'  +  Get.find<PilihJadwalController>().startDateCustomer.value.toString());
      print('doctorId  :'  +  Get.find<PilihJadwalController>().docterId.value.toString());
      print('date  :'  +  formatter.format(now.toLocal()).toString());
      print('totalPrice  :'  +   Get.find<PilihJadwalController>().totalBiayaFix.value.toInt().toString());
      print('discount  :'  +  Get.find<PilihJadwalController>().diskon.value.toInt().toString());
      
      idOrder.value = value['data']['id'];
      dataOrder.value = value['data'];
      codeOrder.value = value['data']['code'];
      return serviceId;
    } else {}
  }

  Future<dynamic> addOrderHomeVisit(
      // {String? date, String? time}
      ) async {
    loading(true);
    var value = await ApiPayment().order(
        doctorScheduleId: Get.find<PilihJadwalController>().idService.value,
        customerId: Get.find<ControllerLogin>().costumerId.value,
        districts: districts.value,
        city: Get.find<MapsController>().city.value,
        province: Get.find<MapsController>().desa.value,
        country: Get.find<MapsController>().negara.value,
        lat: Get.find<MapsController>().lat.value,
        long: Get.find<MapsController>().long.value,
        serviceId: Get.find<PilihJadwalController>().serviceId.value,
        servicePriceId: Get.find<PilihJadwalController>().servicePriceId.value,
        startDate:
            Get.find<PilihJadwalController>().startDateCustomerHomeVisit.value,
        doctorId: Get.find<PilihJadwalController>().docterId.value,
        date: formatter.format(now.toLocal()),
        totalPrice:
            Get.find<PilihJadwalController>().totalBiayaFix.value.toInt(),
        discount: Get.find<PilihJadwalController>().diskon.value);
    // print('CEKKKKK stts' + value.toString());

    loading(false);
    if (value['code'] == 200) {
      idOrder.value = value['data']['id'];
      dataOrder.value = value['data'];
      codeOrder.value = value['data']['code'];
      return serviceId;
    }
  }

  Future<dynamic> updateOrder(
      {required String name,
      required String age,
      required String gender,
      required String phoneNumber,
      required String address,
      required String description}) async {
    loading(true);
    var value = await ApiPesanan().updateOrder(
        name: name,
        age: age,
        gender: gender,
        phoneNumber: phoneNumber,
        address: address,
        description: description,
        idOrder: idOrder.value);
    loading(false);

    if (value['code'] == 200) {
      idOrder.value = value['data']['id'];
      dataOrder.value = value['data'];
      codeOrder.value = value['data']['code'];
      Get.to(() => const PaymentScreen());
      // ignore: avoid_print
      print("CEKKKK MASUUUK $value");
    }
    if (value['code'] == 400) {
      dataOrder.clear();
    }
  }

  Future<dynamic> createVa() async {
    loading(true);
    String codeOrders = codeOrder.value;

    var value = await ApiPayment()
        .createVa(codeOrder: codeOrders, codeBank: vaValue.value);
    loading(false);
    if (value['status'] == 200) {
      dataOrderPayment.value = value['data'];
      Get.to(() => const PaymentScreenDetai());
    }
  }

  Future<dynamic> getServicePriceByDoctor({required String id}) async {
    loading(true);

    var value = await ApiPayment().getServicePrice(
        idDoctor: dataPayloadOrder['doctorId'].toString(), idService: id);
    loading(false);
    
    // ignore: avoid_print
    print("masuk sini ?$value");

    if (value['code'] == 200) {
      dataServicePrice.value = value['data'];
      return value['code'];
    } else {
      dataServicePrice.clear();
      return value['code'];
    }
  }

  Future<void> orderPlaceByDigital() async {
    String codeOrders = codeOrder.value;
    // ignore: prefer_const_constructors
    if (
      // Get.find<ControllerPayment>().serviceId.value == 4
      Get.find<ControllerPayment>().sequenceId.value == 4
      ) {
      Get.to(() => const PesananStatusScreenNurse());
      // ignore: prefer_interpolation_to_compose_strings
      log('ZAENIHD UY ' + labelPay.value +" . code " + codeOrder.value + " code String $codeOrders  " +" va VAlue " + vaValue.value + ' label pa ' + labelPay.value);
    } else {
      Get.to(()=> const PesananStatusScreen());
    }

    if (!await launchUrl(
        Uri.parse(
            '${MainUrl.urlPayment}/index/order/?url=https://www.bionmed.id/payment/success?type=$labelPay&code=$codeOrders&paymentId=$codeOrders&commCode=SGWBIONMED&bankCode=$vaValue&productCode=$labelPay'),
        mode: LaunchMode.externalNonBrowserApplication)) {
      throw 'Could not launch '
          '${MainUrl.urlPayment}/index/order/?url=https://www.bionmed.id/payment/success?type=$labelPay&code=$codeOrders&paymentId=$codeOrders&commCode=SGWBIONMED&bankCode=$vaValue&productCode=$labelPay';
    }
  }
}
