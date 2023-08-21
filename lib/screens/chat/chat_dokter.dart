import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bionmed_app/screens/home/home.dart';
import 'package:bionmed_app/screens/home/home_controller.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:bionmed_app/widgets/container/container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';

import 'package:zego_zimkit/zego_zimkit.dart';

import '../../widgets/other/show_dialog.dart';
import '../pesanan/controller_pesanan.dart';

extension ZIMKitDefaultDialogService on ZIMKit {
  void showDefaultNewPeerChatDialogChat(BuildContext context, String userId) {
    // ignore: prefer_typing_uninitialized_variables
    var data;

    final userIDController = TextEditingController(text: userId);
    // ignore: unused_local_variable
    final myC = Get.put(ControllerPesanan());

    Timer.run(() {
      showDialog<bool>(
        useRootNavigator: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text('Apakah anda ingin mulai sekarang ?'),
              // content: TextField(
              //   controller: userIDController,
              //   keyboardType: TextInputType.text,
              //   enabled: true,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: 'User ID',
              //   ),
              // ),
              actions: [
                TextButton(
                  onPressed: () {
                    myC.isStart.value = false;
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    myC.isStart.value = false;
                    // myC.updateStatusTimer(
                    //     statusPayment: myC.updateStatusPayment.value + 1,
                    //     statusOrder: myC.updateStatusChat.value + 1);
                    Navigator.of(context).pop(true);
                    Get.find<ControllerPesanan>().updateStatus(
                        status: 4,
                        data: data,
                        idOrder:
                            Get.find<ControllerPesanan>().orderId.toString(),
                        context: context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
        },
      ).then((ok) {
        if (ok != true) return;
        if (userIDController.text.isNotEmpty) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ZIMKitMessageListPageChat(
              conversationID: userIDController.text,
            );
          }));
        }
      });
    });
  }

  void showDefaultNewGroupChatDialog(BuildContext context) {
    final groupIDController = TextEditingController();
    final groupNameController = TextEditingController();
    final groupUsersController = TextEditingController();
    Timer.run(() {
      showDialog<bool>(
        useRootNavigator: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text('New Group'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: groupNameController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Group Name',
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: groupIDController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'ID(optional)',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    maxLines: 3,
                    controller: groupUsersController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Invite User IDs',
                      hintText: 'separate by comma, e.g. 123,987,229',
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
        },
      ).then((bool? ok) {
        if (ok != true) return;
        if (groupNameController.text.isNotEmpty &&
            groupUsersController.text.isNotEmpty) {
          ZIMKit()
              .createGroup(
            groupNameController.text,
            groupUsersController.text.split(','),
            id: groupIDController.text,
          )
              .then((String? conversationID) {
            if (conversationID != null) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ZIMKitMessageListPage(
                  conversationID: conversationID,
                  conversationType: ZIMConversationType.group,
                );
              }));
            }
          });
        }
      });
    });
  }

  void showDefaultJoinGroupDialog(BuildContext context) {
    final groupIDController = TextEditingController();
    Timer.run(() {
      showDialog<bool>(
        useRootNavigator: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text('Join Group'),
              content: TextField(
                controller: groupIDController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Group ID',
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
        },
      ).then((bool? ok) {
        if (ok != true) return;
        if (groupIDController.text.isNotEmpty) {
          ZIMKit().joinGroup(groupIDController.text).then((int errorCode) {
            if (errorCode == 0) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ZIMKitMessageListPageChat(
                  conversationID: groupIDController.text,
                  conversationType: ZIMConversationType.group,
                );
              }));
            }
          });
        }
      });
    });
  }
}

//CHAT PAGE
class ZIMKitMessageListPageChat extends StatefulWidget {
  const ZIMKitMessageListPageChat({
    Key? key,
    required this.conversationID,
    this.conversationType = ZIMConversationType.peer,
    this.appBarBuilder,
    this.appBarActions,
    this.messageInputActions,
    this.onMessageSent,
    this.preMessageSending,
    this.inputDecoration,
    this.showPickFileButton = true,
    this.editingController,
    this.messageListScrollController,
    this.onMessageItemPressd,
    this.onMessageItemLongPress,
    this.messageItemBuilder,
    this.messageListErrorBuilder,
    this.messageListLoadingBuilder,
    this.theme,
  }) : super(key: key);

  /// this page's conversationID
  final String conversationID;

  /// this page's conversationType
  final ZIMConversationType conversationType;

  /// if you just want add some actions to the appBar, use [appBarActions].
  ///
  /// use it like this:
  /// appBarActions:[
  ///   IconButton(icon: const Icon(Icons.local_phone), onPressed: () {}),
  ///   IconButton(icon: const Icon(Icons.videocam), onPressed: () {}),
  /// ],
  final List<Widget>? appBarActions;

  // if you want customize the appBar, use appBarBuilder return your custom appBar
  // if you don't want use appBar, return null
  final AppBar? Function(BuildContext context, AppBar defaultAppBar)?
      appBarBuilder;

  /// To add your own action, use the [messageInputActions] parameter like this:
  ///
  /// use [messageInputActions] like this to add your custom actions:
  ///
  /// actions: [
  ///   ZIMKitMessageInputAction.left(
  ///     IconButton(icon: Icon(Icons.mic), onPressed: () {})
  ///   ),
  ///   ZIMKitMessageInputAction.leftInside(
  ///     IconButton(icon: Icon(Icons.sentiment_satisfied_alt_outlined), onPressed: () {})
  ///   ),
  ///   ZIMKitMessageInputAction.rightInside(
  ///     IconButton(icon: Icon(Icons.cabin), onPressed: () {})
  ///   ),
  ///   ZIMKitMessageInputAction.right(
  ///     IconButton(icon: Icon(Icons.sd), onPressed: () {})
  ///   ),
  /// ],
  final List<ZIMKitMessageInputAction>? messageInputActions;

  /// Called when a message is sent.
  final void Function(ZIMKitMessage)? onMessageSent;

  /// Called before a message is sent.
  final FutureOr<ZIMKitMessage> Function(ZIMKitMessage)? preMessageSending;

  /// By default, [ZIMKitMessageInput] will show a button to pick file.
  /// If you don't want to show this button, set [showPickFileButton] to false.
  final bool showPickFileButton;

  /// The TextField's decoration.
  final InputDecoration? inputDecoration;

  /// The [TextEditingController] to use.
  /// if not provided, a default one will be created.
  final TextEditingController? editingController;

  /// The [ScrollController] to use.
  /// if not provided, a default one will be created.
  final ScrollController? messageListScrollController;

  final void Function(
          BuildContext context, ZIMKitMessage message, Function defaultAction)?
      onMessageItemPressd;
  final void Function(
          BuildContext context, ZIMKitMessage message, Function defaultAction)?
      onMessageItemLongPress;
  final Widget Function(
          BuildContext context, ZIMKitMessage message, Widget defaultWidget)?
      messageItemBuilder;
  final Widget Function(BuildContext context, Widget defaultWidget)?
      messageListErrorBuilder;
  final Widget Function(BuildContext context, Widget defaultWidget)?
      messageListLoadingBuilder;

  // theme
  final ThemeData? theme;

  @override
  State<ZIMKitMessageListPageChat> createState() =>
      _ZIMKitMessageListPageChatState();
}

class _ZIMKitMessageListPageChatState extends State<ZIMKitMessageListPageChat> {
  //TIMER CHAT
  // ignore: prefer_typing_uninitialized_variables
  var data;
  bool isDuration = false;
  bool stop = false;
  final myC = Get.put(ControllerPesanan());
  int endTime = 0;
  bool stopWaiting = false;
  CountdownTimerController? controller;
  @override
  void initState() {
    super.initState();
    realtimeState();
    startTimer();
    updateIsStart();
    Get.find<HomeController>().timePeriodic.value = true;
    myC.getOrderChat();
  }

  void updateIsStart() {
    myC.updateStatusTimer(
        statusPayment: myC.updateStatusPayment.value + 1,
        statusOrder: myC.updateStatusChat.value + 1);
  }

  // ignore: unused_field
  Timer? _timer;
  int _start = 60;
  void startWaiting() {
    if (myC.updateStatusChat.value == 1) {
      startTimer();
    } else {
      stopWaitingF();
    }
  }

  stopWaitingF() {
    stopWaiting = true;
  }

  bool isWaitingDoctor = false;

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
                  Get.find<ControllerPesanan>().updateStatus(
                      data: data,
                      status: 99,
                      idOrder: myC.idOrder.value.toString(),
                      context: context);
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
                //   await ZIM.getInstance()!.deleteAllMessage(
                //       widget.conversationID,
                //       ZIMConversationType.peer,
                //       ZIMMessageDeleteConfig());
                //   stopTime();
                //   // Get.to(() => BottonNavigationView());
                //   Get.back();
                //   Get.back();
                //   Get.back();
                //   Get.find<ControllerPesanan>().updateStatus(
                //       data: data,
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
            (1600 * Get.find<ControllerPesanan>().orderMinute.value) * 38;
        controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
      });
    }
    //  else {
    //   endTime = 0;
    //   controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
    // }
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
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
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
      if (stop == false) {
        myC.getOrderChat();
      }
      if (stop == false && myC.updateStatusChat.value == 2) {
        startTime(true);
        setState(() {
          timeReminder--;
        });
        if (timeReminder == 300) {
          reminder(context);
        }
        // timer.cancel();
      }
      // else {
      //   myC.getOrderChat();

      // }
    });
  }

  stopTime() {
    stop = true;
  }

  void onEnd() {
    setState(() {
      isDuration = true;
    });
    showPopUp(
        onTap: () {},
        description: "Waktu layanan anda sudah habis",
        dismissible: false,
        onPress: () async {
          await ZIM.getInstance()!.deleteAllMessage(widget.conversationID,
              ZIMConversationType.peer, ZIMMessageDeleteConfig());
          stopTime();
          // Get.to(() => const Home(
          //       indexPage: 2,
          await Get.find<ControllerPesanan>().updateStatus(
              data: data,
              status: 6,
              idOrder: myC.idOrder.value.toString(),
              context: context);
          myC.isStart.value = false;

          //     ));
          Get.back();
          Get.back();
          Get.back();
        });
  }

  @override
  void dispose() {
    log("xxxxxx :$isWaitingDoctor");
    if (isWaitingDoctor == false) {
      Get.find<ControllerPesanan>().updateStatus(
          status: 6,
          data: data,
          idOrder: myC.idOrder.value.toString(),
          context: context);
    } else {
      Get.find<ControllerPesanan>().updateStatus(
          data: data,
          status: 99,
          idOrder: myC.idOrder.value.toString(),
          context: context);
    }
    Get.find<HomeController>().timePeriodic.value = false;
    Get.find<HomeController>().realtimeApiGet.value = false;
    if (Get.find<HomeController>().realtimeApiGet.isFalse) {
      Get.find<HomeController>().realtimeApi();
    }
    ZIM.getInstance()!.deleteAllMessage(widget.conversationID,
        ZIMConversationType.peer, ZIMMessageDeleteConfig());
    myC.isStart.value = false;

    controller?.dispose();

    // ignore: todo
    // TODO: implement dispose
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
                  await ZIM.getInstance()!.deleteAllMessage(
                      widget.conversationID,
                      ZIMConversationType.peer,
                      ZIMMessageDeleteConfig());
                  await Get.find<ControllerPesanan>().updateStatus(
                      data: data,
                      status: 6,
                      idOrder: myC.idOrder.value.toString(),
                      context: context);
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

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: widget.theme ?? Theme.of(context),
        child: Scaffold(
            appBar: widget.appBarBuilder != null
                ? widget.appBarBuilder!.call(context, buildAppBar(context))
                : buildAppBar(context),
            body: WillPopScope(
              onWillPop: showExitPopup,
              child: Stack(children: [
                Column(
                  children: [
                    ZIMKitMessageListView(
                      key: ValueKey('ZIMKitMessageListView:${Object.hash(
                        widget.conversationID,
                        widget.conversationType,
                      )}'),
                      conversationID: widget.conversationID,
                      conversationType: widget.conversationType,
                      onPressed: (context, message, defaultAction) {
                        // if (message.data.value.type == ZIMMessageType.image) {
                        //   // ZIMKitMessage
                        //   // Navigator.push(
                        //   //   context,
                        //   //   MaterialPageRoute(
                        //   //     builder: (context) => FullScreenImagePreview(
                        //   //         files: File(message.data.value.tostr())),
                        //   //   ),
                        //   // );
                          
                        // // ignore: avoid_print
                        // // print('siap + ${message.zim.extendedData}');
                        // }
                      },
                      itemBuilder: widget.messageItemBuilder,
                      // onLongPress: widget.onMessageItemLongPress,
                      loadingBuilder: widget.messageListLoadingBuilder,
                      errorBuilder: widget.messageListErrorBuilder,
                      scrollController: widget.messageListScrollController,
                      theme: widget.theme,
                    ),
                    ZIMKitMessageInput(
                      key: ValueKey('ZIMKitMessageInput:${Object.hash(
                        widget.conversationID,
                        widget.conversationType,
                      )}'),
                      conversationID: widget.conversationID,
                      conversationType: widget.conversationType,
                      actions: widget.messageInputActions,
                      onMessageSent: widget.onMessageSent,
                      preMessageSending: widget.preMessageSending,
                      inputDecoration: widget.inputDecoration,
                      showPickFileButton: widget.showPickFileButton,
                      editingController: widget.editingController,
                      theme: widget.theme,
                    ),
                  ],
                ),

                // floatingActionButtonLocation:
                //     FloatingActionButtonLocation.miniStartDocked,
                // floatingActionButton: DraggableFab(
                //   child: Container(
                //     width: 100,
                //     height: 50,
                //     child: FloatingActionButton(
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(10)),
                //       onPressed: () {},
                //       child: CountdownTimer(
                //         controller: controller,
                //         onEnd: onEnd,
                //         endTime: endTime,
                //       ),
                //     ),
                //   ),
                // ),
                // Container(
                //   width: 100,
                //   height: 50,
                //   child: FloatingActionButton(
                //     shape:
                //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                //     onPressed: () {},
                //     child: CountdownTimer(
                //       controller: controller,
                //       onEnd: onEnd,
                //       endTime: endTime,
                //     ),
                //   ),
                // ),
              ]),
            )));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: Row(
              children: [
                  Cntr(
                  radius: BorderRadius.circular(100),
                  height: 40, width: 40, image: DecorationImage(image: NetworkImage(Get.find<ControllerPesanan>().imageDoctor.value))),
                const SizedBox(
                width: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => SizedBox(
                          width: 130,
                          child: Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              Get.find<ControllerPesanan>().nameDoctor.value,
                              style: const TextStyle(fontSize: 16)),
                        )),
                    // Text("", style: const TextStyle(fontSize: 12))
                    Obx(() {
                      return myC.updateStatusChat.value == 2
                          ? endTime == 0
                              ? const SizedBox(
                                  height: 1.0,
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  // color: Colors.amber,
                                  // width: 100,
                                  padding: const EdgeInsets.all(5),
                                  child: CountdownTimer(
                                    textStyle: const TextStyle(fontSize: 12),
                                    endWidget: const Text(
                                      'Waktu Habis',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    controller: controller,
                                    onEnd: onEnd,
                                    endTime: endTime,
                                  ),
                                )
                          : myC.updateStatusChat.value != 1
                              ? const Text(
                                  'Dokter mengakhiri chat',
                                  style: TextStyle(fontSize: 12),
                                )
                              : myC.updateStatusChat.value == 1
                                  ? Text(
                                      _start >= 10
                                          ? "Menunggu Dokter 00:$_start"
                                          : "Menunggu Dokter 00:0$_start",
                                      style: const TextStyle(fontSize: 12))
                                  : const Text('');
                    })
                  ],
                )
              ],
            ),
        actions: [
          // Obx(() => myC.updateStatusChat.value == 2
          //     ? endTime == 0
          //         ? const SizedBox(
          //             height: 1.0,
          //           )
          //         : Container(
          //             alignment: Alignment.center,
          //             height: double.infinity,
          //             width: 100,
          //             child: CountdownTimer(
          //               endWidget: Text('Waktu Habis'),
          //               controller: controller,
          //               onEnd: onEnd,
          //               endTime: endTime,
          //             ),
          //           )
          //     : SizedBox())
          Center(
            child: InkWell(
                onTap: () {
                  Get.defaultDialog(
                    title: "Akhiri Chat?",
                    middleText: '',
                    confirm: ElevatedButton(
                      onPressed: () async {
                        //  await ZIMKitCore.instance.();
                        // ZIMMessageDeleteConfig();
                        await ZIM.getInstance()!.deleteAllMessage(
                            widget.conversationID,
                            ZIMConversationType.peer,
                            ZIMMessageDeleteConfig());
                        await myC.updateStatusTimer(
                            statusPayment: myC.updateStatusPayment.value + 1,
                            statusOrder: myC.updateStatusChat.value + 1);
                        endTime = 1;
                        stopTime();
                        Get.find<ControllerPesanan>().getOrderAll(status: 0);
                        Get.offAll(() => const Home(
                              indexPage: 2,
                            ));
                        Get.find<ControllerPesanan>().updateStatus(
                            data: data,
                            status: 6,
                            idOrder: myC.idOrder.value.toString(),
                            context: context);
                        myC.isStart.value = false;
                      },
                      child: const Text('Ok'),
                    ),
                    cancel: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          // endTime = 1;
                        });
                        Get.back();
                      },
                      child: const Text('Cancel'),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Text(
                    'Akhiri Chat',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
          )
        ]);
  }
}

class FullScreenImagePreview extends StatelessWidget {
  final File files;

  const FullScreenImagePreview({super.key, required this.files});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Image.file(files),
    );
  }
}
