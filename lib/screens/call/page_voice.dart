import 'dart:async';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bionmed_app/constant/utils.dart';
import 'package:bionmed_app/screens/home/home_controller.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';

import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../widgets/other/show_dialog.dart';
import '../pesanan/controller_pesanan.dart';

class VoiceScreen extends StatefulWidget {
  final String userid;
  final String userName;
  final String callId;
  // ignore: prefer_typing_uninitialized_variables
  final data;

  const VoiceScreen(
      {Key? key,
      required this.userid,
      required this.userName,
      required this.callId,
      this.data})
      : super(key: key);
  static const routeName = "/call";

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen> {
  String title = "voice_call";
  bool isDuration = false;
  bool stop = false;
  int endTime = 0;
  CountdownTimerController? controller;
  @override
  void initState() {
    myC.getOrderChat();
    realtimeState();
    startTimer();
    updateIsStart();
    Get.find<HomeController>().timePeriodic.value = true;

    super.initState();
  }

  void updateIsStart() {
    myC.updateStatusTimer(
        statusOrder: myC.updateStatusChat.value + 1,
        statusPayment: myC.updateStatusPayment.value + 1);
  }

//--------------Waiting Response--------------
  int _start = 60;
  bool stopWaiting = false;
  // ignore: unused_field
  Timer? _timer;

  void startTimer() {
    if (stopWaiting == false) {
      const oneSec = Duration(seconds: 1);
      _timer = Timer.periodic(
        oneSec,
        (Timer timer) {
          if (myC.updateStatusChat.value == 2) {
            setState(() {
              timer.cancel();
            });
          } else if (_start == 0) {
            setState(() {
              timer.cancel();
            });
            showPopUp(
                onTap: () {
                  setState(() {
                    isWaitingDoctor = true;
                  });
                },
                // color: Colors.white,
                //   onTap: () {
                //     // Get.back();
                //   },
                description: "Tidak ada respon dari Dokter\nUbah jadwal!",
                dismissible: false,
                onPress: () {
                  setState(() {
                    isWaitingDoctor = true;
                  });
                  // await ZegoUIKit.instance.leaveRoom();
                  myC.updateStatusTimer(
                      statusPayment: myC.updateStatusPayment.value + 3,
                      statusOrder: myC.updateStatusChat.value + 1);
                  stopTime();
                  // Get.to(() => BottonNavigationView());
                  Get.back();
                  Get.back();
                  Get.back();
                }

                // onTap: () {},
                // // color: Colors.white,
                // //   onTap: () {
                // //     // Get.back();
                // //   },
                // description: "Tidak ada respon dari Dokter\nUbah jadwal!",
                // dismissible: false,
                // onPress: () async {
                //   await ZegoUIKit.instance.leaveRoom();
                //   myC.updateStatusTimer(
                //            statusPayment: myC.updateStatusPayment + 3,
                //             statusOrder: myC.updateStatusChat + 1);
                //   stopTime();
                //   // Get.to(() => BottonNavigationView());
                //   Get.back();
                //   Get.back();
                //   Get.back();
                //   Get.find<ControllerPesanan>().updateStatus(
                //       data: widget.data,
                //       status: 99,
                //       idOrder: myC.idOrder.value.toString(),
                //       context: context);
                // }
                );
          } else {
            setState(() {
              _start--;
            });
          }
        },
      );
    }
  }

  void startTime(bool start) {
    if (start == true && endTime == 0) {
      setState(() {
        endTime = DateTime.now().millisecondsSinceEpoch +
            (1600 * Get.find<ControllerPesanan>().orderMinute.value)
                // 500
                *
                38;
        controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
      });
    }
  }
  int timeReminder = Get.find<ControllerPesanan>().orderMinute.value * 60 + 5;

  reminder(BuildContext context) {
    return showModalBottomSheet(
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return SizedBox(
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
                            'Peringatan!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Image.asset('assets/icons/icon5.png'),
                          const SizedBox(
                            height: 20.0,
                          ),
                          const SizedBox(
                            height: 14.0,
                          ),
                          const Text(
                            'Waktu layanan anda tersisa',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text(
                            '05.00 Menit',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            textAlign: TextAlign.center,
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

  void realtimeState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (myC.stop == false) {
        myC.getOrderChat();
      }

      if (myC.stop == false && myC.updateStatusChat.value == 2) {
        startTime(true);
        setState(() {
          timeReminder--;
        });
        if (timeReminder == 300) {
          reminder(context);
        }
        // timer.cancel();
      } else {}
    });
  }

  stopTime() {
    stop = true;
  }

  final myC = Get.put(ControllerPesanan());

  void onEnd() {
    setState(() {
      isDuration = true;
    });
    showPopUp(
        onTap: () {},
        description: "Waktu layanan anda sudah habis",
        dismissible: false,
        onPress: () async {
          await ZegoUIKit.instance.leaveRoom();
          myC.stopTime();
        myC.isStart.value = false;

          Get.back();
          Get.back();
          Get.back();
          // Get.to(() => Home(
          //       indexPage: 2,
          //     ));
          Get.find<ControllerPesanan>().updateStatus(
              status: 6,
              data: widget.data,
              idOrder: widget.data['order']['id'].toString(),
              context: context);
        });
  }

  // int endTime = DateTime.now().millisecondsSinceEpoch + 8000 * 38;
  // late CountdownTimerController controller =
  //     CountdownTimerController(endTime: endTime, onEnd: onEnd);

  // void onEnd() {
  //   setState(() {
  //     isDuration = true;
  //   });
  //   showPopUp(
  //       description: "waktu layanan anda sudah habis",
  //       dismissible: false,
  //       onPress: () {
  //         Get.back();
  //         if (widget.data != null) {
  //           Get.find<ControllerPesanan>().updateStatus(
  //               status: 5,
  //               data: widget.data,
  //               idOrder: widget.data['order']['id'].toString(),
  //               context: context);
  //         }
  //         Get.offAll(() => const Home(
  //               indexPage: 1,
  //             ));
  //       });
  // }
  bool isWaitingDoctor = false;

  @override
  void dispose() {
      log("xxxxxx :$isWaitingDoctor");
      if (isWaitingDoctor == false) {
        Get.find<ControllerPesanan>().updateStatus(
            status: 6,
            data: widget.data,
            idOrder: widget.data['order']['id'].toString(),
            context: context);
      } else {
        Get.find<ControllerPesanan>().updateStatus(
            data: widget.data,
            status: 99,
            idOrder: widget.data['order']['id'].toString(),
            context: context);
      
    }
      Get.find<HomeController>().timePeriodic.value = false;
        Get.find<HomeController>().realtimeApiGet.value = false;
        if (Get.find<HomeController>().realtimeApiGet.isFalse) {
          Get.find<HomeController>().realtimeApi();
        }
    Get.find<ControllerPesanan>().getOrderAll(status: 0);
        myC.isStart.value = false;


    // if (widget.data != null) {
    //   Get.find<ControllerPesanan>().updateStatus(
    //       status: 6,
    //       data: widget.data,
    //       idOrder: widget.data['order']['id'].toString(),
    //       context: context);
    // }
    super.dispose();
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit Service ?'),
            content: const Text('Do you want to exit an Service?'),
            actions: [
              ElevatedButton(
                onPressed: () => Get.back(),
                //return false when click on "NO"
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // controller.dispose();
                  // if (widget.data != null) {
                  // }

                  await ZegoUIKit.instance.leaveRoom();
                  Get.find<ControllerPesanan>().updateStatus(
                      status: 6,
                      data: widget.data,
                      idOrder: widget.data['order']['id'].toString(),
                      context: context);
                  // Get.offAll(() => const Home(
                  //       indexPage: 1,
                  //     ));
                  Get.back();
                  Get.back();
                  Get.back();
                },
                //return true when click on "Yes"
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: WillPopScope(
        onWillPop: showExitPopup,
        child: Stack(children: [
          ZegoUIKitPrebuiltCall(
            appID: Utils()
                .getAppId, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
            appSign: Utils()
                .getAppSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
            userID: widget.userid,
            userName: widget.userName,
            callID: widget.callId,

            // Modify your custom configurations here.
            config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()
              ..bottomMenuBarConfig
              ..audioVideoViewConfig = ZegoPrebuiltAudioVideoViewConfig(),
          ),
          Obx(
            () =>
                // Visibility(
                //   visible: endTime != 0,
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Container(
                //         height: 50,
                //         width: 150,
                //         decoration: BoxDecoration(
                //             color: AppColor.bodyColor.shade400,
                //             borderRadius: BorderRadius.circular(8)),
                //         child: Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child:
                myC.updateStatusChat.value == 2
                    ? endTime == 0
                        ? const SizedBox(
                            height: 1.0,
                          )
                        : Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 160,
                            margin: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.timer,
                                  color: Colors.red,
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                CountdownTimer(
                                  endWidget: const Text('Waktu Habis'),
                                  controller: controller,
                                  onEnd: onEnd,
                                  endTime: endTime,
                                ),
                              ],
                            ),
                          )
                    : myC.updateStatusChat.value == 1
                        ? Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                            ),
                            height: 50,
                            width: 160,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.timer,
                                  color: Colors.red,
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                SizedBox(
                                  width: 100,
                                  child: AutoSizeText(
                                      maxLines: 2,
                                      _start >= 10
                                          ? "Menunggu Dokter 00:$_start"
                                          : "Menunggu Dokter 00:0$_start",
                                      style: const TextStyle(fontSize: 12)),
                                )
                              ],
                            ),
                          )
                        : const SizedBox(
                            height: 1.0,
                          ),
          ),
        ]),
      ),
    ));
  }
}
