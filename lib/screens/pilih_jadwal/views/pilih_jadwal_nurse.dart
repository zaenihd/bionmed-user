// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:bionmed_app/constant/colors.dart';
import 'package:bionmed_app/screens/layanan_nurse_home/controller/input_layanan_controller.dart';
import 'package:bionmed_app/screens/layanan_nurse_home/controller/waiting_respon_nurse_controller.dart';
import 'package:bionmed_app/screens/layanan_nurse_home/view/waiting_respon_nurse.dart';
import 'package:bionmed_app/screens/payment/controller_payment.dart';
import 'package:bionmed_app/screens/pesanan/controller_pesanan.dart';
import 'package:bionmed_app/screens/services/service_on_call.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:bionmed_app/widgets/button/button_primary.dart';
import 'package:bionmed_app/widgets/other/loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/pilih_jadwal_controller.dart';

class PilihJadwalViewNurse extends GetView<PilihJadwalController> {
  const PilihJadwalViewNurse({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final jadwalC = Get.put(PilihJadwalController());
    final detailC = Get.put(InputLayananController());
    final waitingC = Get.put(WaitingResponNurseController());
    controller.getJadwalNurse();
    return Scaffold(
        appBar: AppBar(
          title: InkWell(
              onTap: () {
                controller.getJadwalNurse();
                controller.registerSlotNurse(date: controller.startDate.value);
                // print('zaza ' + controller.servicePriceId.value.toString());
              },
              child: const Text('Pilih Jadwal')),
          centerTitle: false,
        ),
        body: Obx(
          () => controller.isloading.isTrue
              ? Center(
                  child: loadingIndicator(),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15),
                      child: Row(
                        children: [
                          Obx(
                            () => SizedBox(
                              height: 100,
                              width: 100,
                              child: CachedNetworkImage(
                                imageUrl: detailC.detailNurse['hospital'] ==
                                        null
                                    ? detailC.detailNurse['image']
                                    : detailC.detailNurse['hospital']
                                            ['image'] ??
                                        'https://img.freepik.com/free-vector/people-walking-sitting-hospital-building-city-clinic-glass-exterior-flat-vector-illustration-medical-help-emergency-architecture-healthcare-concept_74855-10130.jpg?w=2000&t=st=1694367961~exp=1694368561~hmac=dc0a60debe1925ff62ec0fb9171e5466998617fa775ef32cac6f5113af4dcc42',
                                width: Get.width,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => loadingIndicator(
                                    color: AppColor.primaryColor),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                        'assets/images/img-doctor2.png'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              SizedBox(
                                width: Get.width / 1.8,
                                child: Text(
                                  '${detailC.detailNurse['name']}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              SizedBox(
                                width: Get.width / 1.8,
                                child: Text(
                                  detailC.detailNurse['hospital'] != null
                                      ? detailC.detailNurse['hospital']['name']
                                      :
                                      // '${Get.find<ControllerLogin>().dataDoctorDetail['specialist']['name']}',
                                      "",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 500.0,
                      child: controller.dataJadwal.isEmpty
                          ? Align(
                              alignment: Alignment.center,
                              child: Text('Tidak Ada Jadwal Hari ini'))
                          : ListView.builder(
                              // padding: EdgeInsets.all(10),
                              itemCount: controller.dataJadwal.length,
                              itemBuilder: (context, index) => Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                width: Get.width,
                                height: 60,
                                decoration: const BoxDecoration(
                                    // ignore: unnecessary_const
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12.0),
                                    ),
                                    gradient: AppColor.gradient1),
                                child: ListTile(
                                  leading:
                                      Image.asset('assets/icons/calendar.png'),
                                  title: Text(
                                    '${controller.dataJadwal[index]['startTime']} - ${controller.dataJadwal[index]['endTime']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    color: Colors.white,
                                  ),
                                  onTap: () async {
                                    log(Get.find<InputLayananController>()
                                        .jamTerpilihForSend
                                        .value
                                        .substring(0, 2));
                                    controller.endTime.value =
                                        controller.dataJadwal[index]['endTime'];
                                    controller.idService.value =
                                        controller.dataJadwal[index]['id'];
                                    log('dataa ${controller.idService.value}');
                                    DateTime now = DateTime.now();
                                    controller.dateTimeNowHome.value =
                                        DateFormat('yyyy-MM-dd').format(now);
                                    await controller.registerSlotNurse(
                                        date: controller.startDate.value);
                                    if (controller.namaLayanan.value ==
                                            "Home Visit" ||
                                        Get.find<ControllerPayment>()
                                                .serviceId
                                                .value ==
                                            4 ||
                                        Get.find<ControllerPayment>()
                                                .serviceId
                                                .value ==
                                            5 ||
                                        Get.find<ControllerPayment>()
                                                .serviceId
                                                .value ==
                                            6) {
                                      if (controller.readyBooking.isTrue) {
                                        int hours = int.parse(controller
                                                .startDateCustomer.value
                                                .substring(11, 13)) +
                                            4;
                                        String minute = controller
                                            .startDateCustomer.value
                                            .substring(14, 19);
                                        String date = controller
                                            .startDateCustomer.value
                                            .substring(0, 10);
                                        controller.startDateCustomerHomeVisit
                                                .value =
                                            "$date ${Get.find<InputLayananController>().jamTerpilihForSend.value}";
                                        log('ini adalah star${controller.startDateCustomerHomeVisit.value}');
                                        log("ini adalaah 1 $date $hours:$minute");
                                        log("ini adalaah 1 ${Get.find<InputLayananController>().jamSekarangPlus4JamFix.value}");
                                      }
                                      if (int.parse(jadwalC.startDate.value
                                              .substring(8, 10)) ==
                                          int.parse(controller
                                              .dateTimeNowHome.value
                                              .substring(8, 10))) {
                                        Get.find<ControllerPayment>()
                                                .dateTimeNow
                                                .value =
                                            DateFormat('kk:mm').format(now);
                                        if (int.parse(Get.find<
                                                    InputLayananController>()
                                                .jamTerpilihForSend
                                                .value
                                                .substring(0, 2)) <
                                            Get.find<InputLayananController>()
                                                    .jamSekarangPlus4JamFix
                                                    .value +
                                                4) {
                                          controller.jadwalTerlewat3Jam(
                                              "Pilih Jadwal Lain");
                                        } else {
                                          Get.bottomSheet(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  30),
                                                          topRight:
                                                              Radius.circular(
                                                                  30))),
                                              backgroundColor: Colors.white,
                                              SizedBox(
                                                height: 400,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 24.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            bottom: 18,
                                                            top: 14),
                                                        width: Get.width / 1.9,
                                                        height: 10,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: const Color(
                                                                0xffEDEDED)),
                                                      ),
                                                      const SizedBox(
                                                        height: 20.0,
                                                      ),
                                                      Text(
                                                        controller.readyBooking
                                                                .isTrue
                                                            ? 'Silakan Membayar Untuk\nMendapatkan Jaadwal'
                                                            : "Jadwal Sudah Penuh ",
                                                        textAlign:
                                                            TextAlign.center,
                                                        // 'Jadwal Sudah Penuh',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20.0,
                                                      ),
                                                      Obx(
                                                        () => Image.asset(
                                                          controller
                                                                  .readyBooking
                                                                  .isTrue
                                                              ? "assets/icons/schedule (1) 1.png"
                                                              : "assets/icons/schedule (1) 2.png",
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 17,
                                                      ),
                                                      const SizedBox(
                                                        height: 23,
                                                      ),
                                                      Obx(
                                                        () => ButtonGradient(
                                                            onPressed:
                                                                () async {
                                                              if (controller
                                                                  .readyBooking
                                                                  .isTrue) {
                                                                if (Get.find<
                                                                        ControllerPayment>()
                                                                    .loading
                                                                    .isFalse) {
                                                                  if (detailC
                                                                      .isloading
                                                                      .isFalse) {
                                                                    if (waitingC
                                                                            .nurseReciveOrderStatus
                                                                            .value ==
                                                                        2) {
                                                                      await waitingC
                                                                          .updateOrderNurse();
                                                                    } else {
                                                                      await detailC.addOrderNurse(
                                                                          diskon: detailC
                                                                              .diskonPesananNurse
                                                                              .toString(),
                                                                          nurseId: detailC.detailNurse['id']
                                                                              .toString(),
                                                                          serviceNurseId: detailC
                                                                              .serviceNurseId
                                                                              .value);
                                                                      // detailC.diskonPesananNurse.value =
                                                                      //     data['discount'];
                                                                    }
                                                                    log('harga cok ${detailC.totalPriceFix}');

                                                                    // Get.to(() => const PaymentScreenNurse());
                                                                    //  Get.find<WaitingResponNurseController>().getOrderDetailNurse(Get.find<ControllerPayment>().dataOrder['id']);
                                                                  }

                                                                  Get.to(() =>
                                                                      WaitingResponNurse());
                                                                }
                                                              } else {
                                                                Get.back();
                                                              }
                                                              //          controller.dataJadwal[index]['isActive'] == true ?
                                                              //           Get.find<ControllerPayment>()
                                                              // .addOrder(
                                                              //     date: Get.find<ControllerPayment>().dates.value,
                                                              //     time: Get.find<ControllerPayment>().times.value) : Get.back();
                                                            },
                                                            label: controller
                                                                    .readyBooking
                                                                    .isTrue
                                                                ? detailC
                                                                        .isloading
                                                                        .isFalse
                                                                    ? "Bayar Sekarang"
                                                                    : "Loading...."
                                                                : "Pilih jadwal lain"),
                                                      ),
                                                      const SizedBox(
                                                        height: 17,
                                                      ),
                                                      ButtonPrimary(
                                                          color:
                                                              Colors.grey[400],
                                                          label:
                                                              "Cari Dokter Lainnya",
                                                          onPressed: () {
                                                            Get.to(() =>
                                                                ServiceOnCall(
                                                                  title: Get.find<ControllerPayment>()
                                                                              .nameService
                                                                              .value ==
                                                                          2
                                                                      ? "Personal Doctor"
                                                                      : Get.find<ControllerPayment>().nameService.value ==
                                                                              4
                                                                          ? "Nursing Home"
                                                                          : Get.find<ControllerPayment>().nameService.value == 5
                                                                              ? "Mother Care"
                                                                              : Get.find<ControllerPayment>().nameService.value == 6
                                                                                  ? "Baby Care"
                                                                                  : "Telemedicine",
                                                                ));
                                                          })
                                                    ],
                                                  ),
                                                ),
                                              ));
                                        }
                                      } else {
                                        Get.bottomSheet(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(30),
                                                    topRight:
                                                        Radius.circular(30))),
                                            backgroundColor: Colors.white,
                                            SizedBox(
                                              height: 400,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 24.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 18,
                                                              top: 14),
                                                      width: Get.width / 1.9,
                                                      height: 10,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: const Color(
                                                              0xffEDEDED)),
                                                    ),
                                                    const SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    Text(
                                                      controller.readyBooking
                                                              .isTrue
                                                          ? 'Silakan Membayar Untuk\nMendapatkan Jadwal'
                                                          : "Jadwal Sudah Penuh ",
                                                      textAlign:
                                                          TextAlign.center,
                                                      // 'Jadwal Sudah Penuh',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    Obx(
                                                      () => Image.asset(
                                                        controller.readyBooking
                                                                .isTrue
                                                            ? "assets/icons/schedule (1) 1.png"
                                                            : "assets/icons/schedule (1) 2.png",
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 17,
                                                    ),
                                                    // Obx(
                                                    //   () => controller
                                                    //           .readyBooking
                                                    //           .isTrue
                                                    //       ? Text(
                                                    //           '${controller.startHoursCustomer.value} - ${controller.endHoursCustomer}',
                                                    //           style: TextStyle(
                                                    //               fontSize: 26,
                                                    //               fontWeight: FontWeight.bold,
                                                    //               foreground: Paint()
                                                    //                 ..shader = LinearGradient(
                                                    //                   // ignore: prefer_const_literals_to_create_immutables
                                                    //                   colors: <
                                                    //                       Color>[
                                                    //                     Color(
                                                    //                         0xFF2B88D9),
                                                    //                     Color(
                                                    //                         0XFF26E0F5),
                                                    //                     //add more color here.
                                                    //                   ],
                                                    //                 ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 100.0))),
                                                    //         )
                                                    //       : Text(
                                                    //           'Mohon maaf jadwal dokter sudah\npenuh, silakan cari jadwal lain,',
                                                    //           textAlign:
                                                    //               TextAlign
                                                    //                   .center,
                                                    //         ),
                                                    // ),
                                                    const SizedBox(
                                                      height: 23,
                                                    ),
                                                    Obx(
                                                      () => ButtonGradient(
                                                          onPressed: () async {
                                                            if (controller
                                                                .readyBooking
                                                                .isTrue) {
                                                              if (detailC
                                                                  .isloading
                                                                  .isFalse) {
                                                                if (waitingC
                                                                        .nurseReciveOrderStatus
                                                                        .value ==
                                                                    2) {
                                                                  await waitingC
                                                                      .updateOrderNurse();
                                                                } else {
                                                                  await detailC.addOrderNurse(
                                                                      diskon: detailC
                                                                          .diskonPesananNurse
                                                                          .toString(),
                                                                      nurseId: detailC
                                                                          .detailNurse[
                                                                              'id']
                                                                          .toString(),
                                                                      serviceNurseId: detailC
                                                                          .serviceNurseId
                                                                          .value);
                                                                  // detailC.diskonPesananNurse.value =
                                                                  //     data['discount'];
                                                                }
                                                                log('harga cok ${detailC.totalPriceFix}');

                                                                // Get.to(() => const PaymentScreenNurse());
                                                                //  Get.find<WaitingResponNurseController>().getOrderDetailNurse(Get.find<ControllerPayment>().dataOrder['id']);

                                                                Get.to(() =>
                                                                    WaitingResponNurse());
                                                              }
                                                            } else {
                                                              Get.back();
                                                            }
                                                            //          controller.dataJadwal[index]['isActive'] == true ?
                                                            //           Get.find<ControllerPayment>()
                                                            // .addOrder(
                                                            //     date: Get.find<ControllerPayment>().dates.value,
                                                            //     time: Get.find<ControllerPayment>().times.value) : Get.back();
                                                          },
                                                          label: controller
                                                                  .readyBooking
                                                                  .isTrue
                                                              ? detailC
                                                                      .isloading
                                                                      .isFalse
                                                                  ? "Bayar Sekarang"
                                                                  : "Loading...."
                                                              : "Pilih jadwal lain"),
                                                    ),
                                                    const SizedBox(
                                                      height: 17,
                                                    ),
                                                    ButtonPrimary(
                                                        color: Colors.grey[400],
                                                        label:
                                                            "Cari Dokter Lainnya",
                                                        onPressed: () {
                                                          Get.to(
                                                              () =>
                                                                  ServiceOnCall(
                                                                    title: Get.find<ControllerPayment>().nameService.value ==
                                                                            2
                                                                        ? "Personal Doctor"
                                                                        : Get.find<ControllerPayment>().nameService.value ==
                                                                                4
                                                                            ? "Nursing Home"
                                                                            : Get.find<ControllerPayment>().nameService.value == 5
                                                                                ? "Mother Care"
                                                                                : Get.find<ControllerPayment>().nameService.value == 6
                                                                                    ? "Baby Care"
                                                                                    : "Telemedicine",
                                                                  ));
                                                        })
                                                  ],
                                                ),
                                              ),
                                            ));
                                      }
                                    } else {
                                      Get.bottomSheet(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(30),
                                                  topRight:
                                                      Radius.circular(30))),
                                          backgroundColor: Colors.white,
                                          SizedBox(
                                            height: 400,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 24.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 18,
                                                            top: 14),
                                                    width: Get.width / 1.9,
                                                    height: 10,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: const Color(
                                                            0xffEDEDED)),
                                                  ),
                                                  const SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  Text(
                                                    controller
                                                            .readyBooking.isTrue
                                                        ? 'Silakan Membayar Untuk\nMendapatkan Jadwal'
                                                        : "Jadwal Sudah Penuh ",
                                                    textAlign: TextAlign.center,
                                                    // 'Jadwal Sudah Penuh',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  Obx(
                                                    () => Image.asset(
                                                      controller.readyBooking
                                                              .isTrue
                                                          ? "assets/icons/schedule (1) 1.png"
                                                          : "assets/icons/schedule (1) 2.png",
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 17,
                                                  ),
                                                  const SizedBox(
                                                    height: 23,
                                                  ),
                                                  Obx(
                                                    () => ButtonGradient(
                                                        onPressed: () async {
                                                          if (controller
                                                              .readyBooking
                                                              .isTrue) {
                                                            if (detailC
                                                                .isloading
                                                                .isFalse) {
                                                              if (waitingC
                                                                      .nurseReciveOrderStatus
                                                                      .value ==
                                                                  2) {
                                                                await waitingC
                                                                    .updateOrderNurse();
                                                              } else {
                                                                await detailC.addOrderNurse(
                                                                    diskon: detailC
                                                                        .diskonPesananNurse
                                                                        .toString(),
                                                                    nurseId: detailC
                                                                        .detailNurse[
                                                                            'id']
                                                                        .toString(),
                                                                    serviceNurseId: detailC
                                                                        .serviceNurseId
                                                                        .value);
                                                                // detailC.diskonPesananNurse.value =
                                                                //     data['discount'];
                                                              }
                                                              log('harga cok ${detailC.totalPriceFix}');

                                                              // Get.to(() => const PaymentScreenNurse());
                                                              //  Get.find<WaitingResponNurseController>().getOrderDetailNurse(Get.find<ControllerPayment>().dataOrder['id']);

                                                              Get.to(() =>
                                                                  WaitingResponNurse());
                                                            }
                                                            // if (Get.find<
                                                            //         ControllerPayment>()
                                                            //     .loading
                                                            //     .isFalse) {
                                                            //   await Get.find<
                                                            //           ControllerPayment>()
                                                            //       .addOrder();
                                                            //   Get.to(() =>
                                                            //       PaymentScreen());
                                                            // }
                                                          } else {
                                                            Get.back();
                                                          }
                                                          //          controller.dataJadwal[index]['isActive'] == true ?
                                                          //           Get.find<ControllerPayment>()
                                                          // .addOrder(
                                                          //     date: Get.find<ControllerPayment>().dates.value,
                                                          //     time: Get.find<ControllerPayment>().times.value) : Get.back();
                                                        },
                                                        label: controller
                                                                .readyBooking
                                                                .isTrue
                                                            ? detailC.isloading
                                                                    .isFalse
                                                                ? "Bayar Sekarang"
                                                                : "Loading...."
                                                            : "Pilih jadwal lain"),
                                                  ),
                                                  const SizedBox(
                                                    height: 17,
                                                  ),
                                                  ButtonPrimary(
                                                      color: Colors.grey[400],
                                                      label:
                                                          "Cari Dokter Lainnya",
                                                      onPressed: () {
                                                        Get.to(
                                                            () => ServiceOnCall(
                                                                  title: Get.find<ControllerPayment>()
                                                                              .nameService
                                                                              .value ==
                                                                          2
                                                                      ? "Personal Doctor"
                                                                      : Get.find<ControllerPayment>().nameService.value ==
                                                                              4
                                                                          ? "Nursing Home"
                                                                          : Get.find<ControllerPayment>().nameService.value == 5
                                                                              ? "Mother Care"
                                                                              : Get.find<ControllerPayment>().nameService.value == 6
                                                                                  ? "Baby Care"
                                                                                  : "Telemedicine",
                                                                ));
                                                      })
                                                ],
                                              ),
                                            ),
                                          ));
                                    }
                                    log('ini adalah ${Get.find<ControllerPesanan>().serviceId.value}');
                                  },
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
        ));
  }
}
