import 'dart:async';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bionmed_app/constant/helper.dart';
import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/screens/call/page_voice.dart';
import 'package:bionmed_app/screens/chat/chat_dokter.dart';
import 'package:bionmed_app/screens/home/home_controller.dart';
import 'package:bionmed_app/screens/login/controller_login.dart';
import 'package:bionmed_app/screens/payment/controller_payment.dart';
import 'package:bionmed_app/screens/payment/metode_pembayaran_screen.dart';
import 'package:bionmed_app/screens/pesanan/api_pesanan.dart';
import 'package:bionmed_app/screens/pesanan/controller_pesanan.dart';
import 'package:bionmed_app/screens/pesanan/lihat_resep.dart';
import 'package:bionmed_app/screens/pilih_jadwal/controllers/pilih_jadwal_controller.dart';
import 'package:bionmed_app/screens/pilih_jadwal/views/atur_ulang_jadwal.dart';
import 'package:bionmed_app/screens/pilih_jadwal/views/atur_ulang_jadwal_nurse.dart';
import 'package:bionmed_app/screens/profile_doctor/detail_dokter_in_order.dart';
import 'package:bionmed_app/screens/videoCall/page_call.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:bionmed_app/widgets/button/button_primary.dart';
import 'package:bionmed_app/widgets/card/card_select_service.dart';
import 'package:bionmed_app/widgets/container/container.dart';
import 'package:bionmed_app/widgets/other/loading_indicator.dart';
import 'package:bionmed_app/widgets/other/show_dialog.dart';
import 'package:bionmed_app/widgets/txt/text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import '../../constant/colors.dart';
import '../layanan_nurse_home/controller/input_layanan_controller.dart';

class PesananDetailScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  const PesananDetailScreen({
    Key? key,
    this.data,
  }) : super(key: key);
  static const routeName = "/pesanan_status_screen";

  @override
  State<PesananDetailScreen> createState() => _PesananDetailScreenState();
}

class _PesananDetailScreenState extends State<PesananDetailScreen>
    with SingleTickerProviderStateMixin {
  String title = "Detail Order";
  bool isloading = false;
  bool stop = false;
  int timer = 10;
  // ignore: unused_field
  Timer? _timer;
  int _start = 15;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            isloading = false;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  Widget buildTimePicker() {
    return SizedBox(
      height: MediaQuery.of(context).copyWith().size.height / 3,
      child: CupertinoDatePicker(
        initialDateTime: DateTime.now(),
        onDateTimeChanged: (DateTime newdate) {
          String dates = DateFormat("HH:mm:ss", "id_ID").format(newdate);
          Get.find<ControllerPesanan>().times.value = dates.toString();
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

  Timer? timer1;

  final pilihC = Get.put(PilihJadwalController());

  datePicker1() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      // ignore: avoid_print
      print("CEEEKK $pickedDate");
      pilihC.day.value = DateFormat('EEEE', "id").format(pickedDate);
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      String starDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      Get.find<PilihJadwalController>().startDate.value = starDate;

      // ignore: avoid_print
      print("uwu${pilihC.day.value}");

      myC.dates.value = formattedDate;
    } else {
      // ignore: avoid_print
      print("Date is not selected");
    }
  }

  String role = '';

  @override
  void initState() {
    if (Get.put(HomeController()).serviceId.value != 0) {
      role = Get.put(HomeController()).role.value;
      log('Masuuuukk sinin $role');
      Get.put(HomeController()).serviceId.value = 0;
    } else {
      role = widget.data['user'] == null ? '' : widget.data['user']['role'];
      log('Masuuuukk ternyata');
    }
    if (stop == false) {
      Timer.periodic(const Duration(seconds: 1), (time) {
        if (stop == false) {
          if (role == 'nurse') {
            // Get.find<ControllerPesanan>().getDetailOrderNurse();
          } else {
            // Get.find<ControllerPesanan>().getOrderChat();
          }
        } else {
          time.cancel();
        }
      });
    } else {}

    super.initState();
  }

  @override
  void dispose() {
    stop = true;
    super.dispose();
  }

  // void whatsapp(String phone, String massage) async {
  //   var contact = phone;
  //   var androidUrl =
  //       "whatsapp://send?phone=$contact&text=${Uri.parse(massage)}";
  //   var iosUrl = "https://wa.me/$contact?text=${Uri.parse(massage)}";

  //   try {
  //     if (Platform.isIOS) {
  //       await launchUrl(Uri.parse(iosUrl));
  //     } else {
  //       await launchUrl(Uri.parse(androidUrl));
  //     }
  //   } on Exception {
  //     EasyLoading.showError('WhatsApp is not installed.');
  //   }
  // }

  void actionButton() async {
    final myC = Get.put(ControllerPesanan());
    await ZIMKit()
        .connectUser(id: widget.data['order']['customer']['userId'].toString());
    if (myC.statusOrderDetail.value == 3 || myC.statusOrderDetail.value == 4) {
      await Get.find<ControllerPesanan>().getOrderChat();

      if (widget.data['order']['service_price']['name'] ==
          'Layanan Video Call') {
        Get.find<ControllerPesanan>().updateStatus(
            status: 4,
            data: widget.data,
            idOrder: widget.data['order']['id'].toString(),
            context: context);
        // actionButtonVcall(true);

        await Get.find<ControllerPesanan>().getOrderChat();
        // myC.updateStatusTimer(
        //     statusOrder: myC.updateStatusChat.value + 1,
        //     statusPayment: myC.updateStatusPayment.value + 1);
        Get.to(() => CallScreen(
            userid: widget.data['order']['customer']['userId'].toString(),
            userName: widget.data['order']['customer']['name'],
            data: widget.data,
            callId: widget.data['order']['id'].toString()));
      }
      if (widget.data['order']['service_price']['name'] ==
          'Layanan Telephone') {
        Get.find<ControllerPesanan>().updateStatus(
            status: 4,
            data: widget.data,
            idOrder: widget.data['order']['id'].toString(),
            context: context);
        await Get.find<ControllerPesanan>().getOrderChat();

        // myC.updateStatusTimer(
        //     statusOrder: myC.updateStatusChat.value + 1,
        //     statusPayment: myC.updateStatusPayment.value + 1);
        Get.to(() => VoiceScreen(
            data: widget.data,
            userid: widget.data['order']['customer']['userId'].toString(),
            userName: widget.data['order']['customer']['name'],
            callId: widget.data['order']['id'].toString()));
      }
      if (widget.data['order']['service_price']['name'] == 'Layanan Chat') {
        // Get.find<ControllerPesanan>().idOrder = widget.data['order']['id'];
        // print("CEK 1 2 3 " + myC.idOrder.toString());
        // ignore: use_build_context_synchronously
        ZIMKit().showDefaultNewPeerChatDialogChat(
            context, widget.data['order']['doctor']['userId'].toString());
        // myC.updateStatusTimer(statusOrder: myC.updateStatusChat! + 1);
        // print('cek status' + myC.statusOrderChat.toString());
        Get.find<ControllerPesanan>().orderId.value =
            widget.data['order']['id'];
      }
      if (widget.data['order']['service_price']['name'] == 'Home Visit') {
        // Get.back();
      } else {
        // whatsapp(widget.data['order']['doctor']['phoneNumber'],
        //     widget.data['order']['service']['name']);
      }
    }
    if (myC.statusOrderDetail.value == 6 &&
            Get.find<ControllerPesanan>().imageResep.value != "" ||
        Get.find<ControllerPesanan>().updateStatusChat.value == 7 ||
        Get.find<ControllerPesanan>().updateStatusChat.value >= 5 ||
        myC.statusOrderDetail.value == 6 &&
            widget.data['order']['service']['sequence'] == 2) {
      showPopUp(
          onTap: () {
            Get.find<ControllerPesanan>().isStart.value = false;
            Get.back();
          },
          description: "Apakah anda yakin telah selesai ?",
          onPress: () {
            Get.back();
            showDialog(
              context: context,
              barrierDismissible:
                  true, // set to false if you want to force a rating
              builder: (context) {
                return RatingDialog(
                  initialRating: 1.0,
                  // your app's name?
                  title: const Text(
                    'Rating Pesanan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // encourage your user to leave a high rating?
                  message: const Text(
                    'Ketuk bintang untuk mengatur peringkat pesamam. Tambahkan lebih banyak deskripsi di sini jika Anda mau.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                  // your app's logo?
                  image: Image.network(role == 'nurse'
                      ? widget.data['order']['nurse']['image']
                      : widget.data['order']['doctor']['image']),
                  submitButtonText: 'Kirim',
                  commentHint: 'Tetapkan petunjuk komentar khusus Anda',
                  // ignore: avoid_print
                  onCancelled: () => print('cancelled'),
                  onSubmitted: (response) {
                    Get.find<ControllerPesanan>().updateStatus(
                        status: 5,
                        data: widget.data,
                        idOrder: widget.data['order']['id'].toString(),
                        context: context);
                    Get.back();
                    // Get.find<ControllerPesanan>().updateStatus(
                    //     data: data,
                    //     status: 5,
                    //     idOrder: Get.find<ControllerPesanan>()
                    //         .idOrder
                    //         .value
                    //         .toString(),
                    //     context: context);
                    Get.back();
                    ApiPesanan().ratingDoctor(
                        rating: int.parse(response.rating.toStringAsFixed(0)),
                        descriptionRating: response.comment,
                        idOrder: widget.data['order']['id'].toString());
                    showPopUp(
                        onTap: () {
                          Get.back();
                        },
                        description:
                            "Terimakasih Atas Konfirmasi\nPenyelesaian Layanan Ini\nRating yang anda beri akan membantu\nmeningkatkan kualitas layanan kami",
                        onPress: () {
                          Get.back();
                        });
                  },
                );
              },
            );
            Get.find<ControllerPesanan>().isStart.value = false;
          });
    }
    // else{
    //   Get.defaultDialog(
    //     title: "Mohon Maaf",
    //     middleText: "Dokter Belum Mengirimkan Resep"
    //   );
    // }
  }

  void actionButtonNurse() async {
    final myC = Get.put(ControllerPesanan());
    await Get.find<ControllerPesanan>().getDetailOrderNurse();
    if (myC.statusOrderDetail.value == 6 &&
            Get.find<ControllerPesanan>().imageResep.value != "" ||
        Get.find<ControllerPesanan>().updateStatusChat.value == 7 ||
        Get.find<ControllerPesanan>().updateStatusChat.value >= 5 ||
        myC.statusOrderDetail.value == 6 &&
            widget.data['order']['service']['sequence'] == 2||
        widget.data['order']['service']['sequence'] == 4 ||
        widget.data['order']['service']['sequence'] == 5 ||
        widget.data['order']['service']['sequence'] == 6) {
      showPopUp(
          onTap: () {
            Get.find<ControllerPesanan>().isStart.value = false;
            Get.back();
          },
          description: "Apakah anda yakin telah selesai ?",
          onPress: () {
            Get.back();
            showDialog(
              context: context,
              barrierDismissible:
                  true, // set to false if you want to force a rating
              builder: (context) {
                return RatingDialog(
                  initialRating: 1.0,
                  // your app's name?
                  title: const Text(
                    'Rating Pesanan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // encourage your user to leave a high rating?
                  message: const Text(
                    'Ketuk bintang untuk mengatur peringkat pesamam. Tambahkan lebih banyak deskripsi di sini jika Anda mau.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                  // your app's logo?
                  image: Image.network(role == 'nurse'
                      ? widget.data['order']['nurse']['hospital'] != null ? widget.data['order']['nurse']['hospital']['image'] : widget.data['order']['nurse']['image']
                      : widget.data['order']['doctor']['image']),
                  submitButtonText: 'Kirim',
                  commentHint: 'Tetapkan petunjuk komentar khusus Anda',
                  // ignore: avoid_print
                  onCancelled: () => print('cancelled'),
                  onSubmitted: (response) async {
                    // Get.find<ControllerPesanan>().updateStatus(
                    //     status: 5,
                    //     data: widget.data,
                    //     idOrder: widget.data['order']['id'].toString(),
                    //     context: context);
                    await Get.find<ControllerPesanan>().updateStatusNurse(
                        status: 5, orderId: widget.data['order']['id']);
                    Get.back();
                    await Get.find<ControllerPesanan>().sendRating(
                        rating: int.parse(response.rating.toStringAsFixed(0)),
                        deskripsi: response.comment,
                        orderId: widget.data['order']['id']);

                    // Get.find<ControllerPesanan>().updateStatus(
                    //     data: data,
                    //     status: 5,
                    //     idOrder: Get.find<ControllerPesanan>()
                    //         .idOrder
                    //         .value
                    //         .toString(),
                    //     context: context);
                    Get.back();

                    // ApiPesanan().ratingDoctor(
                    //     rating: int.parse(response.rating.toStringAsFixed(0)),
                    //     descriptionRating: response.comment,
                    //     idOrder: widget.data['order']['id'].toString());
                    showPopUp(
                        onTap: () {
                          Get.back();
                        },
                        description:
                            "Terimakasih Atas Konfirmasi\nPenyelesaian Layanan Ini\nRating yang anda beri akan membantu\nmeningkatkan kualitas layanan kami",
                        onPress: () {
                          Get.back();
                        });
                  },
                );
              },
            );
            Get.find<ControllerPesanan>().isStart.value = false;
          });
    }
    // else{
    //   Get.defaultDialog(
    //     title: "Mohon Maaf",
    //     middleText: "Dokter Belum Mengirimkan Resep"
    //   );
    // }
  }

  final myC = Get.put(ControllerPesanan());
  sendEmail() async {
    final Email email = Email(
      body: 'Test kirim email',
      subject: 'Selamat Pagi',
      recipients: ['care@bionmed.id'],
      // cc: ['cc@example.com'],
      // bcc: ['bcc@example.com'],
      // attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }

  final Uri whatsapp = Uri.parse('https://wa.me/6282147738240');

  @override
  Widget build(BuildContext context) {
    if (role == 'nurse') {
      Get.find<ControllerPesanan>().getDetailOrderNurse();
    } else {
      myC.getOrderDetail();
    }

    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Obx(
          () => myC.statusOrderDetail.value == 1 ||
                  myC.statusOrderDetail.value == 5 ||
                  myC.statusOrderDetail.value == 2 ||
                  myC.statusOrderDetail.value == 3 &&
                      widget.data['order']['service']['sequence'] ==
                          2 ||
                  myC.statusOrderDetail.value == 4 &&
                      widget.data['order']['service']['sequence'] ==
                          4 ||
                  myC.statusOrderDetail.value == 4 &&
                      widget.data['order']['service']['sequence'] ==
                          5 ||
                  myC.statusOrderDetail.value == 4 &&
                      widget.data['order']['service']['sequence'] == 6 ||
                  myC.statusOrderDetail.value == 4 &&
                      widget.data['order']['service']['sequence'] ==
                          2 || myC.statusOrderDetail.value == 98
              ? verticalSpace(0)
              : myC.statusOrderDetail.value == 99
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: 120,
                        child: Column(
                          children: [
                            ButtonPrimary(
                              onPressed: () {
                                //

                                if (role == 'nurse') {
                                  Get.find<ControllerPayment>()
                                          .serviceId
                                          .value =
                                      widget.data['order']
                                          ['service_price_nurse']['serviceId'];
                                  // pilihC.servicePriceId.value = widget.data['order']['servicePriceNurseId'];
                                  Get.put(InputLayananController())
                                          .idNurse
                                          .value =
                                      widget.data['order']['nurse']['id'];
                                  log("vvv ${pilihC.servicePriceId.value}");
                                  log(Get.find<ControllerPayment>()
                                      .serviceId
                                      .value
                                      .toString());
                                } else {
                                  Get.find<ControllerPayment>()
                                          .serviceId
                                          .value =
                                      widget.data['order']['service_price']
                                          ['serviceId'];
                                }
                                showModalBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      // <-- SEE HERE
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25.0),
                                      ),
                                    ),
                                    builder: (context) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          verticalSpace(10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 150,
                                                height: 5,
                                                decoration: BoxDecoration(
                                                    color: AppColor
                                                        .bodyColor.shade200,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                            ],
                                          ),
                                          verticalSpace(20),
                                          Center(
                                            child: Column(
                                              children: [
                                                verticalSpace(10),
                                                const Text(
                                                  'Atur ulang jadwal anda yang sudah terlewatkan',
                                                  style: TextStyle(),
                                                ),
                                                verticalSpace(20),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Text(
                                                          'Pilih Tanggal',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16),
                                                        ),
                                                        verticalSpace(10),
                                                        InkWell(
                                                          onTap: () {
                                                            // Get.find<PilihJadwalController>().docterId.value = ;
                                                            // Get.find<PilihJadwalController>().day.value = ;

                                                            // myC.datePicker();
                                                            datePicker1();
                                                            DateFormat
                                                                dateFormat =
                                                                DateFormat(
                                                                    "yyyy-MM-dd HH:mm:ss");
                                                            pilihC.dateTimeNow
                                                                    .value =
                                                                dateFormat
                                                                    .format(
                                                                        DateTime
                                                                            .now())
                                                                    .toString();
                                                            pilihC.docterId
                                                                .value = Get.find<
                                                                    ControllerPesanan>()
                                                                .doctorId
                                                                .value;
                                                            pilihC
                                                                .servicePriceId
                                                                .value = Get.find<
                                                                    ControllerPesanan>()
                                                                .servicePriceId
                                                                .value;
                                                            // print('UWU' + pilihC.dateTimeNow.toString());
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 50,
                                                            width:
                                                                Get.width / 2.5,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    10.0),
                                                              ),
                                                              border:
                                                                  Border.all(
                                                                width: 1.0,
                                                                color: Colors
                                                                    .grey[400]!,
                                                              ),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Obx(
                                                                  () => Icon(
                                                                    Icons
                                                                        .date_range,
                                                                    color: myC.dates.value ==
                                                                            ""
                                                                        ? Colors.grey[
                                                                            400]!
                                                                        : Colors
                                                                            .black,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 4.0,
                                                                ),
                                                                Obx(() => Text(
                                                                      myC.dates.value ==
                                                                              ""
                                                                          ? 'dd/mm/yy'
                                                                          : myC
                                                                              .dates
                                                                              .value,
                                                                      style: TextStyle(
                                                                          color: myC.dates.value == ""
                                                                              ? Colors.grey[400]!
                                                                              : Colors.black),
                                                                    ))
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10.0,
                                                ),
                                                // Text('Terima kasih telah memberikan penilaian anda,\nLekas membaik ', textAlign: TextAlign.center,),
                                                // Image.asset('assets/icons/icon_succes.png'),
                                                verticalSpace(20),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ButtonGradient(
                                                      onPressed: () async {
                                                        if (role == 'nurse') {
                                                          pilihC.serviceId
                                                              .value = widget
                                                                          .data[
                                                                      'order'][
                                                                  'service_price_nurse']
                                                              ['serviceId'];
                                                          pilihC.servicePriceId
                                                              .value = widget
                                                                  .data['order']
                                                              [
                                                              'servicePriceNurseId'];
                                                        } else {
                                                          pilihC.serviceId
                                                              .value = widget
                                                                          .data[
                                                                      'order'][
                                                                  'service_price']
                                                              ['serviceId'];
                                                        }
                                                        pilihC.startDateHomeVisit
                                                                .value =
                                                            "${Get.find<PilihJadwalController>().startDate.value} ${Get.find<ControllerPesanan>().times.value}";

                                                        if (role == 'nurse') {
                                                          await Get.put(
                                                                  InputLayananController())
                                                              .getDetailNurse();
                                                          await pilihC
                                                              .getJadwalNurse();
                                                        } else {
                                                          await Get.find<
                                                                  ControllerLogin>()
                                                              .getDoctorDetail(
                                                                  id: pilihC
                                                                      .docterId
                                                                      .value
                                                                      .toString());
                                                          await pilihC
                                                              .getSchedule();
                                                        }
                                                        for (var i = 0;
                                                            i <
                                                                pilihC
                                                                    .dataJadwal
                                                                    .length;
                                                            i++) {
                                                          pilihC.idService
                                                              .value = pilihC
                                                                  .dataJadwal[i]
                                                              ['id'];
                                                        }
                                                        // pilihC.registerSlot(
                                                        //     date: pilihC
                                                        //         .startDate
                                                        //         .value);
                                                        if (pilihC.dataJadwal
                                                            .isEmpty) {
                                                          showPopUp(
                                                              onTap: () {
                                                                Get.back();
                                                              },
                                                              imageAction:
                                                                  "assets/json/eror.json",
                                                              description:
                                                                  "Jadwal Tidak Tersedia");
                                                        } else {
                                                          if (role == 'nurse') {
                                                            Get.find<
                                                                    ControllerPayment>()
                                                                .sequenceId
                                                                .value = widget
                                                                        .data[
                                                                    'order']
                                                                ['serviceId'];
                                                            pilihC.namaLayanan
                                                                .value = widget
                                                                            .data[
                                                                        'order']
                                                                    ['service']
                                                                ['name'];
                                                            log("HAHAHAHAHA${Get.find<
                                                                        ControllerPesanan>()
                                                                    .orderIdDetail
                                                                    .value}");
                                                            Get.to(() =>
                                                                const AturUlangJadwalNurse());
                                                          } else {
                                                            Get.to(() =>
                                                                // ignore: prefer_const_constructors
                                                                AturUlangJadwal());
                                                          }
                                                        }
                                                        pilihC.namaLayanan
                                                            .value = widget
                                                                        .data[
                                                                    'order'][
                                                                'service_price']
                                                            ['name'];
                                                      },
                                                      label: 'Atur Ulang'),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              label: "Atur Ulang",
                              color: AppColor.yellowColor,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            actionLaporkan(context)
                          ],
                        ),
                      ),
                    )
                  : myC.isStart.value == true
                      ? Obx(() => Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ButtonGradient(
                              onPressed: () {}, label: "Loading...")))
                      // loadingIndicator()
                      : Obx(
                          () => Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Cntr(
                                height: role == "nurse" &&  myC.statusOrderDetail.value != 0? 100 :50,
                                child: Column(
                                  children: [
                                    Container(
                                      width: Get.width,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        gradient: myC.statusOrderDetail.value == 3 ||
                                                myC.statusOrderDetail.value == 4 ||
                                                myC.statusOrderDetail.value == 6 &&
                                                    role == 'nurse' ||
                                                myC.statusOrderDetail.value == 6 &&
                                                    widget.data['order']['service']
                                                            ['sequence'] ==
                                                        2||
                                                Get.find<ControllerPesanan>()
                                                        .updateStatusChat
                                                        .value ==
                                                    7 ||
                                                Get.find<ControllerPesanan>()
                                                        .updateStatusChat
                                                        .value >=
                                                    5 ||
                                                myC.statusOrderDetail.value == 6 &&
                                                    Get.find<ControllerPesanan>()
                                                            .imageResep
                                                            .value !=
                                                        ""
                                            ? AppColor.gradient1
                                            // ignore: prefer_const_constructors
                                            : LinearGradient(
                                                colors: 
                                                widget.data['order']['status'] == 0 ?[const Color(0xFF2B88D9),const Color(0XFF26E0F5)] :
                                                const [
                                                    Colors.grey,
                                                    Colors.grey,
                                                  ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: 
                                      
                                      ElevatedButton(
                                        onPressed: () {
                                          // ignore: avoid_print
                                          if (myC.statusOrderDetail.value == 3 ||
                                              myC.statusOrderDetail.value == 4 ||
                                              myC.statusOrderDetail.value == 6 &&
                                                  role == 'nurse' ||
                                              myC.statusOrderDetail.value == 6 &&
                                                  role == 'doctor' ||
                                              Get.find<ControllerPesanan>()
                                                      .updateStatusChat
                                                      .value ==
                                                  7 ||
                                              Get.find<ControllerPesanan>()
                                                      .updateStatusChat
                                                      .value >=
                                                  5 ||
                                              myC.statusOrderDetail.value == 6 &&
                                                  Get.find<ControllerPesanan>()
                                                          .imageResep
                                                          .value !=
                                                      "") {
                                            if (myC.isStart.value == false) {
                                              if (role == 'nurse') {
                                                actionButtonNurse();
                                              } else {
                                                actionButton();
                                              }
                                            }
                                            myC.isStart.value = true;
                              
                                            // _start = 15;
                                            // startTimer();
                                            // setState(() {
                                            //   isloading = true;
                                            // });
                              
                                          } else {
                                            if(widget.data['order']['status'] == 0){
                                              Get.find<ControllerPesanan>().codeOrder.value =
                        widget.data['order']['code'].toString();
                    Get.find<ControllerPesanan>().dataOrderChoice.value = widget.data;
                    Get.to(() => const MetodePaymentScreen(
                          paymentScreen: true,
                        ));
                                            }

                                            // print('object');
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          // ignore: deprecated_member_use
                                          primary: Colors.transparent,
                                          // ignore: deprecated_member_use
                                          onSurface: Colors.transparent,
                                          // shadowColor: Colors.transparent,
                                          elevation: 0.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(6.0),
                                          ),
                                        ),
                                        child: Text(
                                          myC.statusOrderDetail.value == 3
                                              ? "Mulai Sekarang "
                                              : myC.statusOrderDetail.value == 4 &&
                                                      widget.data['order']['service']['sequence'] ==
                                                         1
                                                  ? "Sedang Berlangsung"
                                                  : myC.statusOrderDetail.value == 6 && myC.imageResep.value != "" ||
                                                          Get.find<ControllerPesanan>()
                                                                  .updateStatusChat
                                                                  .value >=
                                                              5 ||
                                                          Get.find<ControllerPesanan>()
                                                                  .updateStatusChat
                                                                  .value ==
                                                              7 ||
                                                          myC.statusOrderDetail.value == 5 &&
                                                              widget.data['order']['service']['sequence'] ==
                                                                  2 ||
                                                          myC.statusOrderDetail.value == 5 &&
                                                              widget.data['order']['service']['sequence'] ==
                                                                  4 ||
                                                          myC.statusOrderDetail.value == 5 &&
                                                              widget.data['order']['service']['sequence'] ==
                                                                  5 ||
                                                          myC.statusOrderDetail.value == 5 &&
                                                              widget.data['order']['service']['sequence'] == 6
                                                      ? "Konfirmasi Pesanan Selesai"
                                                      : myC.statusOrderDetail.value == 6 && widget.data['order']['service']['sequence'] == 2 || myC.statusOrderDetail.value == 6 && widget.data['order']['service']['sequence'] == 4|| myC.statusOrderDetail.value == 6 && widget.data['order']['service']['sequence'] == 5 || myC.statusOrderDetail.value == 6 && widget.data['order']['service']['sequence'] == 6
                                                          ? "Konfirmasi selesai"
                                                          :
                                                          myC.statusOrderDetail.value == 0 ? "Bayar Sekarang" :
                                                           "Menunggu Resep Dari Dokter",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      
                                    ),
                                    role == "nurse" && widget.data['order']['status'] != 0 ?
                                   Column(children: [
                                     const SizedBox(
                                    height: 10.0,
                                    ),
                                    Txt(text: 'jika anda belum mengkonfirmasi selama 24 jam, maka pesanan akan dinyatakan selesai', textAlign: TextAlign.center,),
                                   ],) : const SizedBox(
                                   height: 1.0,
                                   ),

                                  ],
                                ),
                              )
                              // ButtonGradient(
                              //   onPressed: () {
                              //     setState(() {
                              //       isloading = true;
                              //     });
                              //     startTimer();
                              //     actionButton();
                              //   },
                              //   label: widget.data['order']['status'] == 3
                              //       ? "Mulai Sekarang "
                              //       : widget.data['order']['status'] == 4 &&
                              //               widget.data['order']['service']['name'] ==
                              //                   "Telemedicine"
                              //           ? "Sedang Berlangsung"
                              //           : widget.data['order']['status'] == 6 &&
                              //                       Get.find<ControllerPesanan>()
                              //                               .imageResep
                              //                               .value !=
                              //                           "" ||
                              //                   Get.find<ControllerPesanan>()
                              //                           .updateStatusChat
                              //                           .value ==
                              //                       3 ||
                              //                   widget.data['order']['status'] == 4 &&
                              //                       widget.data['order']['service']
                              //                               ['name'] ==
                              //                           "Home Visit Doctor"
                              //               ? "Konfirmasi Pesanan Selesai"
                              //               : "Menunggu Resep Dari Dokter",
                              // ),
                              ),
                        ),
        ),
        appBar: AppBar(
          title: Text(title),
          titleTextStyle: TextStyles.subtitle1,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: AppColor.gradient1,
            ),
          ),
        ),
        body: Obx(
          () => myC.isloadingDetail.isTrue
              ? loadingIndicator()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      widgetDoctor(),
                      widget.data['order']['status'] == 1 ||
                              widget.data['order']['status'] == 2 || widget.data['order']['status'] == 2 && role != "nurse"
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(children: [
                                Row(
                                  children: [
                                    Text(
                                      "Info jadwal",
                                      style: TextStyles.subtitle1,
                                    )
                                  ],
                                ),
                                verticalSpace(30),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/icons/calendar.png",
                                      width: 50,
                                    ),
                                    horizontalSpace(10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Tanggal & Waktu",
                                          style: TextStyles.subtitle2,
                                        ),
                                        Text(
                                          DateFormat('dd MMMM yyyy, HH:mm',
                                                  'id_ID')
                                              .format(DateTime.parse(
                                                  widget.data['order']
                                                      ['startDateCustomer'])),
                                          style: TextStyles.body2,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                verticalSpace(10),
                                const Divider(
                                  thickness: 1,
                                ),
                                verticalSpace(10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      widget.data['order']['service']['image'],
                                      width: 50,
                                    ),
                                    horizontalSpace(10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.data['order']['service']
                                              ['name'],
                                          style: TextStyles.subtitle2,
                                        ),
                                        verticalSpace(5),
                                        SizedBox(
                                          width: 260,
                                          child: Column(
                                            children: [
                                              AutoSizeText(
                                                widget.data['order']['service']
                                                    ['description'],
                                                style: TextStyles.small1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ]),
                            )
                          : 
                           widget.data['order']['status'] == 0 ? const SizedBox(
                           height: 1.0,
                           ) :
                          widgetStepOrder(),
                          const SizedBox(
                          height: 20.0,
                          ),
                      role == "nurse"
                          ? detailPesananNurse(context)
                          : detailOrderDokter(),
                    ],
                  ),
                ),
        ));
  }

  Column detailOrderDokter() {
    return Column(
      children: [
        widgetCardPayment(),
        widget.data['order']['status'] == 1 ||
                widget.data['order']['status'] == 2
            ? verticalSpace(0)
            : widgetAnnouncement(),
        widgetDetailTransaksi()
      ],
    );
  }

  ButtonPrimary actionLaporkan(BuildContext context) {
    return ButtonPrimary(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: 150,
                    height: 5,
                    decoration: BoxDecoration(
                        color: AppColor.bodyColor.shade200,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text('Hubungi Helpdesk'),
                  const SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    onTap: () {
                      launchUrl(whatsapp);
                    },
                    child: Container(
                      height: 50,
                      width: Get.width,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        color: Color(0xff9CEEA5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/icon_wa.png'),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text(
                            '+62 8821-8721-8723',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff00810F)),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InkWell(
                    onTap: () {
                      sendEmail();
                    },
                    child: Container(
                      height: 50,
                      width: Get.width,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        color: Color(0xffFFB3AD),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/icon_gmail.png'),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text(
                            'care@bionmed.id',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffC80000)),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InkWell(
                    onTap: () {
                      // FlutterPhoneDirectCaller.callNumber("+6289657081093");
                      // ignore: deprecated_member_use
                      launch("tel:(021) 82407779");
                    },
                    child: Container(
                      height: 50,
                      width: Get.width,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        color: Color(0xffB1D4F7),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/icon_call.png'),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text(
                            '(021) 82407779',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff001A61)),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                ],
              );
            });
      },
      textColor: Colors.red,
      label: "Laporkan?",
      color: const Color.fromARGB(255, 253, 208, 208),
      // margin: EdgeInsets.symmetric(horizontal: 24,),
    );
  }

  Container widgetDetailTransaksi() {
    return Container(
      color: AppColor.whiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            verticalSpace(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Kode Order:",
                  style: TextStyles.body2,
                ),
                Text(
                  '${widget.data['order']['code']}',
                  style: TextStyles.subtitle1,
                ),
              ],
            ),
            verticalSpace(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tanggal Order:",
                  style: TextStyles.body2,
                ),
                Text(
                  DateFormat('d MMMM y, kk:mm', "id_ID")
                      .format(DateTime.parse(widget.data['order']['date'])),
                  style: TextStyles.subtitle1,
                ),
              ],
            ),
            verticalSpace(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mulai Order',
                      style: TextStyles.body2,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Selesai Order',
                      style: TextStyles.body2,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      DateFormat('d MMMM y, kk:mm', "id_ID").format(
                          DateTime.parse(
                              widget.data['order']['startDateCustomer'])),
                      // CurrencyFormat.convertToIdr(discount, 0),
                      style: TextStyles.subtitle1,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      DateFormat('d MMMM y, kk:mm', "id_ID").format(
                          DateTime.parse(
                              widget.data['order']['endDateCustomer'])),
                      // CurrencyFormat.convertToIdr(discount, 0),
                      style: TextStyles.subtitle1,
                    ),
                  ],
                ),
              ],
            ),
            verticalSpace(10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Harga jasa :",
                  style: TextStyles.body2,
                ),
                Text(
                  role == 'nurse'
                      ? priceFormat(widget.data['order']['totalPrice'])
                      : priceFormat(
                          widget.data['order']['service_price']['price']),
                  style: TextStyles.subtitle1,
                ),
              ],
            ),
            verticalSpace(10),
            Visibility(
              visible: role != 'nurse',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Diskon :",
                    style: TextStyles.body2,
                  ),
                  Text(
                    role == 'nurse'
                        ? '${widget.data['order']['service_price_nurse']['discount']} %'
                        : '${widget.data['order']['service_price']['discount']} %',
                    style: TextStyles.subtitle1,
                  ),
                ],
              ),
            ),
            verticalSpace(10),
            widget.data['order']['voucher'] == null
                ? const SizedBox(
                    height: 1.0,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Diskon Voucher :",
                        style: TextStyles.body2,
                      ),
                      Text(
                        '${widget.data['order']['voucher']['discount']} %',
                        style: TextStyles.subtitle1,
                      ),
                    ],
                  ),
            // Visibility(
            //   visible: widget.data['order']['voucher'] != null,
            //   child:
            //  Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       "Diskon Voucher :",
            //       style: TextStyles.body2,
            //     ),
            //     Text(
            //       '${widget.data['order']['voucher']['discount']} %',
            //       style: TextStyles.subtitle1,
            //     ),
            //   ],
            // ), ),

            const Divider(
              thickness: 1,
            ),
            verticalSpace(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Harga :",
                  style: TextStyles.body2,
                ),
                Text(
                  priceFormat(widget.data['order']['totalPrice']),
                  style: TextStyles.subtitle1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget widgetAnnouncement() {
    return Obx(() => myC.statusOrderDetail.value == 3
        ? Stack(
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      "Ayo mulai konsultasi",
                      style: TextStyles.subtitle1,
                    ),
                    Text(
                      "Tekan mulai untuk langsung berkonsultasi ",
                      style: TextStyles.body2,
                    ),
                    Center(
                      child: Image.asset(
                        'assets/images/step_one_order.png',
                        width: 200.w,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : myC.statusOrderDetail.value == 4
            ? Stack(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Konsultasi berlangsung",
                          style: TextStyles.subtitle1,
                        ),
                        Text(
                          "Tekan lihat konsultasi / lanjutkan",
                          style: TextStyles.body2,
                        ),
                        Center(
                          child: Image.asset(
                            'assets/images/step_two_order.png',
                            width: 200.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : myC.statusOrderDetail.value == 99
                ? Stack(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "Konsultasi Gagal",
                              style: TextStyles.subtitle1,
                            ),
                            Text(
                              "Konsultasi anda bermasalah / Gagal",
                              style: TextStyles.body2,
                            ),
                            Center(
                              child: Image.asset(
                                'assets/images/step_fail_order.png',
                                width: 200.w,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Stack(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "Konsultasi Selesai",
                              style: TextStyles.subtitle1,
                            ),
                            Text(
                              "Sesi konsultasi telah selesai",
                              style: TextStyles.body2,
                            ),
                            Center(
                              child: Image.asset(
                                'assets/images/step_there_order.png',
                                width: 200.w,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ));
  }

  Padding widgetStepOrder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Info Order",
                style: TextStyles.subtitle2,
              ),
            ],
          ),
          verticalSpace(20.h),
          Obx(() => myC.statusOrderDetail.value == 3 || myC.statusOrderDetail.value == 2 && role == 'nurse'
              ? Row(
                  children: [
                    Image.asset(
                      role == 'nurse' ? 'assets/images/step_oneN.png':
                      'assets/images/step_one.png',
                      height: 244,
                      width: 279,
                    ),
                  ],
                )
              : myC.statusOrderDetail.value == 4
                  ? Row(
                      children: [
                        Image.asset(
                          role == 'nurse' ? 'assets/images/step_twoN.png':
                          'assets/images/step_two.png',
                          height: 244,
                          width: 279,
                        ),
                      ],
                    )
                  : myC.statusOrderDetail.value == 6
                      ? Row(
                          children: [
                            Image.asset(
                              role == 'nurse' ? 'assets/images/step_threeN.png':
                              'assets/images/step_three.png',
                              height: 244,
                              width: 279,
                            ),
                          ],
                        )
                      : myC.statusOrderDetail.value == 5
                          ? Row(
                              children: [
                                Image.asset(
                                  role == 'nurse' ? 'assets/images/step_fiveN.png':
                                  'assets/images/step_four.png',
                                  height: 244,
                                  width: 279,
                                ),
                              ],
                            )
                          : myC.statusOrderDetail.value == 98 ? 
                          Row(
                              children: [
                                Image.asset(
                                   role == 'nurse' ? 'assets/images/step_failN2.png' :
                                  'assets/images/step_fail.png',
                                  height: 244,
                                  width: 279,
                                ),
                              ],
                            )
                          
                          :Row(
                              children: [
                                Image.asset(
                                   role == 'nurse' ? 'assets/images/step_failN.png' :
                                  'assets/images/step_fail.png',
                                  height: 244,
                                  width: 279,
                                ),
                              ],
                            ))
        ],
      ),
    );
  }

  Padding widgetCardPayment() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Obx(() {
            RxInt statusOrder = 0.obs;
            statusOrder.value = widget.data['order']['status'];
            // imageResep.value = myC.imageResep.value;
            return myC.statusOrderDetail.value == 5 &&
                        myC.imageResep.value != "" ||
                    myC.statusOrderDetail.value == 6 &&
                        myC.imageResep.value != ""
                ? Column(
                    children: [
                      InkWell(
                        onTap: () {
                          myC.imageResep.value = myC.imageResep.value == ""
                              ? ""
                              : myC.imageResep.value;
                          Get.to(Resep());
                        },
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.center,
                            width: Get.width,
                            height: 50,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                                gradient: AppColor.gradient1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Text(
                                  'Lihat Resep',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 15,
                                )
                              ],
                            )),
                      ),
                      const SizedBox(
                        height: 7.0,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.verified,
                            size: 15,
                            color: AppColor.successColor,
                          ),
                          horizontalSpace(5),
                          Text(
                            "Dokter mengirimkan resep untuk anda",
                            style: TextStyles.subtitle3.copyWith(
                                color: AppColor.successColor, fontSize: 12),
                          )
                        ],
                      )
                    ],
                  )
                : Get.find<ControllerPesanan>().updateStatusChat.value == 7 ||
                        Get.find<ControllerPesanan>().updateStatusChat.value >=
                            5
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        width: Get.width,
                        height: 55,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                            gradient: AppColor.gradient1),
                        child: myC.statusOrderDetail.value == 5
                            ? const Text(
                                "Dokter Tidak Memberi Resep",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                "Dokter Tidak Memberi Resep\n Mohon Konfirmasi Pesanan Anda",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ))
                    : const SizedBox(
                        height: 1.0,
                      );
          }),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Text(
                "Metode Pembayaran :",
                style: TextStyles.subtitle2,
              ),
            ],
          ),
          verticalSpace(10), DottedBorder(
                  radius: const Radius.circular(8),
                  color:
                      AppColor.bodyColor.shade300, //color of dotted/dash line
                  strokeWidth: 2, //thickness of dash/dots
                  dashPattern: const [5, 6],
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: 
                      widget.data['payment'] == null
              ?  Cntr(height: 30, width: Get.width,)
              :
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            widget.data['payment']['debit_from_bank'] == '014'
                                ? Image.asset(
                                    'assets/icons/logo_bca.png',
                                    width: 50,
                                    height: 50,
                                  )
                                : widget.data['payment']['debit_from_bank'] ==
                                        '002'
                                    ? Image.asset(
                                        'assets/icons/logo_briva.png',
                                        width: 50,
                                        height: 50,
                                      )
                                    : widget.data['payment']
                                                ['debit_from_bank'] ==
                                            '013'
                                        ? Image.asset(
                                            'assets/icons/logo_permata.png',
                                            width: 50,
                                            height: 50,
                                          )
                                        : widget.data['payment']
                                                    ['debit_from_bank'] ==
                                                '022'
                                            ? Image.asset(
                                                'assets/icons/logo_cimb.png',
                                                width: 50,
                                                height: 50,
                                              )
                                            : widget.data['payment']
                                                        ['debit_from_bank'] ==
                                                    '503'
                                                ? Image.asset(
                                                    'assets/icons/logo_ovo.png',
                                                    width: 50,
                                                    height: 50,
                                                  )
                                                : widget.data['payment'][
                                                            'debit_from_bank'] ==
                                                        '016'
                                                    ? Image.asset(
                                                        'assets/icons/logo_maybank.png',
                                                        width: 50,
                                                        height: 50,
                                                      )
                                                    : widget.data['payment'][
                                                                'debit_from_bank'] ==
                                                            '011'
                                                        ? Image.asset(
                                                            'assets/icons/logo_danamon.png',
                                                            width: 50,
                                                            height: 50,
                                                          )
                                                        : widget.data['payment']['product_code'] ==
                                                                'MANDIRIATM'
                                                            ? Image.asset(
                                                                'assets/icons/logo_mandiri.png',
                                                                width: 50,
                                                                height: 50,
                                                              )
                                                            : widget.data['payment']
                                                                        ['product_code'] ==
                                                                    'SHOPEEJUMPPAY'
                                                                ? Image.asset(
                                                                    'assets/icons/logo_shopeepay.png',
                                                                    width: 50,
                                                                    height: 50,
                                                                  )
                                                                : widget.data['payment']['product_code'] == 'LINKAJAAPPLINK'
                                                                    ? Image.asset(
                                                                        'assets/icons/logo_linkaja.png',
                                                                        width:
                                                                            50,
                                                                        height:
                                                                            50,
                                                                      )
                                                                    : widget.data['payment']['product_code'] == 'DANAPAY'
                                                                        ? Image.asset(
                                                                            'assets/icons/logo_dana.png',
                                                                            width:
                                                                                50,
                                                                            height:
                                                                                50,
                                                                          )
                                                                        : widget.data['payment']['debit_from_bank'] == '157'
                                                                            ? Image.asset(
                                                                                'assets/icons/logo_maspion.png',
                                                                                width: 50,
                                                                                height: 50,
                                                                              )
                                                                            : widget.data['payment']['debit_from_bank'] == '037'
                                                                                ? Image.asset(
                                                                                    'assets/icons/logo_artha.png',
                                                                                    width: 50,
                                                                                    height: 50,
                                                                                  )
                                                                                : widget.data['payment']['debit_from_bank'] == '200'
                                                                                    ? Image.asset(
                                                                                        'assets/icons/logo_btn.png',
                                                                                        width: 50,
                                                                                        height: 50,
                                                                                      )
                                                                                    : widget.data['payment']['debit_from_bank'] == '213'
                                                                                        ? Image.asset(
                                                                                            'assets/icons/logo_btpn.png',
                                                                                            width: 50,
                                                                                            height: 50,
                                                                                          )
                                                                                        : Image.asset(
                                                                                            'assets/icons/bni.png',
                                                                                            width: 50,
                                                                                            height: 50,
                                                                                          ),
                            horizontalSpace(10.w),
                            Text(
                              widget.data['payment']['debit_from_bank'] == '014'
                                  ? "Bank Central Asia"
                                  : widget.data['payment']['debit_from_bank'] ==
                                          '002'
                                      ? "Bank Republik Indonesia"
                                      : widget.data['payment']['debit_from_bank'] ==
                                              '013'
                                          ? "Bank Permata"
                                          : widget.data['payment']
                                                      ['debit_from_bank'] ==
                                                  '022'
                                              ? "Bank CIMB"
                                              : widget.data['payment']
                                                          ['debit_from_bank'] ==
                                                      '016'
                                                  ? "Bank MayBank"
                                                  : widget.data['payment'][
                                                              'debit_from_bank'] ==
                                                          '011'
                                                      ? "Bank Danamon"
                                                      : widget.data['payment'][
                                                                  'product_code'] ==
                                                              'MANDIRIATM'
                                                          ? "Bank Mandiri"
                                                          : widget.data['payment']['product_code'] ==
                                                                  'SHOPEEJUMPPAY'
                                                              ? "ShopeePay"
                                                              : widget.data['payment']
                                                                          ['product_code'] ==
                                                                      'LINKAJAAPPLINK'
                                                                  ? "LinkAja"
                                                                  : widget.data['payment']['product_code'] == 'DANAPAY'
                                                                      ? "DANA"
                                                                      : widget.data['payment']['debit_from_bank'] == '157'
                                                                          ? "Bank Maspion"
                                                                          : widget.data['payment']['debit_from_bank'] == '157'
                                                                              ? "Bank Artha Graha "
                                                                              : widget.data['payment']['debit_from_bank'] == '200'
                                                                                  ? "Bank BTN "
                                                                                  : widget.data['payment']['debit_from_bank'] == '213'
                                                                                      ? "Bank BTPN "
                                                                                      : widget.data['payment']['debit_from_bank'] == '503'
                                                                                          ? "Ovo"
                                                                                          : "Bank Negara Indonesia",
                              style: TextStyles.subtitle3,
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ),
          verticalSpace(10),
          Row(
            children: [
              const Icon(
                Icons.verified,
                color: AppColor.successColor,
              ),
              horizontalSpace(5),
              Text(
                "Ter-verifikasi sudah bayar",
                style:
                    TextStyles.subtitle3.copyWith(color: AppColor.successColor),
              )
            ],
          )
        ],
      ),
    );
  }

  Padding widgetDoctor() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: role == 'nurse'
                ? widget.data['order']['nurse']['hospital'] != null ? widget.data['order']['nurse']['hospital']['image'] ?? 'https://img.freepik.com/free-vector/people-walking-sitting-hospital-building-city-clinic-glass-exterior-flat-vector-illustration-medical-help-emergency-architecture-healthcare-concept_74855-10130.jpg?w=2000&t=st=1694367961~exp=1694368561~hmac=dc0a60debe1925ff62ec0fb9171e5466998617fa775ef32cac6f5113af4dcc42' : widget.data['order']['nurse']['image']
                : widget.data['order']['doctor']['image'],
            width: 70.w,
            placeholder: (context, url) =>
                loadingIndicator(color: AppColor.primaryColor),
            errorWidget: (context, url, error) =>
                Image.asset('assets/images/img-doctor2.png'),
          ),
          horizontalSpace(20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                role == 'nurse'
                    ? widget.data['order']['nurse']['hospital'] != null ? widget.data['order']['nurse']['hospital']['name'] :
                    
                    widget.data['order']['nurse']['name']
                    : widget.data['order']['doctor']['name'],
                style: TextStyles.subtitle2,
              ),
              verticalSpace(5),
              Text(widget.data['order']['service']['name'],
                  style: TextStyles.body2.copyWith(
                    color: AppColor.bodyColor.shade400,
                  )),
              const SizedBox(
                height: 5.0,
              ),
              Visibility(
                visible: role != 'nurse',
                child: InkWell(
                  onTap: () {
                    Get.find<ControllerLogin>()
                        .getDoctorDetail(id: myC.detailDokter['id'].toString());
                    // ignore: prefer_const_constructors
                    Get.to(DetailDokterInOrder());
                  },
                  child: const Text("Detail Dokter",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                      )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Column detailPesananNurse(BuildContext context) {
    return Column(
      children: [
        Cntr(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            radius: BorderRadius.circular(10),
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
            gradient: AppColor.gradient1,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Tanggal Pemesanan',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    Text(
                      DateFormat('d MMMM y, kk:mm', "id_ID")
                          .format(DateTime.parse(widget.data['order']['date'])),
                      // CurrencyFormat.convertToIdr(discount, 0),
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    // Text(
                    //   DateFormat('d MMMM y, kk:mm', "id_ID")
                    //       .format(DateTime.parse(tanggal)),
                    //   style: blackTextStyle.copyWith(
                    //       fontWeight: bold, color: Colors.white),
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Mulai Order',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          'Selesai Order',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                        
                          DateFormat('d MMMM y, kk:mm', "id_ID").format(
                              DateTime.parse(
                                  widget.data['order']['startDateCustomer'])),
                          // CurrencyFormat.convertToIdr(discount, 0),
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          DateFormat('d MMMM y, kk:mm', "id_ID").format(
                              DateTime.parse(
                                  widget.data['order']['endDateCustomer'])),
                          // CurrencyFormat.convertToIdr(discount, 0),
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),

                        // Text(
                        //   DateFormat('d MMMM y, kk:mm', "id_ID")
                        //       .format(DateTime.parse(jamMulai)),
                        //   // CurrencyFormat.convertToIdr(discount, 0),
                        //   style: blackTextStyle.copyWith(
                        //       fontWeight: bold, color: Colors.white),
                        // ),
                        // const SizedBox(
                        //   height: 10.0,
                        // ),
                        // Text(
                        //   DateFormat('d MMMM y, kk:mm', "id_ID")
                        //       .format(DateTime.parse(jamSelesai)),
                        //   // CurrencyFormat.convertToIdr(discount, 0),
                        //   style: blackTextStyle.copyWith(
                        //       fontWeight: bold, color: Colors.white),
                        // ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
            widget.data['order']['nurse']['hospital'] != null ?         namaHospital()
:
        namaPerawat(),
        // detailAmbulance(),
        // const SizedBox(
        // height: 20.0,
        // ),
        // InkWell(
        //         onTap: () {
        //           popUpLihatGambar(Get.context!);
        //         },
        //         child: Cntr(
        //           margin: const EdgeInsets.symmetric(horizontal: 24),
        //           alignment: Alignment.center,
        //           radius: BorderRadius.circular(10),
        //           color: Colors.transparent,
        //           height: 40,
        //           width: Get.width,
        //           border: Border.all(color: Colors.blue),
        //           child: Txt(
        //             text: "Lihat bukti selesai",
        //             color: Colors.blue,
        //           ),
        //         ),
        //       ),

        const SizedBox(
          height: 15.0,
        ),
        dataOrderNurse(),
        // dataPemesanNurse(),
        const SizedBox(
          height: 20.0,
        ),
        // buktiPengambilanSample(),
        detailPaketNurse(),
        const SizedBox(
          height: 25.0,
        ),
        Cntr(
          width: Get.width,
            boxShadow:widget.data['order']['status'] != 6 && widget.data['order']['status'] != 5 && widget.data['order']['status'] != 99 && widget.data['order']['status'] != 0? [
              const BoxShadow(blurRadius: 10, spreadRadius: 1, color: Colors.grey)
            ] :[],
            padding: const EdgeInsets.only(top: 30, bottom: 20),
            color: Colors.white,
            child: widget.data['order']['status'] == 4
                ? Column(
                    children: [
                      Txt(text: 'Pesanan sedang berlangsung'),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal :24.0),
                        child: actionLaporkan(context),
                      )
                    ],
                  )
                : widget.data['order']['status'] == 99
                    ? const SizedBox(
                    height: 0.0,
                    )
                    // Column(
                    //     children: [
                    //       Padding(
                    //         padding:
                    //             const EdgeInsets.symmetric(horizontal: 24.0),
                    //         child: Txt(
                    //           text:
                    //               'Menunggu pemesan mengatur ulang jadwal atau mebatalkan pesanan',
                    //           textAlign: TextAlign.center,
                    //         ),
                    //       ),
                    //       const SizedBox(
                    //         height: 15.0,
                    //       ),
                    //       actionLaporkan(context)
                    //     ],
                    //   )
                    : 
                    widget.data['order']['status'] == 98
                        ? 
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Column(
                              children: [
                                Image.asset('assets/images/Frame.png'),
                                const SizedBox(
                                height: 10.0,
                                ),
                                Txt(
                                  text:
                                      'Pesanan telah dibatalkan, saldo akan segera dikembalikan ke rekening anda',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          )
                        : widget.data['order']['status'] == 6
                            ? const SizedBox(
                            height: 1.0,
                            )
                            // Cntr(
                            //     width: Get.width,
                            //     child: Txt(text: 'jika anda belum mengkonfirmasi selama 24 jam, maka pesanan akan dinyatakan selesai', textAlign: TextAlign.center,),
                            //   )
                            : widget.data['order']['status'] == 5
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0),
                                    child: Column(
                                      children: [
                                        Txt(
                                          text: 'Penilaian',
                                          weight: FontWeight.bold,
                                        ),
                                        const SizedBox(
                                          height: 6.0,
                                        ),
                                        Txt(
                                          text: 'Penilaian anda sangat berharga',
                                          size: 12,
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Rating(rating: double.parse(widget.data['order']['rating'].toString()),deskripsi: widget.data['order']['description_rating'],)
                                        // rating,
                                      ],
                                    ),
                                  )
                                : widget.data['order']['status'] == 0? const SizedBox(
                                height: 1.0,
                                ): 
                                
                                Center(child: Txt(text: 'Menunggu keberangkatan perawat')))
      ],
    );
  }

  Cntr detailPaketNurse() {
    return Cntr(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      alignment: Alignment.centerLeft,
      width: Get.width,
      color: const Color(0xffF4F4F4),
      radius: BorderRadius.circular(10),
      child: ExpansionTile(
          title: Txt(
            text: 'Detail Paket',
            weight: FontWeight.bold,
          ),
          children: [
            Cntr(
              color: const Color(0xffF4F4F4),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              radius: BorderRadius.circular(10),
              width: Get.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Txt(
                        text: 'Jenis Layanan',
                        size: 12,
                        color: Colors.grey,
                      ),
                      Txt(
                        text: widget.data['order']['service']['name'],
                        size: 10,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Cntr(
                    color: Colors.transparent,
                    height:
                        50.0 * Get.find<ControllerPesanan>().sopNurse.length,
                    width: Get.width,
                    child: ListView.builder(
                      itemCount: Get.find<ControllerPesanan>().sopNurse.length,
                      itemBuilder: (context, index) => Cntr(
                        radius: BorderRadius.circular(10),
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.network(
                              Get.find<ControllerPesanan>().sopNurse[index]
                                  ['nurse_work_scope']['icon'],
                              height: 20,
                            ),
                            Cntr(
                              width: Get.width / 1.7,
                              child: Txt(
                                  text: Get.find<ControllerPesanan>()
                                      .sopNurse[index]['nurse_work_scope']['name']
                                  // "Get.find<LayananHomeController>().packageNurseSops[index]['nurse_work_scope']['name']"
                                  ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]),
    );
  }

  Cntr buktiPengambilanSample() {
    return Cntr(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      alignment: Alignment.centerLeft,
      width: Get.width,
      color: const Color(0xffF4F4F4),
      radius: BorderRadius.circular(10),
      child: ExpansionTile(
          title: Txt(
            text: 'Bukti pengambilan sample',
            weight: FontWeight.bold,
          ),
          children: [
            Cntr(
              color: const Color(0xffF4F4F4),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              radius: BorderRadius.circular(10),
              width: Get.width,
              child: Column(
                children: [
                  Cntr(height: 120,
                  width:  Get.width,
                radius: BorderRadius.circular(10),
                image: const DecorationImage(image: NetworkImage('https://picsum.photos/200/300'), fit: BoxFit.cover),),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Cntr(
                    radius: BorderRadius.circular(10),
                    padding: const EdgeInsets.all(15),
                    border: Border.all(color: Colors.grey[300]!),
                    color: Colors.grey[100],
                    height:
                        100,
                    width: 
                    Get.width,
                    child: 
                    Txt(text: 'Sudah melakukan penganmbila tes pada jam 15.00 WiB dirumah pasien')
                  )
                ],
              ),
            ),
          ]),
    );
  }

  Cntr dataOrderNurse() {
    return Cntr(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      alignment: Alignment.centerLeft,
      width: Get.width,
      color: const Color(0xffF4F4F4),
      radius: BorderRadius.circular(10),
      child: ExpansionTile(
          title: Txt(
            text: 'Data Order',
            weight: FontWeight.bold,
          ),
          children: [
            Cntr(
              color: const Color(0xffF4F4F4),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              radius: BorderRadius.circular(10),
              width: Get.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Txt(
                        text: 'Kode Order',
                        size: 12,
                        color: Colors.grey,
                      ),
                      Txt(
                        text: "${widget.data['order']['code']}",
                        size: 10,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Txt(
                        text: 'Pembayaran',
                        size: 12,
                        color: Colors.grey,
                      ),
                  widget.data['payment'] == null ? Txt(text: '') :
                      widget.data['payment']['debit_from_bank'] == '014'
                          ? Image.asset(
                              'assets/icons/logo_bca.png',
                              width: 50,
                              height: 50,
                            )
                          : widget.data['payment']['debit_from_bank'] == '002'
                              ? Image.asset(
                                  'assets/icons/logo_briva.png',
                                  width: 50,
                                  height: 50,
                                )
                              : widget.data['payment']['debit_from_bank'] ==
                                      '013'
                                  ? Image.asset(
                                      'assets/icons/logo_permata.png',
                                      width: 50,
                                      height: 50,
                                    )
                                  : widget.data['payment']['debit_from_bank'] ==
                                          '022'
                                      ? Image.asset(
                                          'assets/icons/logo_cimb.png',
                                          width: 50,
                                          height: 50,
                                        )
                                      : widget.data['payment']
                                                  ['debit_from_bank'] ==
                                              '503'
                                          ? Image.asset(
                                              'assets/icons/logo_ovo.png',
                                              width: 50,
                                              height: 50,
                                            )
                                          : widget.data['payment']
                                                      ['debit_from_bank'] ==
                                                  '016'
                                              ? Image.asset(
                                                  'assets/icons/logo_maybank.png',
                                                  width: 50,
                                                  height: 50,
                                                )
                                              : widget.data['payment']
                                                          ['debit_from_bank'] ==
                                                      '011'
                                                  ? Image.asset(
                                                      'assets/icons/logo_danamon.png',
                                                      width: 50,
                                                      height: 50,
                                                    )
                                                  : widget.data['payment'][
                                                              'product_code'] ==
                                                          'MANDIRIATM'
                                                      ? Image.asset(
                                                          'assets/icons/logo_mandiri.png',
                                                          width: 50,
                                                          height: 50,
                                                        )
                                                      : widget.data['payment'][
                                                                  'product_code'] ==
                                                              'SHOPEEJUMPPAY'
                                                          ? Image.asset(
                                                              'assets/icons/logo_shopeepay.png',
                                                              width: 50,
                                                              height: 50,
                                                            )
                                                          : widget.data['payment']
                                                                      ['product_code'] ==
                                                                  'LINKAJAAPPLINK'
                                                              ? Image.asset(
                                                                  'assets/icons/logo_linkaja.png',
                                                                  width: 50,
                                                                  height: 50,
                                                                )
                                                              : widget.data['payment']['product_code'] == 'DANAPAY'
                                                                  ? Image.asset(
                                                                      'assets/icons/logo_dana.png',
                                                                      width: 50,
                                                                      height:
                                                                          50,
                                                                    )
                                                                  : widget.data['payment']['debit_from_bank'] == '157'
                                                                      ? Image.asset(
                                                                          'assets/icons/logo_maspion.png',
                                                                          width:
                                                                              50,
                                                                          height:
                                                                              50,
                                                                        )
                                                                      : widget.data['payment']['debit_from_bank'] == '037'
                                                                          ? Image.asset(
                                                                              'assets/icons/logo_artha.png',
                                                                              width: 50,
                                                                              height: 50,
                                                                            )
                                                                          : widget.data['payment']['debit_from_bank'] == '200'
                                                                              ? Image.asset(
                                                                                  'assets/icons/logo_btn.png',
                                                                                  width: 50,
                                                                                  height: 50,
                                                                                )
                                                                              : widget.data['payment']['debit_from_bank'] == '213'
                                                                                  ? Image.asset(
                                                                                      'assets/icons/logo_btpn.png',
                                                                                      width: 50,
                                                                                      height: 50,
                                                                                    )
                                                                                  : Image.asset(
                                                                                      'assets/icons/bni.png',
                                                                                      width: 50,
                                                                                      height: 50,
                                                                                    ),
                      // Image.asset(
                      //   controller.paymentName.value == "022"
                      //       ? 'assets/icon/icon_bankcimb.png'
                      //       : controller.paymentName.value == "014"
                      //           ? 'assets/icon/icon_bankbca.png'
                      //           : controller.paymentName.value == "002"
                      //               ? 'assets/icon/bri.png'
                      //               : controller.paymentName.value == "013"
                      //                   ? 'assets/icon/icon_bankpermata.png'
                      //                   : controller.paymentName.value == "503"
                      //                       ? "assets/icon/logo_ovo.png"
                      //                       : controller.paymentName.value ==
                      //                               "016"
                      //                           ? "assets/icon/logo_maybank.png"
                      //                           : controller.paymentName
                      //                                       .value ==
                      //                                   "011"
                      //                               ? "assets/icon/logo_danamon.png"
                      //                               : controller.paymentName
                      //                                               .value ==
                      //                                           "008" &&
                      //                                       controller.bankName
                      //                                               .value ==
                      //                                           "MANDIRIATM"
                      //                                   ? "assets/icon/logo_mandiri.png"
                      //                                   : controller.paymentName
                      //                                                   .value ==
                      //                                               "008" &&
                      //                                           controller
                      //                                                   .bankName
                      //                                                   .value ==
                      //                                               "DANAPAY"
                      //                                       ? "assets/icon/logo_dana.png"
                      //                                       : controller.paymentName
                      //                                                   .value ==
                      //                                               "157"
                      //                                           ? "assets/icon/logo_maspion.png"
                      //                                           : controller.paymentName
                      //                                                       .value ==
                      //                                                   "037"
                      //                                               ? "assets/icon/logo_artha.png"
                      //                                               : controller.paymentName.value ==
                      //                                                       "200"
                      //                                                   ? "assets/icon/logo_btn.png"
                      //                                                   : controller.paymentName.value ==
                      //                                                           "213"
                      //                                                       ? "assets/icon/logo_btpn.png"
                      //                                                       : controller.bankName.value == "SHOPEEJUMPPAY"
                      //                                                           ? "assets/icon/logo_shopeepay.png"
                      //                                                           : controller.bankName.value == "LINKAJAAPPLINK"
                      //                                                               ? "assets/icon/logo_linkaja.png"
                      //                                                               : 'assets/icon/bni.png',
                      //   height: 20,
                      // ),
                      // Txt(
                      //   text: 'alah siaa',
                      //   size: 10,
                      //   weight: FontWeight.bold,
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Txt(
                        text: 'Harga',
                        size: 12,
                        color: Colors.grey,
                      ),
                      Txt(
                        text: CurrencyFormat.convertToIdr(
                            widget.data['order']['totalPrice'], 0),
                        size: 10,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            ),
          ]),
    );
  }

  Cntr detailAmbulance() {
    return Cntr(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      radius: BorderRadius.circular(10),
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 26),
      gradient: AppColor.gradient1,
      child: Column(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      Txt(
                        text: 'Detail Ambulance',
                        size: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Txt(
                        text: 'DK 1234 FGH',
                        weight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Txt(
                        text: 'Ambulance Standar 1',
                        size: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      // popUpkirimLaporanSelesaiAmbulance(Get.context!);
                    },
                    child: Cntr(
                      radius: BorderRadius.circular(100),
                      height: 80,
                      width: 80,
                      image: const DecorationImage(
                          image: NetworkImage(
                              'https://fastly.picsum.photos/id/201/200/300.jpg?blur=2&hmac=Bk1YAURRJgndPj6oL1nVMMPuskT1OVuu7itxEp71aH4'),
                          fit: BoxFit.cover),
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                  ),

                  // const Icon(
                  //   Icons.access_time_filled_outlined,
                  //   color: Colors.white,
                  //   size: 40,
                  // )
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              InkWell(
                onTap: () {
                  popUpLihatGambar(Get.context!);
                },
                child: Cntr(
                  alignment: Alignment.center,
                  radius: BorderRadius.circular(10),
                  color: Colors.transparent,
                  height: 40,
                  width: Get.width,
                  border: Border.all(color: Colors.white),
                  child: Txt(
                    text: "Lihat gambar",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  popUpLihatGambar(BuildContext context) {
    showModalBottomSheet(
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return SizedBox(
              height: 500,
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
                          const SizedBox(
                            height: 20.0,
                          ),
                          Cntr(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            height: 260,
                            width: Get.width,
                            image: const DecorationImage(
                              image: NetworkImage(
                                  'https://picsum.photos/200/300/?blur'),
                            ),
                          ),
                          const SizedBox(
                            height: 22.0,
                          ),
                          ButtonGradient(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            label: "Kembali",
                            onPressed: () {
                              Get.back();
                            },
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                        ])
                  ]));
        });
  }

  Cntr dataPemesanNurse() {
    return Cntr(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      alignment: Alignment.centerLeft,
      width: Get.width,
      color: const Color(0xffF4F4F4),
      radius: BorderRadius.circular(10),
      child: ExpansionTile(
          title: Txt(
            text: 'Data pemesan',
            weight: FontWeight.bold,
          ),
          children: [
            Cntr(
              color: const Color(0xffF4F4F4),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              radius: BorderRadius.circular(10),
              width: Get.width,
              child: Column(
                children: [
                  Image.network(
                    widget.data['order']['patient_image'],
                    height: 150,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Txt(
                        text: 'Nama',
                        size: 12,
                        color: Colors.grey,
                      ),
                      Txt(
                        text: widget.data['order']['name'],
                        size: 10,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Txt(
                        text: 'Jenis Kelamin',
                        size: 12,
                        color: Colors.grey,
                      ),
                      Txt(
                        text: widget.data['order']['gender'],
                        size: 10,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Txt(
                        text: 'Umur',
                        size: 12,
                        color: Colors.grey,
                      ),
                      Txt(
                        text: "${widget.data['order']['old']} Tahun",
                        size: 10,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Cntr(
                    padding: const EdgeInsets.all(15),
                    height: 80,
                    width: Get.width,
                    border: Border.all(color: const Color(0xffE2E2E2)),
                    radius: BorderRadius.circular(10),
                    child: Txt(
                      text: widget.data['order']['description'],
                      size: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ButtonGradient(
                      margin: EdgeInsets.zero,
                      label: 'Lihat lokasi pasien',
                      onPressed: () async {
                        // await MapsLauncher.launchCoordinates(
                        //     Get.find<HomeController>().lat.value,
                        //     Get.find<HomeController>().long.value,
                        //     Get.find<HomeController>().address.value);
                      })
                ],
              ),
            ),
          ]),
    );
  }

  Cntr namaPerawat() {
    return Cntr(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      radius: BorderRadius.circular(10),
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 26),
      gradient: AppColor.gradient1,
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Txt(
                        text: 'Detail Perawat',
                        size: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Txt(
                        text: widget.data['order']['nurse']['name'],
                        weight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Txt(
                        text:
                            'Umur    :  ${widget.data['order']['nurse']['old']} tahun',
                        size: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Txt(
                        text:
                            'No STR :  ${widget.data['order']['nurse']['register_number_nurse']}',
                        size: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                  Cntr(
                    radius: BorderRadius.circular(100),
                    height: 80,
                    width: 80,
                    image: DecorationImage(
                        image: NetworkImage(widget.data['order']['nurse']
                                ['image'] ??
                            'https://fastly.picsum.photos/id/201/200/300.jpg?blur=2&hmac=Bk1YAURRJgndPj6oL1nVMMPuskT1OVuu7itxEp71aH4'),
                        fit: BoxFit.cover),
                    border: Border.all(color: Colors.white, width: 4),
                  ),

                  // const Icon(
                  //   Icons.access_time_filled_outlined,
                  //   color: Colors.white,
                  //   size: 40,
                  // )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
  Cntr namaHospital(){
    return Cntr(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      radius: BorderRadius.circular(10),
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      gradient: AppColor.gradient1,
      child: Column(
        children: [
          Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Cntr(
                        color: Colors.transparent,
                        height: 40, width: 40, image: DecorationImage(image: NetworkImage(widget.data['order']['service']['image']),fit: BoxFit.cover),),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Txt(
                        text: widget.data['order']['nurse']['name'],
                        weight: FontWeight.bold,
                        color: Colors.white,
                      ),
                        Txt(
                        text: widget.data['order']['nurse']['hospital']['name'],
                        size: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Cntr(
                    radius: BorderRadius.circular(5),
                    width: Get.width,
                    padding: const EdgeInsets.all(15),
                  child: Txt(text: widget.data['order']['nurse']['description']),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class Rating extends StatelessWidget {
  Rating({Key? key, this.rating, this.deskripsi}) : super(key: key);

  double? rating;
  String? deskripsi;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(top: 20.0, bottom: 20),
        //   child:
        //       Center(child: Image.asset('assets/icon/icon_order_finish.png')),
        // ),
        // Center(
        //     child: Text(
        //   'Konsultasi Selesai',
        //   style: blackTextStyle.copyWith(fontWeight: bold),
        // )),
        // Center(
        //     child: Text(
        //   'Sesi konsultasi telah selesai',
        //   style: subtitleTextStyle.copyWith(fontWeight: normal),
        // )),
        // const SizedBox(
        //   height: 20,
        // ),
        Center(
          child: RatingBar.builder(
            ignoreGestures: true,
            initialRating: double.parse(rating.toString()),
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {},
          ),
        ),
        // SizedBox(
        //   // alignment: Alignment.center,
        //   width: 400,
        //   height: 50,
        //   child: SizedBox(
        //       height: 50,
        //       child: ListView.builder(
        //         // padding: const EdgeInsets.all(10),
        //         itemCount: 5,
        //         // physics: NeverScrollableScrollPhysics(),
        //         scrollDirection: Axis.horizontal,
        //         itemBuilder: (context, index) =>
        //             InkWell(
        //               onTap: (){
        //                 Get.put(DetailController()).selected.toggle();
        //               },
        //               child: Obx(()=> Get.put(DetailController()).selected.isFalse? Image.asset('assets/icon/icon_staron.png') : Image.asset('assets/icon/icon_staroff.png'))),
        //       )),
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   children: [
        //     Image.asset('assets/icon/icon_staron.png'),
        //     Image.asset('assets/icon/icon_staron.png'),
        //     Image.asset('assets/icon/icon_staron.png'),
        //     Image.asset('assets/icon/icon_staroff.png'),
        //     Image.asset('assets/icon/icon_staroff.png'),
        //   ],
        // ),
        const SizedBox(
          height: 20,
        ),
        const Text('Deskripsi'),
        const SizedBox(
          height: 10,
        ),Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey[400]!)),
            child: Text(deskripsi ?? "")),
      ],
    );
  }
}
