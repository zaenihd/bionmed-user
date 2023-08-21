// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:bionmed_app/constant/colors.dart';
import 'package:bionmed_app/screens/login/controller_login.dart';
import 'package:bionmed_app/screens/payment/controller_payment.dart';
import 'package:bionmed_app/screens/payment/payment_screen.dart';
import 'package:bionmed_app/screens/pesanan/controller_pesanan.dart';
import 'package:bionmed_app/screens/pesanan/maps.dart';
import 'package:bionmed_app/screens/services/service_on_call.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:bionmed_app/widgets/button/button_primary.dart';
import 'package:bionmed_app/widgets/other/loading_indicator.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/pilih_jadwal_controller.dart';

class PilihJadwalView extends GetView<PilihJadwalController> {
  const PilihJadwalView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.getSchedule();

    return Scaffold(
        appBar: AppBar(
          title: InkWell(
            onTap: () {
              log('service id ${controller.serviceId.value} idService ${controller.idService.value} servicePriceId ${controller.servicePriceId.value} dokter id ${controller.docterId.value} dateNow : ${controller.dateTimeNow.value} ');
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
                          Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(

                                  // image: DecorationImage(
                                  //     image: NetworkImage(
                                  //         '${Get.find<ControllerLogin>().dataDoctorDetail['image']}}'))
                                  ),
                              child: Image.network(
                                "${Get.find<ControllerLogin>().dataDoctorDetail['image']}",
                                fit: BoxFit.cover,
                              )),
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
                                  '${Get.find<ControllerLogin>().dataDoctorDetail['name']}',
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
                                  '${Get.find<ControllerLogin>().dataDoctorDetail['specialist']['name']}',
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
                                    controller.endTime.value =
                                        controller.dataJadwal[index]['endTime'];
                                    controller.idService.value =
                                        controller.dataJadwal[index]['id'];
                                    DateTime now = DateTime.now();
                                    controller.dateTimeNowHome.value =
                                        DateFormat('yyyy-MM-dd').format(now);
                                        log('dinas date${controller.startDate.value}');
                                        log('dinas dateNow ${controller.dateTimeNow.value}');
                                    await controller.registerSlot(
                                        date: controller.startDate.value);
                                    if (controller.namaLayanan.value ==
                                        "Home Visit" || controller.namaLayanan.value ==
                                        "Nursing Home" ) {
                                          if(controller.readyBooking.isTrue){
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
                                          .value = "$date $hours:$minute";
                                          }
                                      if (int.parse(
                                              Get.find<PilihJadwalController>()
                                                  .startDate
                                                  .value
                                                  .substring(8, 10)) ==
                                          int.parse(controller
                                              .dateTimeNowHome.value
                                              .substring(8, 10))) {
                                        Get.find<ControllerPayment>()
                                                .dateTimeNow
                                                .value =
                                            DateFormat('kk:mm').format(now);
                                        if (int.parse(Get.find<
                                                        ControllerPayment>()
                                                    .dateTimeNow
                                                    .value
                                                    .substring(0, 2)) +
                                                3 >=
                                            int.parse(controller.endTime.value
                                                .substring(0, 2))) {
                                          // showPopUp(
                                          //     labelButton: "Pilih Jadwal Lain",
                                          //     onTap: () {
                                          //       Get.back();
                                          //     },
                                          //     imageAction:
                                          //         'assets/json/eror.json',
                                          //     description:
                                          //         "Jadwal Sudah Terlewatkan\nMohon Pilih Jam Yang Sesuai\n3 Jam Dari Sekarang",
                                          //     onPress: () {
                                          //       Get.back();
                                          //     });
                                          controller.jadwalTerlewat3Jam();

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
                                                      Text(controller.readyBooking
                                                              .isTrue ? 
                                                    'Silakan Membayar Untuk\nMendapatkan Jadwal' : "Jadwal Sudah Penuh ", 
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
                                                            onPressed:
                                                                () async {
                                                              if (controller
                                                                  .readyBooking
                                                                  .isTrue) {
                                                                if (Get.find<
                                                                        ControllerPayment>()
                                                                    .loading
                                                                    .isFalse) {
                                                                  await Get.find<
                                                                          ControllerPayment>()
                                                                      .addOrderHomeVisit();
                                                                  await Get.find<ControllerPayment>().updateOrder(
                                                                      name: Get.find<ControllerPesanan>()
                                                                          .nama
                                                                          .text,
                                                                      age: Get.find<ControllerPesanan>()
                                                                          .usia
                                                                          .text,
                                                                      gender: Get.find<
                                                                              ControllerPesanan>()
                                                                          .genderHome,
                                                                      phoneNumber: Get.find<
                                                                              ControllerPesanan>()
                                                                          .noTel
                                                                          .text,
                                                                      address: Get.find<
                                                                              MapsController>()
                                                                          .alamatLengkapSendAPI
                                                                          .value,
                                                                      description: Get.find<
                                                                              ControllerPesanan>()
                                                                          .desc
                                                                          .text);
                                                                  Get.to(
                                                                      PaymentScreen());
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
                                                                ? Get.find<ControllerPayment>()
                                                                        .loading
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
                                                                  title: Get.find<
                                                                          ControllerPayment>()
                                                                      .nameService
                                                                      .value,
                                                                ));
                                                          })
                                                    ],
                                                  ),
                                                ),
                                              ));
                                        }
                                      }
                                      else{
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
                                                              .isTrue ? 
                                                    'Silakan Membayar Untuk\nMendapatkan Jadwal' : "Jadwal Sudah Penuh ", 
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
                                                            onPressed:
                                                                () async {
                                                              if (controller
                                                                  .readyBooking
                                                                  .isTrue) {
                                                                if (Get.find<
                                                                        ControllerPayment>()
                                                                    .loading
                                                                    .isFalse) {
                                                                  await Get.find<
                                                                          ControllerPayment>()
                                                                      .addOrderHomeVisit();
                                                                  await Get.find<ControllerPayment>().updateOrder(
                                                                      name: Get.find<ControllerPesanan>()
                                                                          .nama
                                                                          .text,
                                                                      age: Get.find<ControllerPesanan>()
                                                                          .usia
                                                                          .text,
                                                                      gender: Get.find<
                                                                              ControllerPesanan>()
                                                                          .genderHome,
                                                                      phoneNumber: Get.find<
                                                                              ControllerPesanan>()
                                                                          .noTel
                                                                          .text,
                                                                      address: Get.find<
                                                                              MapsController>()
                                                                          .alamatLengkapSendAPI
                                                                          .value,
                                                                      description: Get.find<
                                                                              ControllerPesanan>()
                                                                          .desc
                                                                          .text);
                                                                  Get.to(
                                                                      PaymentScreen());
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
                                                                ? Get.find<ControllerPayment>()
                                                                        .loading
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
                                                                  title: Get.find<
                                                                          ControllerPayment>()
                                                                      .nameService
                                                                      .value,
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
                                                     controller.readyBooking
                                                              .isTrue ? 
                                                    'Silakan Membayar Untuk\nMendapatkan Jadwal' : "Jadwal Sudah Penuh ", 
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
                                                  // Obx(
                                                  //   () => controller
                                                  //           .readyBooking.isTrue
                                                  //       ? Text(
                                                  //           '${controller.startHoursCustomer} - ${controller.endHoursCustomer}',
                                                  //           style: TextStyle(
                                                  //               fontSize: 26,
                                                  //               fontWeight:
                                                  //                   FontWeight.bold,
                                                  //               foreground: Paint()
                                                  //                 ..shader =
                                                  //                     LinearGradient(
                                                  //                   // ignore: prefer_const_literals_to_create_immutables
                                                  //                   colors: <Color>[
                                                  //                     Color(
                                                  //                         0xFF2B88D9),
                                                  //                     Color(
                                                  //                         0XFF26E0F5),
                                                  //                     //add more color here.
                                                  //                   ],
                                                  //                 ).createShader(Rect
                                                  //                         .fromLTWH(
                                                  //                             0.0,
                                                  //                             0.0,
                                                  //                             200.0,
                                                  //                             100.0))),
                                                  //         )
                                                  //       : Text(
                                                  //           'Mohon maaf jadwal dokter sudah\npenuh, silakan cari jadwal lain,',
                                                  //           textAlign:
                                                  //               TextAlign.center,
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
                                                            if (Get.find<
                                                                    ControllerPayment>()
                                                                .loading
                                                                .isFalse) {
                                                                await Get.find<
                                                                        ControllerPayment>()
                                                                    .addOrder();
                                                                Get.to(()=>
                                                                    PaymentScreen());
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
                                                            ? Get.find<ControllerPayment>()
                                                                    .loading
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
                                                                  title: Get.find<
                                                                          ControllerPayment>()
                                                                      .nameService
                                                                      .value,
                                                                ));
                                                      })
                                                ],
                                              ),
                                            ),
                                          ));
                                    }
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
