import 'dart:async';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bionmed_app/constant/utils.dart';
import 'package:bionmed_app/screens/home/home_controller.dart';
import 'package:bionmed_app/screens/pesanan/controller_pesanan.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:bionmed_app/widgets/other/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';

import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallScreen extends StatefulWidget {
  final String userid;
  final String userName;
  final String callId;
  // ignore: prefer_typing_uninitialized_variables
  final data;

  const CallScreen(
      {Key? key,
      required this.userid,
      required this.userName,
      required this.callId,
      this.data})
      : super(key: key);
  static const routeName = "/call";

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  bool isDuration = false;
  bool stop = false;
  bool isWaitingDoctor = false;
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
          // Get.to(() => Home(
          //       indexPage: 2,
          //     ));
          await Get.find<ControllerPesanan>().updateStatus(
              status: 6,
              data: widget.data,
              idOrder: widget.data['order']['id'].toString(),
              context: context);
          myC.isStart.value = false;

          Get.back();
          Get.back();
          Get.back();
        });
  }

  String title = "call";
  // int endTime = DateTime.now().millisecondsSinceEpoch + 8000 * 38;
  // late CountdownTimerController controller =
  //     CountdownTimerController(endTime: endTime, onEnd: onEnd);

  @override
  void dispose() {
    //perhatikan ini
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
    myC.isStart.value = false;

    super.dispose();
  }

  // void onEnd() {
  //   setState(() {
  //     isDuration = true;
  //   });
  //   showPopUp(
  //       description: "waktu layanan anda sudah habis",
  //       dismissible: false,
  //       onPress: () {
  //         Get.back();
  //         controller.dispose();
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
                  await ZegoUIKit.instance.leaveRoom();

                  if (widget.data != null) {
                    Get.find<ControllerPesanan>().updateStatus(
                        status: 6,
                        data: widget.data,
                        idOrder: widget.data['order']['id'].toString(),
                        context: context);
                  }
                  myC.isStart.value = false;

                  Get.back();
                  Get.back();
                  Get.back();

                  // Get.offAll(() => const Home(
                  //       indexPage: 1,
                  //     ));
                },
                //return true when click on "Yes"
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
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
                });
          } else {
            setState(() {
              _start--;
            });
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: showExitPopup,
          child: Stack(
            children: [
              // ZegoUIKitPrebuiltCallWithInvitation(appID:  Utils().getAppId,
              // appSign: Utils()
              //       .getAppSign,
              // userID: widget.userid,
              // userName: widget.userName,
              // child: Container(),
              // plugins: [ZegoUIKitSignalingPlugin()
              // ]),
              ZegoUIKitPrebuiltCall(
                appID: Utils()
                    .getAppId, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
                appSign: Utils()
                    .getAppSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
                userID: widget.userid,
                userName: widget.userName,
                callID: widget.callId,
                config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
                  ..topMenuBarConfig = ZegoTopMenuBarConfig(isVisible: false)
                  ..turnOnCameraWhenJoining = true
                  ..turnOnMicrophoneWhenJoining = true
                  ..audioVideoViewConfig = ZegoPrebuiltAudioVideoViewConfig(
                    backgroundBuilder: (BuildContext context, Size size,
                        ZegoUIKitUser? user, Map extraInfo) {
                      return user != null
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 120,
                                height: 50,
                                decoration: BoxDecoration(
                                    // color: AppColor.bodyColor.shade400,
                                    borderRadius: BorderRadius.circular(8)),
                                // child: Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Row(
                                //     children: [
                                //       const Icon(
                                //         Icons.circle,
                                //         color: AppColor.redColor,
                                //       ),
                                //       horizontalSpace(10),
                                //       CountdownTimer(
                                //         controller: controller,
                                //         onEnd: onEnd,
                                //         endTime: endTime,
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ),
                            )
                          : const SizedBox();
                    },
                  )
                  ..layout = ZegoLayout.pictureInPicture(
                    isSmallViewDraggable: true,
                    switchLargeOrSmallViewByClick: true,
                  ),
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
                            : Row(
                                children: [
                                  Container(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                  ),
                                  // Container(
                                  //   alignment: Alignment.center,
                                  //   height: 100,
                                  //   padding: EdgeInsets.all(10),
                                  //   margin: const EdgeInsets.all(10),
                                  //   // ignore: prefer_const_constructors
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: const BorderRadius.all(
                                  //       Radius.circular(12.0),
                                  //     ),
                                  //   ),
                                  //   child: CountdownTimer(
                                  //     widgetBuilder: (context, time1) {
                                  //       if (time1!.min == 5 &&
                                  //               time1.sec == 00 ||
                                  //           time1.min == 4 && time1.sec == 59 ||
                                  //           time1.min == 4 && time1.sec == 58 ||
                                  //           time1.min == 4 && time1.sec == 57 ||
                                  //           time1.min == 4 && time1.sec == 56 ||
                                  //           time1.min == 4 && time1.sec == 55 ||
                                  //           time1.min == 4 && time1.sec == 54 ||
                                  //           time1.min == 4 && time1.sec == 53 ||
                                  //           time1.min == 4 && time1.sec == 52 ||
                                  //           time1.min == 4 && time1.sec == 51 ||
                                  //           time1.min == 4 && time1.sec == 50) {
                                  //         return Container(
                                  //             alignment: Alignment.center,
                                  //             padding: EdgeInsets.all(10),
                                  //             // margin: const EdgeInsets.all(10),
                                  //             // ignore: prefer_const_constructors
                                  //             decoration: BoxDecoration(
                                  //               gradient: AppColor.gradient1,
                                  //               borderRadius:
                                  //                   const BorderRadius.all(
                                  //                 Radius.circular(12.0),
                                  //               ),
                                  //             ),
                                  //             child: Text(
                                  //               'Waktu Layanan Anda\nTersisa 5 Menit lagi',
                                  //               style: TextStyle(
                                  //                   color: Colors.white,
                                  //                   fontSize: 15,
                                  //                   fontWeight: FontWeight.w600
                                  //                   // fontWeight: FontWeight.w500,
                                  //                   ),
                                  //               textAlign: TextAlign.center,
                                  //             ));
                                  //       }
                                  //       return const SizedBox(
                                  //         height: 1.0,
                                  //       );
                                  //     },
                                  //     endWidget: const Text('Waktu Habis'),
                                  //     controller: controller,
                                  //     endTime: endTime,
                                  //   ),
                                  // ),
                                ],
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
              // Obx(
              //   () => Visibility(
              //     visible: endTime != 0,
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Container(
              //           height: 50,
              //           width: 150,
              //           decoration: BoxDecoration(
              //               color: AppColor.bodyColor.shade400,
              //               borderRadius: BorderRadius.circular(8)),
              //           child: Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: myC.updateStatusChat.value == 2
              //                 ? endTime == 0
              //                     ? const SizedBox(
              //                         height: 1.0,
              //                       )
              //                     : Container(
              //                         alignment: Alignment.center,
              //                         height: 50,
              //                         width: 160,
              //                         child: Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.center,
              //                           children: [
              //                             Icon(
              //                               Icons.timer,
              //                               color: Colors.red,
              //                             ),
              //                             const SizedBox(
              //                               width: 10.0,
              //                             ),
              //                             CountdownTimer(
              //                               endWidget: Text('Waktu Habis'),
              //                               controller: controller,
              //                               onEnd: onEnd,
              //                               endTime: endTime,
              //                             ),
              //                           ],
              //                         ),
              //                       )
              //                 : const SizedBox(
              //                     height: 1.0,
              //                   ),
              //           )),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
