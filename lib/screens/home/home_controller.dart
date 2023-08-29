import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bionmed_app/constant/string.dart';
import 'package:bionmed_app/constant/url.dart';
import 'package:bionmed_app/screens/call/page_voice.dart';
import 'package:bionmed_app/screens/chat/chat_dokter.dart';
import 'package:bionmed_app/screens/home/api_home.dart';
import 'package:bionmed_app/screens/home/home_screen.dart';
import 'package:bionmed_app/screens/login/controller_login.dart';
import 'package:bionmed_app/screens/payment/controller_payment.dart';
import 'package:bionmed_app/screens/pesanan/controller_pesanan.dart';
import 'package:bionmed_app/screens/videoCall/page_call.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:zego_zimkit/services/services.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  String url = 'assets/ringtone/COMTelph_Phone ring 5 (ID 0375)_BSB.wav';
  final assetsAudioPlayer = AssetsAudioPlayer();
  RxBool timePeriodic = false.obs;

  RxBool isNotif = false.obs;
  RxBool isloading = false.obs;
  RxInt inboxId = 0.obs;
  RxString titlePesan = ''.obs;
  RxBool realtimeApiGet = true.obs;
  RxString description = "".obs;

  Future<bool> checkGpsStatus() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    return false;
  }
  
  return await Geolocator.isLocationServiceEnabled();
}
Future<void> enableGPS() async {
   final PermissionStatus permission = await Permission.locationWhenInUse.status;
  if (!permission.isGranted) {
    Get.defaultDialog();
    // Fluttertoast.showToast(
    //   msg: 'Please enable GPS in your device settings',
    //   toastLength: Toast.LENGTH_LONG,
    //   gravity: ToastGravity.BOTTOM,
    // );
  }
}

  reminderKeberangkatanDokter() {
    return Get.bottomSheet(
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
                        Image.asset('assets/icons/ic_keberangkatan.png'),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const SizedBox(
                          height: 14.0,
                        ),
                        const Text(
                          'Dokter sedang berangkat menuju ke\nlokasi anda sekarang',
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
                            label: "Oke",
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        )
                      ])
                ])));
  }

  Future<void> showCallkitIncoming({
    required String uuid,
    required Function() onTap,
    required String nameCaller,
    required String nameOrder,
    required String image,
    required StreamSubscription callIncoming,
  }) async {
    final params = CallKitParams(
      id: uuid,
      nameCaller: nameOrder,
      appName: 'Callkit',
      avatar: image,
      handle: nameCaller,
      type: 0,
      duration: 60000,
      textAccept: 'Accept',
      textDecline: 'Decline',
      // textMissedCall: 'Missed call',
      // textCallback: 'Call back',
      extra: <String, dynamic>{'userId': '1a2b3c4d'},
      headers: <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
      android: const AndroidParams(
        isCustomNotification: true,
        isShowLogo: false,
        // isShowCallback: true,
        // isShowMissedCallNotification: true,
        ringtonePath: 'system_ringtone_default',
        backgroundColor: '#0955fa',
        backgroundUrl: 'assets/test.png',
        actionColor: '#4CAF50',
      ),
    );
    await FlutterCallkitIncoming.showCallkitIncoming(params);
    callIncoming;
  }

  void playRingtone() async {
    await assetsAudioPlayer.open(Audio(url));
    assetsAudioPlayer.play();
  }

  void stopRingtone() {
    assetsAudioPlayer.stop();
  }

  notif() {
    // AwesomeNotifications().createNotification(
    //     content: NotificationContent(
    //         id: 10, channelKey: 'basic_channel', title: "Layanan Akan Segera Dimulah",  ));
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: 'Peringatan!',
            body: 'Mengingat waktu untuk pesanan\nakan berlangsung 3 Jam lagi',
            actionType: ActionType.Default,
            wakeUpScreen: true));
  }

  notifLayanan() {
    // AwesomeNotifications().createNotification(
    //     content: NotificationContent(
    //         id: 10, channelKey: 'basic_channel', title: "Layanan Akan Segera Dimulah",  ));
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: 'Peringatan!',
            body:
                'Mengingat waktu untuk pesanan\nakan berlangsung 5 Menit lagi',
            actionType: ActionType.Default,
            wakeUpScreen: true));
  }

  Future<dynamic> hapusPesan() async {
    final params = <String, dynamic>{};
    try {
      isloading(true);
      final result = await RestClient().request(
          '${MainUrl.urlApi}inbox/delete/$inboxId)', Method.POST, params);
      // ignore: unused_local_variable
      var hapus = json.decode(result.toString());

      // }
      isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print("Cek error pesan$e");
    }
  }

  Future<dynamic> hapusPesanNurse() async {
    final params = <String, dynamic>{};
    try {
      isloading(true);
      final result = await RestClient().request(
          '${MainUrl.urlApi}inbox/nurse/delete/$inboxId)', Method.POST, params);
      // ignore: unused_local_variable
      var hapus = json.decode(result.toString());

      // }
      isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print("Cek error pesan$e");
    }
  }

  Future<dynamic> reminderPayment() async {
    final params = <String, dynamic>{
      "lat": Get.find<ControllerPayment>().lat.value,
      "long": Get.find<ControllerPayment>().long.value
      // "serviceId": serviceId,
    };

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}customer/reminder/order/${Get.find<ControllerLogin>().costumerId.value}',
          Method.POST,
          params);
      final order = json.decode(result.toString());

      if (order['code'] == 200) {
        //   reminder(Get.context!);
        // notif();
        notif();
        reminder(Get.context!);
        // dataListOrder.value = order['data'];
        // statusOrder.value = order['data']['order']['statusOrder'];
      } else {
        // dataListOrder.clear();
      }
    } on Exception catch (e) {
      // notif();
      // reminder(Get.context!);
      // ignore: avoid_print
      print("WAWAWAW $e");
    }
  }

  Future<dynamic> reminderLayanan() async {
    final params = <String, dynamic>{
      "lat": Get.find<ControllerPayment>().lat.value,
      "long": Get.find<ControllerPayment>().long.value
      // "serviceId": serviceId,
    };

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}customer/reminder/order/telemedicine/${Get.find<ControllerLogin>().costumerId.value}',
          Method.POST,
          params);
      final order = json.decode(result.toString());

      if (order['code'] == 200) {
        //   reminder(Get.context!);
        // notif();
        notifLayanan();
        reminderLayananTelemedicine(Get.context!);
        // dataListOrder.value = order['data'];
        // statusOrder.value = order['data']['order']['statusOrder'];
      } else {
        // dataListOrder.clear();
      }
    } on Exception catch (e) {
      // notifLayanan();
      //   reminderLayananTelemedicine(Get.context!);
      // notif();
      // reminder(Get.context!);
      // ignore: avoid_print
      print("WAWAWAW $e");
    }
  }

  Future<dynamic> automaticUpdateStatus() async {
    final params = <String, dynamic>{};
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}cron/automatic/update/status/order',
          Method.GET,
          params);
      final statusUpdate = json.decode(result.toString());
      log('zeen$statusUpdate');
    } on Exception catch (e) {
      // ignore: avoid_print
      print("ERROR NIH ==  $e");
    }
  }

  trimUpdateStatus(){
    Timer.periodic(const Duration(seconds: 60), (timer) async{
    await automaticUpdateStatus();
    });
  }

  //POP UP RINGTONE API
  realtimeApi() {
    if (timePeriodic.value == false) {
      Timer.periodic(const Duration(seconds: 3), (timer) {
        Get.find<ControllerPesanan>().getOrderAll(status: 0);
        reminderLayanan();
        // Get.find<LayananHomeController>().getOrder();
        reminderPayment();
        for (int i = 0;
            i < Get.find<ControllerPesanan>().dataOrder.length;
            i++) {
          // ignore: avoid_print
          print("masuuukk${Get.find<ControllerPesanan>().dataOrder}");
          if (Get.find<ControllerPesanan>().dataOrder[i]['order']
                          ['statusOrder'] ==
                      1 &&
                  Get.find<ControllerPesanan>().dataOrder[i]['order']
                          ['statusPayment'] ==
                      2
              // && Get.find<ControllerPesanan>().startRingging.value == 1
              ) {
            if (Get.find<ControllerPesanan>().dataOrder[i]['order']
                    ['service_price']['name'] ==
                'Layanan Chat') {
              timePeriodic.value = true;
              showCallkitIncoming(
                  image:
                      "${Get.find<ControllerPesanan>().dataOrder[i]['order']['doctor']['image']}",
                  nameCaller: "Panggilan Layanan Chat",
                  nameOrder:
                      "${Get.find<ControllerPesanan>().dataOrder[i]['order']['doctor']['name']}",
                  onTap: () {
                    Get.defaultDialog();
                  },
                  uuid: "1",
                  callIncoming:
                      FlutterCallkitIncoming.onEvent.listen((event) async {
                    switch (event!.event) {
                      case Event.actionCallIncoming:
                        break;
                      case Event.actionCallStart:
                        break;
                      case Event.actionCallAccept:
                        // Get.defaultDialog(title: 'HAHAHAH MANTAP COY');
                        Get.find<ControllerPesanan>().orderMinute.value =
                            Get.find<ControllerPesanan>().dataOrder[i]['order']
                                ['service_price']['minute'];
                        Get.find<ControllerPesanan>().idOrder.value =
                            Get.find<ControllerPesanan>().dataOrder[i]['order']
                                ['id'];
                        await Get.find<ControllerPesanan>().getOrderChat();
                        await ZIMKit().connectUser(
                          // ignore: prefer_interpolation_to_compose_strings
                          id: Get.find<ControllerPesanan>()
                              .dataOrder[i]['order']['customer']['userId']
                              .toString(),
                        );
                        final userIDController = TextEditingController(
                            text: Get.find<ControllerPesanan>()
                                .dataOrder[i]['order']['doctor']['userId']
                                .toString());
                        Get.to(() => ZIMKitMessageListPageChat(
                              conversationID: userIDController.text,
                            ));

                        break;
                      case Event.actionCallDecline:
                        timePeriodic.value = false;
                        realtimeApiGet.value = false;
                        if (realtimeApiGet.isFalse) {
                          realtimeApi();
                        }
                        break;
                      case Event.actionCallEnded:
                        break;
                      case Event.actionCallTimeout:
                        timePeriodic.value = false;
                        realtimeApiGet.value = false;
                        if (realtimeApiGet.isFalse) {
                          realtimeApi();
                        }
                        break;
                      // case Event.ACTION_CALL_CALLBACK:
                      //   break;
                      // case Event.ACTION_CALL_TOGGLE_HOLD:
                      //   break;
                      // case Event.ACTION_CALL_TOGGLE_MUTE:
                      //   break;
                      // case Event.ACTION_CALL_TOGGLE_DMTF:
                      //   break;
                      // case Event.ACTION_CALL_TOGGLE_GROUP:
                      //   break;
                      // case Event.ACTION_CALL_TOGGLE_AUDIO_SESSION:
                      //   break;
                      // case Event.ACTION_DID_UPDATE_DEVICE_PUSH_TOKEN_VOIP:
                      //   break;
                      case Event.actionDidUpdateDevicePushTokenVoip:
                        break;
                      case Event.actionCallCallback:
                        break;
                      case Event.actionCallToggleHold:
                        break;
                      case Event.actionCallToggleMute:
                        break;
                      case Event.actionCallToggleDmtf:
                        break;
                      case Event.actionCallToggleGroup:
                        break;
                      case Event.actionCallToggleAudioSession:
                        break;
                      case Event.actionCallCustom:
                        break;
                    }
                  }));
            } else if (Get.find<ControllerPesanan>().dataOrder[i]['order']
                    ['service_price']['name'] ==
                'Layanan Telephone') {
              timePeriodic.value = true;
              showCallkitIncoming(
                  image:
                      "${Get.find<ControllerPesanan>().dataOrder[i]['order']['doctor']['image']}",
                  nameCaller: "Panggilan Layanan Telephone",
                  nameOrder:
                      "${Get.find<ControllerPesanan>().dataOrder[i]['order']['doctor']['name']}",
                  onTap: () {
                    Get.defaultDialog();
                  },
                  uuid: "1",
                  callIncoming:
                      FlutterCallkitIncoming.onEvent.listen((event) async {
                    switch (event!.event) {
                      case Event.actionCallIncoming:
                        break;
                      case Event.actionCallStart:
                        break;
                      case Event.actionCallAccept:
                        // Get.defaultDialog(title: 'HAHAHAH MANTAP COY');
                        Get.find<ControllerPesanan>().orderMinute.value =
                            Get.find<ControllerPesanan>().dataOrder[i]['order']
                                ['service_price']['minute'];
                        Get.find<ControllerPesanan>().idOrder.value =
                            Get.find<ControllerPesanan>().dataOrder[i]['order']
                                ['id'];
                        await Get.find<ControllerPesanan>().getOrderChat();
                        Get.to(() => VoiceScreen(
                            data: Get.find<ControllerPesanan>().dataOrder[i],
                            userid: Get.find<ControllerPesanan>()
                                .dataOrder[i]['order']['customer']['userId']
                                .toString(),
                            userName: Get.find<ControllerPesanan>().dataOrder[i]
                                ['order']['customer']['name'],
                            callId: Get.find<ControllerPesanan>()
                                .dataOrder[i]['order']['id']
                                .toString()));

                        break;
                      case Event.actionCallDecline:
                        // Get.defaultDialog(title: 'HAHAHAH MANTAP');
                        timePeriodic.value = false;
                        realtimeApiGet.value = false;
                        if (realtimeApiGet.isFalse) {
                          realtimeApi();
                        }

                        break;
                      case Event.actionCallEnded:
                        break;
                      case Event.actionCallTimeout:
                        timePeriodic.value = false;
                        realtimeApiGet.value = false;
                        if (realtimeApiGet.isFalse) {
                          realtimeApi();
                        }
                        break;
                      // case Event.ACTION_CALL_CALLBACK:
                      //   break;
                      // case Event.ACTION_CALL_TOGGLE_HOLD:
                      //   break;
                      // case Event.ACTION_CALL_TOGGLE_MUTE:
                      //   break;
                      // case Event.ACTION_CALL_TOGGLE_DMTF:
                      //   break;
                      // case Event.ACTION_CALL_TOGGLE_GROUP:
                      //   break;
                      // case Event.ACTION_CALL_TOGGLE_AUDIO_SESSION:
                      //   break;
                      // case Event.ACTION_DID_UPDATE_DEVICE_PUSH_TOKEN_VOIP:
                      //   break;
                      case Event.actionDidUpdateDevicePushTokenVoip:
                        break;
                      case Event.actionCallCallback:
                        break;
                      case Event.actionCallToggleHold:
                        break;
                      case Event.actionCallToggleMute:
                        break;
                      case Event.actionCallToggleDmtf:
                        break;
                      case Event.actionCallToggleGroup:
                        break;
                      case Event.actionCallToggleAudioSession:
                        break;
                      case Event.actionCallCustom:
                        break;
                    }
                  }));

            } else if (Get.find<ControllerPesanan>().dataOrder[i]['order']
                    ['service_price']['name'] ==
                'Layanan Video Call') {
              timePeriodic.value = true;
              showCallkitIncoming(
                  image:
                      "${Get.find<ControllerPesanan>().dataOrder[i]['order']['doctor']['image']}",
                  nameCaller: "Panggilan Layanan Video Call",
                  nameOrder:
                      "${Get.find<ControllerPesanan>().dataOrder[i]['order']['doctor']['name']}",
                  onTap: () {
                    Get.defaultDialog();
                  },
                  uuid: "1",
                  callIncoming:
                      FlutterCallkitIncoming.onEvent.listen((event) async {
                    switch (event!.event) {
                      case Event.actionCallIncoming:
                        break;
                      case Event.actionCallStart:
                        break;
                      case Event.actionCallAccept:
                        // Get.defaultDialog(title: 'HAHAHAH MANTAP COY');
                        Get.find<ControllerPesanan>().orderMinute.value =
                            Get.find<ControllerPesanan>().dataOrder[i]['order']
                                ['service_price']['minute'];
                        Get.find<ControllerPesanan>().idOrder.value =
                            Get.find<ControllerPesanan>().dataOrder[i]['order']
                                ['id'];
                        await Get.find<ControllerPesanan>().getOrderChat();
                        // await Get.find<ControllerPesanan>().updateStatusTimer(
                        //     statusOrder: Get.find<ControllerPesanan>()
                        //             .updateStatusChat
                        //             .value +
                        //         1,
                        //     statusPayment: Get.find<ControllerPesanan>()
                        //             .updateStatusPayment
                        //             .value +
                        //         1);
                        Get.to(() => CallScreen(
                            userid: Get.find<ControllerPesanan>()
                                .dataOrder[i]['order']['customer']['userId']
                                .toString(),
                            userName: Get.find<ControllerPesanan>().dataOrder[i]
                                ['order']['customer']['name'],
                            data: Get.find<ControllerPesanan>().dataOrder[i],
                            callId: Get.find<ControllerPesanan>()
                                .dataOrder[i]['order']['id']
                                .toString()));

                        break;
                      case Event.actionCallDecline:
                        // Get.defaultDialog(title: 'HAHAHAH MANTAP');
                        timePeriodic.value = false;
                        realtimeApiGet.value = false;
                        if (realtimeApiGet.isFalse) {
                          realtimeApi();
                        }

                        break;
                      case Event.actionCallEnded:
                        break;
                      case Event.actionCallTimeout:
                        timePeriodic.value = false;
                        realtimeApiGet.value = false;
                        if (realtimeApiGet.isFalse) {
                          realtimeApi();
                        }
                        break;
                      // case Event.ACTION_CALL_CALLBACK:
                      //   break;
                      // case Event.ACTION_CALL_TOGGLE_HOLD:
                      //   break;
                      // case Event.ACTION_CALL_TOGGLE_MUTE:
                      //   break;
                      // case Event.ACTION_CALL_TOGGLE_DMTF:
                      //   break;
                      // case Event.ACTION_CALL_TOGGLE_GROUP:
                      //   break;
                      // case Event.ACTION_CALL_TOGGLE_AUDIO_SESSION:
                      //   break;
                      // case Event.ACTION_DID_UPDATE_DEVICE_PUSH_TOKEN_VOIP:
                      //   break;
                      case Event.actionDidUpdateDevicePushTokenVoip:
                        break;
                      case Event.actionCallCallback:
                        break;
                      case Event.actionCallToggleHold:
                        break;
                      case Event.actionCallToggleMute:
                        break;
                      case Event.actionCallToggleDmtf:
                        break;
                      case Event.actionCallToggleGroup:
                        break;
                      case Event.actionCallToggleAudioSession:
                        break;
                      case Event.actionCallCustom:
                        break;
                    }
                  }));
            }
          }

          //POP UP PANGGILAN MASUK

        }
        // ignore: unrelated_type_equality_checks
        if (timePeriodic == true) {
          timer.cancel();
        }
      });
    }
  }

  @override
  void onInit() {
    Get.put(ControllerPayment());
    getLocation();

    // realtimeApi();
    // trimUpdateStatus();
    // log('zen');

    // ignore: todo
    // TODO: implement onInit
    super.onInit();
  }

  RxInt currentIndex = 0.obs;
  RxList dataNotif = [].obs;
  RxInt activeNotif = 0.obs;
  // ignore: prefer_typing_uninitialized_variables
  var dataUser;

  final formKey = GlobalKey<FormState>();

  Future<dynamic> getNotif() async {
    var value = await ApiHome().getNotif();
    if (value['code'] == 200) {
      dataNotif.value = value['data'];
      activeNotif.value =
          dataNotif.where((d) => d['status'] == 1).toList().length;
    }
  }
  RxInt idOrderFromPesan = 0.obs;
  RxList dataPesan = [].obs;
  RxInt serviceId = 0.obs;

  RxString role =''.obs;
  Future<dynamic> readNitif({required String id}) async {
    var value = await ApiHome().readNotif(id: id);
    if (value['code'] == 200) {
      idOrderFromPesan.value = value['data']['order']['id'];
      serviceId.value = value['data']["order"]['serviceId'];

      log(value.toString());

    }
  }

  Future<dynamic> readNotifNurse({required String id}) async {
    final params = <String, dynamic>{};
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}inbox/nurse/read/$id',
          Method.POST,
          params);
      final readNotif = json.decode(result.toString());
      log("readNotif['data'] . $readNotif");
      idOrderFromPesan.value = readNotif['data']['nurse_order']['id'];
      serviceId.value = readNotif['data']["nurse_order"]['serviceId'];


      log('Masuk == $serviceId');
    } on Exception catch (e) {
      // ignore: avoid_print
      print("Error nih == $e");
    }
  }

  
}

Future<dynamic> reminder(BuildContext context) {
  return showModalBottomSheet(
      isDismissible: false,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      context: context,
      builder: (context) {
        return SizedBox(
            height: 350,
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
                          'Peringatan!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Image.asset('assets/icons/icon_reminder.png'),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const SizedBox(
                          height: 14.0,
                        ),
                        const Text(
                          'Mengingat waktu untuk pesanan anda\nakan segera berlangsung 3 Jam lagi\nMohon Segera lakukan Pembayaran!',
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
                            label: "Oke",
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        )
                      ])
                ]));
      });
}

Future<dynamic> reminderLayananTelemedicine(BuildContext context) {
  return showModalBottomSheet(
      isDismissible: false,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      context: context,
      builder: (context) {
        return SizedBox(
            height: 350,
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
                          'Peringatan!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Image.asset('assets/icons/icon_reminder.png'),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const SizedBox(
                          height: 14.0,
                        ),
                        const Text(
                          'Mengingat waktu untuk pesanan\nakan berlangsung 5 Menit lagi',
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
                            label: "Oke",
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        )
                      ])
                ]));
      });
}
