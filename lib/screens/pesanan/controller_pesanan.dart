// ignore_for_file: avoid_print, duplicate_ignore, invalid_use_of_protected_member

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bionmed_app/screens/home/home.dart';
import 'package:bionmed_app/screens/login/api_login.dart';
import 'package:bionmed_app/screens/payment/api_payment.dart';
import 'package:bionmed_app/screens/payment/controller_payment.dart';
import 'package:bionmed_app/screens/payment/payment_screen_detail.dart';
import 'package:bionmed_app/screens/pesanan/api_pesanan.dart';
import 'package:bionmed_app/screens/pesanan/maps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant/string.dart';
import '../../constant/url.dart';

class ControllerPesanan extends GetxController {
  //Text Home Visit Doctor
  TextEditingController nama = TextEditingController();
  TextEditingController usia = TextEditingController();
  TextEditingController noTel = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController jadwal = TextEditingController();
  TextEditingController desc = TextEditingController();
  String genderHome = "";
  String dayHome = "";

  final formKey = GlobalKey<FormState>();
  RxBool loading = false.obs;
  RxBool gender = false.obs;
  RxBool dontShowAgainPesanan = false.obs;
  RxBool loadingButton = false.obs;
  RxList dataOrder = [].obs;
  RxList dataOrderSedangerlangsung = [].obs;
  RxMap dataOrderChoice = {}.obs;
  RxString codeOrder = "".obs;
  RxString spesialist = "".obs;
  RxString idSpesialist = "".obs;
  RxInt updateStatusChat = 0.obs;
  RxInt updateStatusPayment = 0.obs;
  RxInt statusOrderChat = 0.obs;
  RxInt idOrder = 0.obs;
  RxInt diskonVoucher = 0.obs;
  int idOrderRinging = 0;
  RxString nameDoctor = "".obs;
  RxString imageDoctor = "".obs;

  bool stop = false;
  RxBool isSelected = false.obs;
  RxInt orderMinute = 0.obs;
  RxString imageResep = "".obs;
  RxInt statusOrder = 0.obs;
  RxInt orderId = 0.obs;
  RxString day = "".obs;
  RxString dayFormat = "".obs;
  RxString dates = "".obs;
  RxString times = "".obs;
  RxBool isStart = false.obs;

  stopTime() {
    stop = true;
  }

  datePicker() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      // ignore: avoid_print
      print("CEEEKK $pickedDate");
      dayFormat.value = DateFormat('EEEE', "id").format(pickedDate);
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      // ignore: unused_local_variable
      String starDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(pickedDate);

      // ignore: avoid_print

      day.value = DateFormat("EEEE", "id_ID").format(pickedDate);
      dates.value = formattedDate;
    } else {
      // ignore: avoid_print
      print("Date is not selected");
    }
  }

  Widget buildTimePicker() {
    return SizedBox(
      height: MediaQuery.of(Get.context!).copyWith().size.height / 3,
      child: CupertinoDatePicker(
        initialDateTime: DateTime.now(),
        onDateTimeChanged: (DateTime newdate) {
          String dates = DateFormat("HH:mm:ss", "id_ID").format(newdate);
          print(dates);
          times.value = dates.toString();
        },
        use24hFormat: true,
        // maximumDate: new DateTime(2050, 12, 30),
        // minimumYear: 2010,
        // maximumYear: 2018,
        // minuteInterval: 1,
        mode: CupertinoDatePickerMode.time,
      ),
    );
  }

  realtimeApi() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      print('MAsuk cek');
      getOrderAll(status: 0);
    });
  }

  Future<dynamic> updateStatusTimer({
    required int statusOrder,
    required int statusPayment,
  }) async {
    final params = <String, dynamic>{
      "statusOrder": statusOrder.toInt(),
      "statusPayment": statusPayment.toInt()
    };

    // isloading(true);

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}order/update/data/$idOrder', Method.POST, params);
      // ignore: unused_local_variable
      final statusChat = json.decode(result.toString());
      // statusOrderChat = statusChat['data'];

      print("Cek update status chat$statusOrder");

      // isloading(false);
    } on Exception catch (e) {
      print("Cek error =-=-=$e");
    }
  }

  //GET DATA ORDER
  RxInt statusOrderDetail = 0.obs;
  RxInt doctorId = 0.obs;
  RxInt servicePriceId = 0.obs;
  RxInt serviceId = 0.obs;
  RxInt totalPrice = 0.obs;
  RxInt orderIdDetail = 0.obs;

  RxBool isloadingDetail = false.obs;
  Future<dynamic> getOrderChat() async {
    final params = <String, dynamic>{};
    // ignore: unused_local_variable
    RxInt statusOrderChat = 0.obs;

    // isloadingDetail(true);
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}order/detail/$idOrder', Method.GET, params);
      final servis = json.decode(result.toString());
      updateStatusChat.value = servis['data']['statusOrder'];
      updateStatusPayment.value = servis['data']['statusPayment'];
      nameDoctor.value = servis['data']['doctor']['name'];
      imageDoctor.value = servis['data']['doctor']['image'] ?? "https://picsum.photos/200/300/?blur";
      statusOrderDetail.value = servis['data']['status'];
      doctorId.value = servis['data']['doctor']['id'];
      servicePriceId.value = servis['data']['servicePriceId'];
      serviceId.value = servis['data']['serviceId'];
      totalPrice.value = servis['data']['totalPrice'];
      orderIdDetail.value = servis['data']['id'];
      // ignore: prefer_if_null_operators
      imageResep.value = servis['data']['image_recipe'] == null
          ? ""
          : servis['data']['image_recipe'];

      // dataGetOrder = servis['data'];
      print('ini data : ${updateStatusChat.value}');
      print("WHOO ");

      if (servis['code'] == 200) {
        // print("cek data order get DariAPI =======" + name.toString());
        // isloadingDetail(false);
      }
      // isloadingDetail(false);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  RxList detailDataOrder = [].obs;
  RxList sopNurse = [].obs;


  Future<dynamic> getDetailOrderNurse() async {
    final params = <String, dynamic>{};
    // ignore: unused_local_variable
    RxInt statusOrderChat = 0.obs;

    // isloadingDetail(true);
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}nurse/order/detail/$idOrder', Method.GET, params);
      final servis = json.decode(result.toString());
      detailDataOrder.value = [{"order" : servis['data']}];
      // updateStatusChat.value = servis['data']['statusOrder'];
      // updateStatusPayment.value = servis['data']['statusPayment'];
      nameDoctor.value = servis['data']['nurse']['name'];
      statusOrderDetail.value = servis['data']['status'];
      doctorId.value = servis['data']['nurse']['id'];
      // servicePriceId.value =servis['data']['servicePriceId'];
      // serviceId.value = servis['data']['serviceId'];
      imageDoctor.value = servis['data']['nurse']['image'] ?? "https://picsum.photos/200/300/?blur";
      totalPrice.value = servis['data']['totalPrice'];
      orderIdDetail.value = servis['data']['id'];
      // ignore: prefer_if_null_operators
      imageResep.value = servis['data']['image_recipe'] == null
          ? ""
          : servis['data']['image_recipe'];
      sopNurse.value = servis['data']['service_price_nurse']['package_nurse_sops'];

      // dataGetOrder = servis['data'];
      print('ini data : ${updateStatusChat.value}');
      print("WHOO ");

      if (servis['code'] == 200) {
        log('zzzz masuk cuy$servis');

        // print("cek data order get DariAPI =======" + name.toString());
        // isloadingDetail(false);
      }
      // isloadingDetail(false);
    } on Exception catch (e) {
      print('zzzz $e');
    }
  }

  Future<dynamic> getDetailOrderAmbulance() async {
    final params = <String, dynamic>{};
    // ignore: unused_local_variable
    RxInt statusOrderChat = 0.obs;

    // isloadingDetail(true);
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}ambulance/order/detail/$idOrder', Method.GET, params);
      final servis = json.decode(result.toString());
      detailDataOrder.value = [{"order" : servis['data']}];
      // updateStatusChat.value = servis['data']['statusOrder'];
      // updateStatusPayment.value = servis['data']['statusPayment'];
      nameDoctor.value = servis['data']['ambulance']['name'];
      statusOrderDetail.value = servis['data']['status'];
      doctorId.value = servis['data']['ambulance']['id'];
      // servicePriceId.value =servis['data']['servicePriceId'];
      // serviceId.value = servis['data']['serviceId'];
      imageDoctor.value = servis['data']['ambulance']['image'] ?? "https://picsum.photos/200/300/?blur";
      totalPrice.value = servis['data']['totalPrice'];
      orderIdDetail.value = servis['data']['id'];
      // ignore: prefer_if_null_operators
      imageResep.value = servis['data']['image_recipe'] == null
          ? ""
          : servis['data']['image_recipe'];
      // sopNurse.value = servis['data']['service_price_ambulance']['package_nurse_sops'];

      // dataGetOrder = servis['data'];
      print('ini data : ${updateStatusChat.value}');
      print("WHOO ");

      if (servis['code'] == 200) {
        log('zzzz masuk cuy$servis');

        // print("cek data order get DariAPI =======" + name.toString());
        // isloadingDetail(false);
      }
      // isloadingDetail(false);
    } on Exception catch (e) {
      print('zzzz $e');
    }
  }

  RxMap detailDokter = {}.obs;

  Future<dynamic> getOrderDetail() async {
    final params = <String, dynamic>{};
    // ignore: unused_local_variable
    RxInt statusOrderChat = 0.obs;

    isloadingDetail(true);
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}order/detail/$idOrder', Method.GET, params);
      final servis = json.decode(result.toString());
      // detailDataOrder.value = servis['data'];
      detailDataOrder.value = [{"order" : servis['data']}];
      detailDokter.value = servis['data']['doctor'];
      updateStatusChat.value = servis['data']['statusOrder'];
      updateStatusPayment.value = servis['data']['statusPayment'];
      nameDoctor.value = servis['data']['doctor']['name'];
      statusOrderDetail.value = servis['data']['status'];
      doctorId.value = servis['data']['doctor']['id'];
      servicePriceId.value = servis['data']['servicePriceId'];
      serviceId.value = servis['data']['serviceId'];
      totalPrice.value = servis['data']['totalPrice'];
      orderIdDetail.value = servis['data']['id'];

      // ignore: prefer_if_null_operators
      imageResep.value = servis['data']['image_recipe'] == null
          ? ""
          : servis['data']['image_recipe'];

      // dataGetOrder = servis['data'];
      print('ini data : ${updateStatusChat.value}');
      log("ZEZE ${detailDataOrder[0]['order']}");

      if (servis['code'] == 200) {
        // print("cek data order get DariAPI =======" + name.toString());
        isloadingDetail(false);
      }
      isloadingDetail(false);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  //------------------Get DOKTER HOME VISIT------------------
  RxList listDokterHomeVisit = [].obs;

  Future<dynamic> getDoctorHomeVisit() async {
    final params = <String, dynamic>{};

    try {
      loading(true);
      final result = await RestClient().request(
          '${MainUrl.urlApi}doctor/service/${Get.find<ControllerPayment>().serviceId.value}?day=${Get.find<ControllerPesanan>().dayHome}&lat=${Get.find<MapsController>().lat.value}&long=${Get.find<MapsController>().long.value}',
          Method.GET,
          params);
      final dokter = json.decode(result.toString());
      listDokterHomeVisit.value = dokter['data'];

      if (dokter['code'] == 200) {
        print('UWU HAHAAH ${listDokterHomeVisit.value}');
      }
      loading(false);
    } on Exception catch (e) {
      loading(false);

      print(e.toString());
    }
  }

  Future<dynamic> getOrder({required int status}) async {
    loading(true);
    var value = await ApiLogin().getOrder(status: status);
    print("cek value order :  $value");
    if (value['code'] == 200) {
      dataOrder.value = value['data'];
    }
    if (value['code'] == 400) {
      dataOrder.value.clear();
    }
    loading(false);
  }

  Future<dynamic> getOrderPage({required int status}) async {
    loading(true);
    var value = await ApiLogin().getOrder(status: status);
    loading(false);

    if (value['code'] == 200) {
      dataOrder.value = value['data'];
    }
    if (value['code'] == 400) {
      dataOrder.value.clear();
    }
  }

  Future<dynamic> getOrderAll({required int status}) async {
    var value = await ApiLogin().getOrder(status: status);
    loading(true);

    if (value['code'] == 200) {
      print('CEK CEK${statusOrder.value}');
      dataOrder.value = value['data'];
    }
    if (value['code'] == 400) {
      dataOrder.value.clear();
    }
    loading(false);
  }

  // Future<dynamic> getOrderAllDetail({required int idOrder}) async {
  //   var value = await ApiLogin().getOrder(status: idOrder);
  //   loading(true);

  //   if (value['code'] == 200) {
  //     dataOrder.value = value['data'];
  //     print("OBJE OBJE");
  //   }
  //   if (value['code'] == 400) {
  //     dataOrder.value.clear();
  //   }
  //   loading(false);

  // }

  Future<dynamic> createVa({required String codeBank}) async {
    // print("masuk controller");
    Get.find<ControllerPayment>().loading.value = true;
    log('code $codeBank');


    var value = await ApiPayment()
        .createVa(codeOrder: codeOrder.value, codeBank: codeBank);
    Get.find<ControllerPayment>().loading.value = false;

    if (value['status'] == 200) {
      Get.find<ControllerPayment>().dataOrderPayment.value = value['data'];
      Get.to(() => const PaymentScreenDetai());
    }
  }

  Future<dynamic> orderPlaceByDigital({
    required String labelPay,
    required String vaValue,
  }) async {
    String codeOrders = codeOrder.value;
    // ignore: deprecated_member_use
    if (await canLaunch(
        '${MainUrl.urlPayment}/index/order/?url=https://www.bionmed.id/payment/success?type=$labelPay&code=$codeOrders&paymentId=$codeOrders&commCode=SGWBIONMED&bankCode=$vaValue&productCode=$labelPay')) {
      // ignore: prefer_const_constructors
      Get.to(Home(
        indexPage: 2,
      ));
      // ignore: deprecated_member_use
      await launch(
          '${MainUrl.urlPayment}/index/order/?url=https://www.bionmed.id/payment/success?type=$labelPay&code=$codeOrders&paymentId=$codeOrders&commCode=SGWBIONMED&bankCode=$vaValue&productCode=$labelPay');
    } else {
      throw 'Could not launch'
          '${MainUrl.urlPayment}/index/order/?url=https://www.bionmed.id/payment/success?type=$labelPay&code=$codeOrders&paymentId=$codeOrders&commCode=SGWBIONMED&bankCode=$vaValue&productCode=$labelPay';
    }
  }

  Future<dynamic> updateStatus(
      {required int status,
      required data,
      required String idOrder,
      context}) async {
    loadingButton(true);
    var value =
        await ApiPesanan().updateStatus(status: status, idOrder: idOrder);
    loadingButton(false);
    if (value['code'] == 200) {
      if (status == 5) {
        //
        //   showDialog(
        //     context: context,
        //     barrierDismissible:
        //         true, // set to false if you want to force a rating
        //     builder: (context) {
        //       return RatingDialog(
        //         initialRating: 1.0,
        //         // your app's name?
        //         title: const Text(
        //           'Rating Pesanan',
        //           textAlign: TextAlign.center,
        //           style: TextStyle(
        //             fontSize: 25,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //         // encourage your user to leave a high rating?
        //         message: const Text(
        //           'Ketuk bintang untuk mengatur peringkat pesamam. Tambahkan lebih banyak deskripsi di sini jika Anda mau.',
        //           textAlign: TextAlign.center,
        //           style: TextStyle(fontSize: 15),
        //         ),
        //         // your app's logo?
        //         image: Image.network(data['order']['doctor']['image']),
        //         submitButtonText: 'Kirim',
        //         commentHint: 'Tetapkan petunjuk komentar khusus Anda',
        //         onCancelled: () => print('cancelled'),
        //         onSubmitted: (response) {
        //           Get.back();
        //           Get.find<ControllerPesanan>().updateStatus(
        //               data: data,
        //               status: 5,
        //               idOrder: Get.find<ControllerPesanan>()
        //                   .idOrder
        //                   .value
        //                   .toString(),
        //               context: context);
        //           Get.back();
        //           print(
        //               'rating: ${response.rating}, comment: ${response.comment}');
        //           ApiPesanan().ratingDoctor(
        //               rating: int.parse(response.rating.toStringAsFixed(0)),
        //               descriptionRating: response.comment,
        //               idOrder: idOrder);
        //               showPopUp(
        // onTap: () {
        //   Get.back();
        // },
        // description: "Terimakasih Atas Konfirmasi\nPenyelesaian Layanan Ini\nRating yang anda beri akan membantu\nmeningkatkan kualitas layanan kami",
        // onPress: () {
        //   Get.back();});
        //         },
        //       );
        //     },
        //   );
        // }
        // );
      }
    }
  }

  Future<dynamic> updateStatusNurse(
      {required int status, required int orderId}) async {
    final params = <String, dynamic>{"status": status};
    loadingButton(true);

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}nurse/update/order/$orderId', Method.POST, params);
      final status = json.decode(result.toString());
      // ratingDoctor.value = status['data']['rating'];
      print('zezeze $status');
      // }
      loadingButton(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print("Cek error =-=-=$e");
    }
  }

  Future<dynamic> updateStatusAmbulance(
      {required int status, required int orderId}) async {
    final params = <String, dynamic>{"status": status};
    loadingButton(true);

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}ambulance/update/order/$orderId', Method.POST, params);
      final status = json.decode(result.toString());
      // ratingDoctor.value = status['data']['rating'];
      print('zezeze $status');
      // }
      loadingButton(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print("Cek error =-=-=$e");
    }
  }

  Future<dynamic> sendRating(
      { required int rating, required String deskripsi, required int orderId}
      ) async {
    final params = <String, dynamic>{
     "rating" : rating,
    "description_rating" : deskripsi
    };
    loadingButton(true);

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}nurse/update/order/$orderId', Method.POST, params);
      final rating = json.decode(result.toString());
      // ratingDoctor.value = rating['data']['rating'];
      print('nicee  $rating');
      // }
      loadingButton(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print("nicee  $e");
    }
  }

  Future<dynamic> sendRatingAmbulance(
      { required int rating, required String deskripsi, required int orderId}
      ) async {
    final params = <String, dynamic>{
     "rating" : rating,
    "description_rating" : deskripsi
    };
    loadingButton(true);

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}ambulance/update/order/$orderId', Method.POST, params);
      final rating = json.decode(result.toString());
      // ratingDoctor.value = rating['data']['rating'];
      print('nicee  $rating');
      // }
      loadingButton(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print("nicee  $e");
    }
  }
}
