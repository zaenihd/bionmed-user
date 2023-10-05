import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bionmed_app/constant/string.dart';
import 'package:bionmed_app/constant/url.dart';
import 'package:bionmed_app/screens/layanan_nurse_home/controller/input_layanan_controller.dart';
import 'package:bionmed_app/screens/payment/controller_payment.dart';
import 'package:get/get.dart';

class WaitingResponNurseController extends GetxController{

  RxBool stopWaiting = false.obs;
  Timer? _timer;
  // ignore: unused_field
  RxInt startWaiting = 0.obs;
  RxInt nurseReciveOrderStatus = 0.obs;
  RxInt orderId = 0.obs;


  void startTimer() {
    if (stopWaiting.value == false) {
      const oneSec = Duration(seconds: 3);
      _timer = Timer.periodic(
        oneSec,
        (Timer timer)async {
          if(stopWaiting.value == false){
          await getOrderDetailNurse();
          }else{
            timer.cancel();
          }
          // if (startWaiting.value == 0) {
          //     timer.cancel();
          // } else {
          //     startWaiting.value--;

          // }
        },
      );
    }
  }
  void startTimerAmbulance() {
    if (stopWaiting.value == false) {
      const oneSec = Duration(seconds: 3);
      _timer = Timer.periodic(
        oneSec,
        (Timer timer)async {
          if(stopWaiting.value == false){
          await getOrderDetailAmbualnce();
          }else{
            timer.cancel();
          }
          // if (startWaiting.value == 0) {
          //     timer.cancel();
          // } else {
          //     startWaiting.value--;

          // }
        },
      );
    }
  }

   Future<dynamic> getOrderDetailNurse() async {
    // ${orderId.value}
    // isloading(true);
    final params = <String, dynamic>{};
    try {
      final result = await RestClient()
          .request('${MainUrl.urlApi}nurse/order/detail/${orderId.value}', Method.GET, params);
      var detailOrderNurse = json.decode(result.toString());
      if(detailOrderNurse['code'] == 200){

      nurseReciveOrderStatus.value = detailOrderNurse['data']['nurse_receive_status'];
      }

      log('DATA DETAIL ====$nurseReciveOrderStatus');
      // isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print("haha Cek error pesan$e");
    }
  }

  Future<dynamic> getOrderDetailAmbualnce() async {
    // ${orderId.value}
    // isloading(true);
    final params = <String, dynamic>{};
    try {
      final result = await RestClient()
          .request('${MainUrl.urlApi}ambulance/order/detail/${orderId.value}', Method.GET, params);
      var detailOrderNurse = json.decode(result.toString());
      if(detailOrderNurse['code'] == 200){

      nurseReciveOrderStatus.value = detailOrderNurse['data']['ambulance_receive_status'];
      }

      log('DATA DETAIL ====$nurseReciveOrderStatus');
      // isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print("haha Cek error pesan$e");
    }
  }


   Future<dynamic> updateOrderNurse() async {
    // ${orderId.value}
    Get.find<InputLayananController>().isloading(true);
    // isloading(true);
    final params = <String, dynamic>{
      "nurseId" : Get.find<InputLayananController>().idNurse.value,
      "nurse_receive_status" : 0
    };
    try {
      final result = await RestClient()
          .request('${MainUrl.urlApi}nurse/update/order/${orderId.value}', Method.POST, params);
      var updateOrder = json.decode(result.toString());
      if(updateOrder['code'] == 200){

      Get.find<ControllerPayment>().dataOrder.value = updateOrder['data'];
    Get.find<InputLayananController>().isloading(false);

    log('masuk cok$updateOrder');



      // nurseReciveOrderStatus.value = updateOrder['data']['nurse_receive_status'];
      }

      log('DATA DETAIL ====$nurseReciveOrderStatus');

      // detailScope.value = detaulNurseWorkScope["data"];
       // ignore: unused_local_variable
      // print('hahahaZZ' + detailScope.toString());

      // isloading(false);
    } on Exception catch (e) {
      Get.defaultDialog(title: 'ERROR', middleText: e.toString());
    Get.find<InputLayananController>().isloading(false);

      // ignore: avoid_print
      print("haha Cek error pesan$e");
    }
  }


}