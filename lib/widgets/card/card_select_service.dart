// ignore_for_file: prefer_interpolation_to_compose_strings, duplicate_ignore

import 'dart:developer';

import 'package:bionmed_app/constant/helper.dart';
import 'package:bionmed_app/screens/layanan_nurse_home/controller/input_layanan_controller.dart';
import 'package:bionmed_app/screens/layanan_nurse_home/controller/waiting_respon_nurse_controller.dart';
import 'package:bionmed_app/screens/payment/controller_payment.dart';
import 'package:bionmed_app/screens/pilih_jadwal/controllers/pilih_jadwal_controller.dart';
import 'package:bionmed_app/screens/pilih_jadwal/views/pilih_jadwal_nurse.dart';
import 'package:bionmed_app/screens/pilih_jadwal/views/pilih_jadwal_view.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:bionmed_app/widgets/container/container.dart';
import 'package:bionmed_app/widgets/txt/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constant/colors.dart';
import '../../constant/styles.dart';

class CardSelectService extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  // ignore: prefer_typing_uninitialized_variables
  final dataNurse;
  // ignore: prefer_typing_uninitialized_variables
  final dataPaketFilter;
  // ignore: prefer_typing_uninitialized_variables
  final paketNurseSop;
  CardSelectService(
      {Key? key,
      this.data,
      this.dataNurse,
      this.dataPaketFilter,
      this.paketNurseSop})
      : super(key: key);
  final inputC = Get.put(InputLayananController());
  final waitingC = Get.put(WaitingResponNurseController());

  // void confirmSelect(context) {
  //   Get.bottomSheet(
  //     // ignore: avoid_unnecessary_containers
  //     Container(
  //       child: SingleChildScrollView(
  //         child: Column(
  //           // crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Container(
  //               height: 4,
  //               margin: const EdgeInsets.all(10),
  //               width: MediaQuery.of(context).size.width / 5,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(20),
  //                 color: AppColor.bodyColor[300],
  //               ),
  //             ),
  //             const SizedBox(height: 10),
  //             Text(
  //               "Apakah kamu yakin memilih \nlayanan ini ?",
  //               style: TextStyles.body2,
  //               textAlign: TextAlign.center,
  //             ),
  //             const SizedBox(height: 18),
  //             Padding(
  //               padding: EdgeInsets.symmetric(horizontal: defaultPadding),
  //               child: ButtonGradient(
  //                 onPressed: () async {
  //                   Get.back();
  //                   var cekService = await Get.find<ControllerPayment>()
  //                       .addOrder(
  //                           date: Get.find<ControllerPayment>().dates.value,
  //                           time: Get.find<ControllerPayment>().times.value);
  //                   if (cekService != 17) {
  //                     Get.to(const PaymentScreen());
  //                   } else {
  //                     Get.to(const PagePesananDoctorOnCall());
  //                   }
  //                 },
  //                 label: "Ya, Saya yakin",
  //                 enable: true,
  //               ),
  //             ),
  //             const SizedBox(height: 14),
  //             Padding(
  //               padding: EdgeInsets.symmetric(horizontal: defaultPadding),
  //               child: ButtonPrimary(
  //                 onPressed: () {
  //                   print(
  //                       'object ${Get.find<ControllerPayment>().times.value}');
  //                   Get.back();
  //                 },
  //                 label: "Tidak",
  //                 enable: true,
  //                 color: AppColor.weakColor,
  //               ),
  //             ),
  //             const SizedBox(height: 26),
  //           ],
  //         ),
  //       ),
  //     ),
  //     barrierColor: AppColor.bodyColor.withOpacity(0.75),
  //     backgroundColor: Colors.white,
  //     isDismissible: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(25),
  //         topRight: Radius.circular(25),
  //       ),
  //     ),
  //   );
  // }

  void confirmSelectNurse() {
    Get.bottomSheet(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              Txt(
                text: 'Scope of Work',
                size: 16,
                weight: FontWeight.bold,
              ),
              Cntr(
                radius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                height: Get.height / 2.4,
                width: Get.width,
                color: Colors.white,
                child: ListView.builder(
                  itemCount:
                      dataPaketFilter['package']['package_nurse_sops'].length,
                  itemBuilder: (context, index) => ListTile(
                    leading: SizedBox(
                        height: 50,
                        width: 50,
                        child: 
                        Image.network(dataPaketFilter['package']
                                ['package_nurse_sops'][index]
                            ['nurse_work_scope']['icon'])),
                    title: Txt(
                        text: dataPaketFilter['package']['package_nurse_sops']
                            [index]['nurse_work_scope']['name']),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Obx(
                    () => ButtonGradient(
                        onPressed: () async {
                          DateFormat dateFormat =
                              DateFormat("yyyy-MM-dd HH:mm:ss");
                          final myC = Get.put(PilihJadwalController());

                          myC.servicePriceId.value = data['package_nurse_sops']
                              [0]['servicePriceNurseId'];
                              // log(data.toString());
                          myC.dateTimeNow.value =
                              dateFormat.format(DateTime.now()).toString();

                          // if (inputC.isloading.isFalse) {
                          //   if (waitingC.nurseReciveOrderStatus.value == 2) {
                          //     await waitingC.updateOrderNurse();
                          //   } else {
                          //     await inputC.addOrderNurse(
                          //         diskon: data['discount'].toString(),
                          //         nurseId: inputC.detailNurse['id'].toString(),
                          //         serviceNurseId: inputC.serviceNurseId.value);
                          inputC.diskonPesananNurse.value =
                              dataPaketFilter['package']['discount'];
                          //   }
                          //   // Get.to(() => const PaymentScreenNurse());
                          //   //  Get.find<WaitingResponNurseController>().getOrderDetailNurse(Get.find<ControllerPayment>().dataOrder['id']);
                          // }
                          // Get.to(() => WaitingResponNurse());
                          // log('message UY      === ' + "https://sandbox-kit.espay.id/index/order/?url=https://www.bionmed.id/payment/success?type='${Get.find<ControllerPayment>().labelPay.value}'&code='${Get.find<ControllerPayment>().codeOrder.value}'&paymentId='${Get.find<ControllerPayment>().codeOrder.value}&commCode=SGWBIONMED&bankCode='${Get.find<ControllerPayment>().vaValue.value}&productCode='${Get.find<ControllerPayment>().labelPay.value}");
                          Get.to(() => const PilihJadwalViewNurse());
                        },
                        label: inputC.isloading.isTrue
                            ? "Loading.."
                            : "Setuju & Lanjutkan"),
                  ))
            ],
          ),
        ));
  }

  void confirmSelect(context) {
    Get.bottomSheet(
      // ignore: avoid_unnecessary_containers
      Container(
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                margin: const EdgeInsets.all(10),
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColor.bodyColor[300],
                ),
              ),
              Text(
                "Pilih Paket Layanan",
                style: TextStyles.body2,
                textAlign: TextAlign.center,
              ),
              verticalSpace(20),
              Obx((() => Get.find<ControllerPayment>().dataServicePrice.isEmpty
                  ? Visibility(
                      visible: Get.find<ControllerPayment>()
                          .dataServicePrice
                          .isEmpty,
                      child: SizedBox(
                          height: 150,
                          child: ListView.builder(
                            itemCount: 1,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () async {
                                  // log(data.toString())
                                  DateFormat dateFormat =
                                      DateFormat("yyyy-MM-dd HH:mm:ss");

                                  final myC = Get.put(PilihJadwalController());
                                  myC.namaLayanan.value =
                                      data['name'].toString();
                                  myC.serviceId.value = data['serviceId'];
                                  myC.servicePriceId.value = data['id'];
                                  myC.docterId.value =
                                      Get.find<ControllerPayment>()
                                          .dataPayloadOrder['doctorId'];
                                  //  data['doctorId'];
                                  myC.durasiLayanan.value =
                                      data['minute'].toString();
                                  myC.hargaKonsultasi.value =
                                      data['price'].toString();
                                  myC.diskon.value = data['discount'];
                                  myC.totalBiaya.value = (data['price'] -
                                      (data['price'] * data['discount'] / 100));
                                  myC.totalBiayaFix.value =
                                      myC.totalBiaya.value.toInt();
                                  myC.dateTimeNow.value = dateFormat
                                      .format(DateTime.now())
                                      .toString();

                                  // if (myC.namaLayanan.value == "Home Visit") {
                                  //   await Get.find<PilihJadwalController>()
                                  //       .getSchedule();
                                  //   myC.idService.value =
                                  //       myC.dataJadwal[index]['id'];
                                  //   await Get.find<ControllerPayment>()
                                  //       .addOrderHomeVisit();
                                  //   Get.find<ControllerPayment>().dates.value =
                                  //       "";
                                  //   Get.find<ControllerPayment>().times.value =
                                  //       "";
                                  //   Get.find<ControllerPayment>().updateOrder(
                                  //       name: Get.find<ControllerPesanan>()
                                  //           .nama
                                  //           .text,
                                  //       age: Get.find<ControllerPesanan>()
                                  //           .usia
                                  //           .text,
                                  //       gender: Get.find<ControllerPesanan>()
                                  //           .genderHome,
                                  //       phoneNumber:
                                  //           Get.find<ControllerPesanan>()
                                  //               .noTel
                                  //               .text,
                                  //       address: Get.find<MapsController>()
                                  //           .alamatLengkapSendAPI
                                  //           .value,
                                  //       description:
                                  //           Get.find<ControllerPesanan>()
                                  //               .desc
                                  //               .text);
                                  //   // Get.to(()=>const PagePesananDoctorOnCall());
                                  //   print("WUW __ " +
                                  //       myC.idService.value.toString());
                                  // } else {
                                  // }
                                  Get.to(() => const PilihJadwalView());

                                  // await myC.registerSlot(date: myC.startDate.value);
                                  // Get.back();
                                  // var cekService = await Get.find<ControllerPayment>()
                                  //     .addOrder(
                                  //         date: Get.find<ControllerPayment>().dates.value,
                                  //         time: Get.find<ControllerPayment>().times.value);
                                  // if (cekService != 17) {
                                  //   Get.to(const PaymentScreen());
                                  // } else {
                                  //   Get.to(const PagePesananDoctorOnCall());
                                  // }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: AppColor.gradient1,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "Paket :",
                                              style: TextStyles.body2.copyWith(
                                                  color: AppColor.whiteColor),
                                              textAlign: TextAlign.center,
                                            ),
                                            data['name'] == 'Home Visit'
                                                ? const SizedBox(
                                                    height: 1.0,
                                                  )
                                                : Row(
                                                    children: [
                                                      Text(
                                                        data['minute']
                                                                .toString() +
                                                            " ",
                                                        style: TextStyles
                                                            .subtitle2
                                                            .copyWith(
                                                                color: AppColor
                                                                    .whiteColor),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      Text(
                                                        "Menit",
                                                        style: TextStyles.body2
                                                            .copyWith(
                                                                color: AppColor
                                                                    .whiteColor),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              //     ? priceFormat(double.parse(data['price'])) :
                                              //     priceFormat(double.parse(( data['price'] - (data['price'] *
                                              //                  data['discount'] /
                                              //                 100))
                                              //             .toString())),
                                              data['discount'] == 0
                                                  ? priceFormat((data['price']))
                                                  : priceFormat(double.parse((data[
                                                              'price'] -
                                                          (data['price'] *
                                                              data['discount'] /
                                                              100))
                                                      .toString())),
                                              // (data['price']*data['discount']/100).toString(),
                                              style: TextStyles.subtitle2
                                                  .copyWith(
                                                      color:
                                                          AppColor.whiteColor),
                                              textAlign: TextAlign.center,
                                            ),
                                            verticalSpace(5),
                                            Visibility(
                                              visible:
                                                  data['discount'].toString() !=
                                                      "0",
                                              child: Row(
                                                children: [
                                                  Text(
                                                    priceFormat(data['price']),
                                                    style: TextStyles.body2
                                                        .copyWith(
                                                      color: AppColor.redColor,
                                                      fontSize: 12,
                                                      decoration: TextDecoration
                                                          .combine([
                                                        TextDecoration
                                                            .lineThrough
                                                      ]),
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  horizontalSpace(5),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color:
                                                            AppColor.whiteColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: Text(
                                                        data['discount']
                                                                .toString() +
                                                            "% Disc",
                                                        style: TextStyles
                                                            .subtitle2
                                                            .copyWith(
                                                                color: AppColor
                                                                    .yellowColor),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )))
                  : Visibility(
                      visible: Get.find<ControllerPayment>()
                          .dataServicePrice
                          .isNotEmpty,
                      child: SizedBox(
                        height: 300.0,
                        child: ListView.builder(
                          itemCount: Get.find<ControllerPayment>()
                              .dataServicePrice
                              .length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () async {
                                DateFormat dateFormat =
                                    DateFormat("yyyy-MM-dd HH:mm:ss");

                                // Get.back();
                                // var cekService = await Get.find<ControllerPayment>()
                                //     .addOrder(
                                //         date: Get.find<ControllerPayment>().dates.value,
                                //         time: Get.find<ControllerPayment>().times.value);
                                // if (cekService != 17) {
                                //   // Get.to(const PaymentScreen());
                                // Get.to(()=> PilihJadwalView());
                                // print('object');

                                // } else {
                                //   print('object');
                                //   // Get.to(const PagePesananDoctorOnCall());
                                // }

                                final myC = Get.put(PilihJadwalController());
                                myC.namaLayanan.value =
                                    Get.find<ControllerPayment>()
                                        .dataServicePrice[index]['name']
                                        .toString();
                                myC.serviceId.value =
                                    Get.find<ControllerPayment>()
                                        .dataServicePrice[index]['serviceId'];
                                myC.servicePriceId.value =
                                    Get.find<ControllerPayment>()
                                        .dataServicePrice[index]['id'];
                                myC.docterId.value =
                                    Get.find<ControllerPayment>()
                                        .dataServicePrice[index]['doctorId'];
                                myC.durasiLayanan.value =
                                    Get.find<ControllerPayment>()
                                        .dataServicePrice[index]['minute']
                                        .toString();
                                myC.hargaKonsultasi.value =
                                    Get.find<ControllerPayment>()
                                        .dataServicePrice[index]['price']
                                        .toString();
                                myC.diskon.value = Get.find<ControllerPayment>()
                                    .dataServicePrice[index]['discount'];
                                myC.totalBiaya.value =
                                    (Get.find<ControllerPayment>()
                                            .dataServicePrice[index]['price'] -
                                        (Get.find<ControllerPayment>()
                                                    .dataServicePrice[index]
                                                ['price'] *
                                            Get.find<ControllerPayment>()
                                                    .dataServicePrice[index]
                                                ['discount'] /
                                            100));
                                myC.totalBiayaFix.value =
                                    myC.totalBiaya.value.toInt();
                                myC.dateTimeNow.value = dateFormat
                                    .format(DateTime.now())
                                    .toString();

                                // if (myC.namaLayanan.value == "Home Visit") {
                                //   await Get.find<PilihJadwalController>()
                                //       .getSchedule();
                                //   myC.idService.value =
                                //       myC.dataJadwal[index]['id'];

                                //   // Get.to(()=>const PagePesananDoctorOnCall());
                                //   await Get.find<PilihJadwalController>()
                                //       .getSchedule();
                                //   myC.idService.value =
                                //       myC.dataJadwal[index]['id'];
                                //   await Get.find<ControllerPayment>()
                                //       .addOrderHomeVisit();
                                //   Get.find<ControllerPayment>().dates.value =
                                //       "";
                                //   Get.find<ControllerPayment>().times.value =
                                //       "";
                                //   Get.find<ControllerPayment>().updateOrder(
                                //       name: Get.find<ControllerPesanan>()
                                //           .nama
                                //           .text,
                                //       age: Get.find<ControllerPesanan>()
                                //           .usia
                                //           .text,
                                //       gender: Get.find<ControllerPesanan>()
                                //           .genderHome,
                                //       phoneNumber: Get.find<ControllerPesanan>()
                                //           .noTel
                                //           .text,
                                //       address: Get.find<MapsController>()
                                //           .alamatLengkapSendAPI
                                //           .value,
                                //       description: Get.find<ControllerPesanan>()
                                //           .desc
                                //           .text);
                                // } else {
                                // }
                                Get.to(() => const PilihJadwalView());
                                // await myC.registerSlot(date: myC.startDate.value);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: AppColor.gradient1,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        gradient: AppColor.gradient1,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                "Paket :",
                                                style: TextStyles.body2
                                                    .copyWith(
                                                        color: AppColor
                                                            .whiteColor),
                                                textAlign: TextAlign.center,
                                              ),
                                              Get.find<ControllerPayment>()
                                                              .dataServicePrice[
                                                          index]['name'] ==
                                                      "Home Visit"
                                                  ? const SizedBox(
                                                      height: 1.0,
                                                    )
                                                  : Row(
                                                      children: [
                                                        Text(
                                                          Get.find<ControllerPayment>()
                                                                  .dataServicePrice[
                                                                      index]
                                                                      ['minute']
                                                                  .toString() +
                                                              " ",
                                                          style: TextStyles
                                                              .subtitle2
                                                              .copyWith(
                                                                  color: AppColor
                                                                      .whiteColor),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        Text(
                                                          "Menit",
                                                          style: TextStyles
                                                              .body2
                                                              .copyWith(
                                                                  color: AppColor
                                                                      .whiteColor),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                Get.find<ControllerPayment>()
                                                            .dataServicePrice[index]
                                                                ['discount']
                                                            .toString() ==
                                                        "0"
                                                    ? priceFormat(
                                                        Get.find<ControllerPayment>()
                                                                .dataServicePrice[index]
                                                            ['price'])
                                                    : priceFormat(double.parse((Get.find<ControllerPayment>()
                                                                    .dataServicePrice[index]
                                                                ['price'] -
                                                            (Get.find<ControllerPayment>().dataServicePrice[index]
                                                                    ['price'] *
                                                                Get.find<ControllerPayment>().dataServicePrice[index]
                                                                    ['discount'] /
                                                                100))
                                                        .toString())),
                                                style: TextStyles.subtitle2
                                                    .copyWith(
                                                        color: AppColor
                                                            .whiteColor),
                                                textAlign: TextAlign.center,
                                              ),
                                              verticalSpace(5),
                                              Visibility(
                                                visible: Get.find<
                                                            ControllerPayment>()
                                                        .dataServicePrice[index]
                                                            ['discount']
                                                        .toString() !=
                                                    "0",
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      priceFormat(Get.find<
                                                                  ControllerPayment>()
                                                              .dataServicePrice[
                                                          index]['price']),
                                                      style: TextStyles.body2
                                                          .copyWith(
                                                        color:
                                                            AppColor.redColor,
                                                        fontSize: 12,
                                                        decoration:
                                                            TextDecoration
                                                                .combine([
                                                          TextDecoration
                                                              .lineThrough
                                                        ]),
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    horizontalSpace(5),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: AppColor
                                                              .whiteColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                        child: Text(
                                                          Get.find<ControllerPayment>()
                                                                  .dataServicePrice[
                                                                      index][
                                                                      'discount']
                                                                  .toString() +
                                                              "% Disc",
                                                          style: TextStyles
                                                              .subtitle2
                                                              .copyWith(
                                                                  color: AppColor
                                                                      .yellowColor),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //
                    ))),
            ],
          ),
        ),
      ),
      barrierColor: AppColor.bodyColor.withOpacity(0.75),
      backgroundColor: Colors.white,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        log(data['price'].toString());
        // await inputC.getNurseWorkScopeDetail(data['id'].toString());
        Get.find<ControllerPayment>().dataPayloadOrder['totalPrice'] =
            data['price'];
        Get.find<ControllerPayment>().dataPayloadOrder['discount'] =
            data['price'] * data['discount'] / 100;
        Get.find<ControllerPayment>().dataPayloadOrder['servicePriceId'] =
            data['id'];
        var datas = await Get.find<ControllerPayment>()
            .getServicePriceByDoctor(id: data['id'].toString());
        if (datas != null) {
          log(datas.toString());
          if (
              // Get.find<ControllerPayment>().serviceId.value == 4
              Get.find<ControllerPayment>().sequenceId.value == 4 || Get.find<ControllerPayment>().sequenceId.value == 5 ||  Get.find<ControllerPayment>().sequenceId.value == 6 ) {
            Get.put(InputLayananController()).totalPrice.value =
                '${(dataPaketFilter['package']['price'] - (dataPaketFilter['package']['price'] * dataPaketFilter['package']['discount'] / 100))}';
            Get.put(InputLayananController()).totalPriceDouble.value =
                double.parse(
                    Get.put(InputLayananController()).totalPrice.value);
            //
            inputC.serviceNurseId.value = dataPaketFilter['package']['id'].toString();
            inputC.priceBeforeDiskon.value =
               dataPaketFilter['package']['price'].toString();
            Get.put(InputLayananController()).totalPriceFix.value =
                Get.put(InputLayananController()).totalPriceDouble.toInt();
          }

          log('Total Price ' + Get.put(InputLayananController()).totalPrice.value);
          log('YEE ' +
              Get.put(InputLayananController())
                  .serviceNurseId
                  .value
                  .toString());
          // ignore: use_build_context_synchronously
          if (
              // Get.find<ControllerPayment>().serviceId.value == 4
              Get.find<ControllerPayment>().sequenceId.value == 4 ||  Get.find<ControllerPayment>().sequenceId.value == 5 ||  Get.find<ControllerPayment>().sequenceId.value == 6) {
            confirmSelectNurse();
          } else {
            // ignore: use_build_context_synchronously
            confirmSelect(context);
          }
        }
      },
      child:
          // Get.find<ControllerPayment>().serviceId.value == 4
          Get.find<ControllerPayment>().sequenceId.value == 4 ||  Get.find<ControllerPayment>().sequenceId.value == 5 ||  Get.find<ControllerPayment>().sequenceId.value == 6
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: dataPaketFilter['matching'] != 0,
                      child: Cntr(
                        radius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        height: 30,
                        width: 140,
                        color: Colors.amber,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.check_circle,
                              size: 15,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Txt(text: '${dataPaketFilter['matching']}'),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Txt(text: 'Pilihan Sesuai'),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColor.whiteColor,
                          boxShadow: [AppColor.shadow],
                          gradient: AppColor.gradient1),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          // Image.network(data['icon'], height: 30.h, width: 25.w),
                          horizontalSpace(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(dataPaketFilter['package']['name'],
                                  style: TextStyles.body1.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              const SizedBox(height: 6),
                              Visibility(
                                visible: data['name'] != 'Home Visit',
                                child: SizedBox(
                                  width: 250.w,
                                  child: RichText(
                                    // ignore: duplicate_ignore
                                    text: TextSpan(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      text: dataPaketFilter['package']['description'],
                                      style: TextStyles.small1.copyWith(
                                          overflow: TextOverflow.ellipsis,
                                          color: AppColor.whiteColor),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  Txt(
                                    text: dataPaketFilter['package']
                                                ['discount'] ==
                                            0
                                        ? priceFormat(
                                            (dataPaketFilter['package']
                                                ['price']))
                                        : priceFormat(double.parse(
                                            (dataPaketFilter['package']
                                                        ['price'] -
                                                    (dataPaketFilter['package']
                                                            ['price'] *
                                                        dataPaketFilter[
                                                                'package']
                                                            ['discount'] /
                                                        100))
                                                .toString())),
                                    // (CurrencyFormat.convertToIdr(data['price'], 0)),
                                    size: 20,
                                    weight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Visibility(
                                    visible: dataPaketFilter['package']
                                            ['discount'] !=
                                        0,
                                    child: Row(
                                      children: [
                                        //    Txt(
                                        //   text: (CurrencyFormat.convertToIdr(data['price'], 0)),
                                        //   size: 14,weight: FontWeight.bold,
                                        //   color: Colors.white,

                                        // ),
                                        Text.rich(
                                          TextSpan(
                                            text: (CurrencyFormat.convertToIdr(
                                                dataPaketFilter['package']
                                                    ['price'],
                                                0)),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Cntr(
                                            radius: BorderRadius.circular(10),
                                            padding: const EdgeInsets.all(10),
                                            color: Colors.white,
                                            child: Txt(
                                              text:
                                                  '${dataPaketFilter['package']['discount']}%',
                                              color: Colors.red,
                                              weight: FontWeight.bold,
                                            ))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Visibility(
                                visible: dataPaketFilter['package']['name'] == 'Home Visit',
                                child: SizedBox(
                                  width: 250.w,
                                  child: RichText(
                                    text: TextSpan(
                                      text:
                                          'Anda bisa berkonsultasi dengan dokter Via ' +
                                              dataPaketFilter['package']['name'],
                                      style: TextStyles.small1.copyWith(
                                          overflow: TextOverflow.ellipsis,
                                          color: AppColor.bodyColor.shade600),
                                      children: const [],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : 
              
              //TELEMEDICINE
              Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.whiteColor,
                    boxShadow: [AppColor.shadow],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.network(data['icon'], height: 30.h, width: 25.w),
                      horizontalSpace(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data['name'],
                              style: TextStyles.body1
                                  .copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          Visibility(
                            visible: data['name'] != 'Home Visit',
                            child: SizedBox(
                              width: 250.w,
                              child: RichText(
                                // ignore: duplicate_ignore
                                text: TextSpan(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  text:
                                      'Anda bisa berkonsultasi dengan dokter Via ' +
                                          data['name'],
                                  style: TextStyles.small1.copyWith(
                                      overflow: TextOverflow.ellipsis,
                                      color: AppColor.bodyColor.shade600),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: data['name'] == 'Home Visit',
                            child: SizedBox(
                              width: 250.w,
                              child: RichText(
                                text: TextSpan(
                                  text:
                                      'Anda bisa berkonsultasi dengan dokter Via ' +
                                          data['name'],
                                  style: TextStyles.small1.copyWith(
                                      overflow: TextOverflow.ellipsis,
                                      color: AppColor.bodyColor.shade600),
                                  children: const [],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ],
                  ),
                ),
    );
  }
}

class CurrencyFormat {
  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }
}
