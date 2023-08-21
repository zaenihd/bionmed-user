import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/screens/home/home_controller.dart';
import 'package:bionmed_app/screens/login/controller_login.dart';
import 'package:bionmed_app/screens/pesanan/controller_pesanan.dart';
import 'package:bionmed_app/screens/pesanan/pesanan_detail_screen.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:bionmed_app/widgets/card/card_select_service.dart';
import 'package:bionmed_app/widgets/container/container.dart';
import 'package:bionmed_app/widgets/txt/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constant/colors.dart';

class NotifScreen extends StatefulWidget {
  const NotifScreen({Key? key}) : super(key: key);
  static const routeName = "/notif";

  @override
  State<NotifScreen> createState() => _NotifScreenState();
}

class _NotifScreenState extends State<NotifScreen> {
  final myC = Get.find<ControllerLogin>();

  String title = "Notifikasi";
  final controller = Get.put(HomeController());
  final pesananC = Get.put(ControllerPesanan());


  @override
  Widget build(BuildContext context) {
    Get.find<ControllerLogin>().getNotif();
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: Text(title),
        titleTextStyle: TextStyles.subtitle1,
        elevation: 0.0,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios)),
        // actions: [Icon(Icons.arrow_back_ios)],
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColor.gradient1,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => Get.find<ControllerLogin>().dataNotif.isEmpty
              ? const Center(
                  child: Text('Tidak Ada Pesan'),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Get.find<ControllerLogin>().dataNotif.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.asset(Get.find<ControllerLogin>()
                                        .dataNotif[index]['title'] ==
                                    "Pembayaran berhasil !"
                                ? 'assets/icons/ic_notif_berhasil.png'
                                : Get.find<ControllerLogin>().dataNotif[index]['title'] ==
                                            "Terjadwalkan" ||
                                        Get.find<ControllerLogin>().dataNotif[index]
                                                ['title'] ==
                                            "Pesanan Terjadwalkan" ||
                                        Get.find<ControllerLogin>().dataNotif[index]
                                                ['title'] ==
                                            "Pesanan Reschedule"
                                    ? 'assets/icons/ic_notif_terjadwal.png'
                                    : Get.find<ControllerLogin>().dataNotif[index]
                                                ['title'] ==
                                            "Mulai Sekarang"
                                        ? 'assets/icons/ic_notif_berlangsung.png'
                                        : Get.find<ControllerLogin>().dataNotif[index]
                                                    ['title'] ==
                                                "Selesaikan pembayaran anda"
                                            ? 'assets/icons/ic_notif_gagal.png'
                                            : Get.find<ControllerLogin>().dataNotif[index]['title'] == "Berlangsung" || Get.find<ControllerLogin>().dataNotif[index]['title'] == "Layanan Berlangsung"
                                                ? 'assets/icons/ic_notif_berlangsung.png'
                                                : Get.find<ControllerLogin>().dataNotif[index]['title'] == "Waktu layanan dimulai"
                                                    ? 'assets/icons/ic_notif_berlangsung.png'
                                                    : Get.find<ControllerLogin>().dataNotif[index]['title'] == "Konfirmasi Selesai"
                                                        ? 'assets/icons/ic_notif_konfirmasi.png'
                                                        : Get.find<ControllerLogin>().dataNotif[index]['title'] == "Selesai"
                                                            ? 'assets/icons/ic_notif_selesai.png'
                                                            : Get.find<ControllerLogin>().dataNotif[index]['title'] == "Belum Bayar"
                                                                ? 'assets/icons/belum_bayar.png'
                                                                : 'assets/icons/ic_notif_pesanan_gagal.png'),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => Row(
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: AutoSizeText(
                                        Get.find<ControllerLogin>()
                                            .dataNotif[index]['title'],
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.bodyColor,
                                          // overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    horizontalSpace(5),
                                    Get.find<ControllerLogin>().dataNotif[index]
                                                ['status'] ==
                                            1
                                        ? const Icon(
                                            Icons.circle,
                                            color: AppColor.redColor,
                                            size: 10,
                                          )
                                        : verticalSpace(0)
                                  ],
                                ),
                              ),
                              verticalSpace(5),
                              SizedBox(
                                width: Get.width / 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Lihat detail pemberitahuan',
                                      // Get.find<ControllerLogin>()
                                      //     .dataNotif[index]['description'],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.bodyColor,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                Get.find<HomeController>().inboxId.value =
                                    Get.find<ControllerLogin>().dataNotif[index]
                                        ['id'];
                                Get.defaultDialog(
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text('Kembali')),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red),
                                          onPressed: () async {
                                            if (Get.find<ControllerLogin>()
                                                        .dataNotif[index]
                                                    ['order'] ==
                                                null) {
                                              await Get.find<HomeController>()
                                                  .hapusPesanNurse();
                                              await Get.find<ControllerLogin>()
                                                  .getNotif();
                                            } else {
                                              await Get.find<HomeController>()
                                                  .hapusPesan();
                                              await Get.find<ControllerLogin>()
                                                  .getNotif();
                                            }
                                            Get.back();
                                          },
                                          child: const Text('Hapus'))
                                    ],
                                    title: "Hapus Pesan",
                                    middleText:
                                        "Apakah Anda yakin\nMenghapus Pesan ini?");
                              },
                              icon: const Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                              )),
                        ),
                      ),
                      onTap: () async {
                        
                        // await Get.find<ControllerPesanan>()
                        //     .getOrderAll(status: 0);
                        Get.find<HomeController>().inboxId.value =
                            Get.find<ControllerLogin>().dataNotif[index]['id'];
                        if (Get.find<ControllerLogin>().dataNotif[index]
                                ['order'] ==
                            null) {
                          await Get.find<HomeController>().readNotifNurse(
                              id: Get.find<ControllerLogin>()
                                  .dataNotif[index]['id']
                                  .toString());
                                  
                                   pesananC.idOrder.value = Get.find<ControllerLogin>()
                                  .dataNotif[index]['nurse_order']['id'];
                        pesananC.getDetailOrderNurse();

                        } else {
                          await Get.find<HomeController>().readNitif(
                              id: Get.find<ControllerLogin>()
                                  .dataNotif[index]['id']
                                  .toString());
                        }

                        // Get.find<ControllerLogin>().getNotif();

                        showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              // <-- SEE HERE
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.0),
                              ),
                            ),
                            builder: (context) {
                              return SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                              color:
                                                  AppColor.bodyColor.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ],
                                    ),
                                    verticalSpace(20),
                                    Center(
                                      child: Column(
                                        children: [
                                          Image.asset(Get.find<ControllerLogin>()
                                                          .dataNotif[index]
                                                      ['title'] ==
                                                  "Pembayaran berhasil !"
                                              ? 'assets/icons/ic_notif_berhasil.png'
                                              : Get.find<ControllerLogin>().dataNotif[index]
                                                              ['title'] ==
                                                          "Terjadwalkan" ||
                                                      Get.find<ControllerLogin>().dataNotif[index]
                                                              ['title'] ==
                                                          "Pesanan Terjadwalkan" ||
                                                      Get.find<ControllerLogin>().dataNotif[index]
                                                              ['title'] ==
                                                          "Pesanan Reschedule"
                                                  ? 'assets/icons/ic_notif_terjadwal.png'
                                                  : Get.find<ControllerLogin>().dataNotif[index]
                                                              ['title'] ==
                                                          "Mulai Sekarang"
                                                      ? 'assets/icons/ic_notif_muali.png'
                                                      : Get.find<ControllerLogin>().dataNotif[index]
                                                                  ['title'] ==
                                                              "Selesaikan pembayaran anda"
                                                          ? 'assets/icons/ic_notif_gagal.png'
                                                          : Get.find<ControllerLogin>().dataNotif[index]['title'] == "Berlangsung"
                                                              ? 'assets/icons/ic_notif_berlangsung.png'
                                                              : Get.find<ControllerLogin>().dataNotif[index]['title'] == "Waktu layanan dimulai"
                                                                  ? 'assets/icons/ic_notif_muali.png'
                                                                  : Get.find<ControllerLogin>().dataNotif[index]['title'] == "Konfirmasi Selesai"
                                                                      ? 'assets/icons/ic_notif_berhasil.png'
                                                                      : Get.find<ControllerLogin>().dataNotif[index]['title'] == "Selesai"
                                                                          ? 'assets/icons/ic_notif_selesai.png'
                                                                          : 'assets/icons/ic_notif_pesanan_gagal.png'),
                                          verticalSpace(20),
                                          Text(
                                            Get.find<ControllerLogin>()
                                                .dataNotif[index]['title'],
                                            style: TextStyles.subtitle2,
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            DateFormat('dd MMMM yyyy, HH:mm',
                                                    'id_ID')
                                                .format(
                                              DateTime.parse(
                                                Get.find<ControllerLogin>()
                                                    .dataNotif[index]['date'],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.all(10),
                                            child: Text(
                                              Get.find<ControllerLogin>()
                                                      .dataNotif[index]
                                                  ['description'],
                                              style: TextStyles.body2,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Cntr(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 25),
                                            radius: BorderRadius.circular(10),
                                            color: const Color(0xffEFEFEF),
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Code Order',
                                                  style: TextStyle(
                                                      color: Colors.grey[400]),
                                                ),
                                                Text(
                                                  Get.find<ControllerLogin>()
                                                                  .dataNotif[
                                                              index]['order'] ==
                                                          null
                                                      ? "${Get.find<ControllerLogin>().dataNotif[index]['nurse_order']['code']}"
                                                      : "${Get.find<ControllerLogin>().dataNotif[index]['order']['code']}",
                                                  style: const TextStyle(),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          cardPerawat(
                                            Get.find<ControllerLogin>()
                                                              .dataNotif[index]
                                                          ['order'] ==
                                                      null ?
                                              'Perawat :' : "Dokter :",
                                              Get.find<ControllerLogin>()
                                                              .dataNotif[index]
                                                          ['order'] ==
                                                      null
                                                  ? pesananC.nameDoctor.value
                                                  : Get.find<ControllerLogin>()
                                                              .dataNotif[index]
                                                          ['order']['doctor']
                                                      ['name'],
                                                      
                                                      Get.find<ControllerLogin>()
                                                              .dataNotif[index]
                                                          ['order'] ==
                                                      null
                                                  ?pesananC.imageDoctor.value: Get.find<ControllerLogin>()
                                                              .dataNotif[index]
                                                          ['order']['doctor']['image']),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          cardPerawat('Layanan :', Get.find<ControllerLogin>()
                                                              .dataNotif[index]
                                                          ['order'] ==
                                                      null
                                                  ?Get.find<ControllerLogin>()
                                                              .dataNotif[index]
                                                          ['nurse_order']['service']['name']: Get.find<ControllerLogin>()
                                                              .dataNotif[index]
                                                          ['order']['service']['name'],
                                                          Get.find<ControllerLogin>()
                                                              .dataNotif[index]
                                                          ['order'] ==
                                                      null
                                                  ?Get.find<ControllerLogin>()
                                                              .dataNotif[index]
                                                          ['nurse_order']['service']['image']: Get.find<ControllerLogin>()
                                                              .dataNotif[index]
                                                          ['order']['service']['image']),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          detailPaket(index),

                                          // Container(
                                          //   padding: const EdgeInsets.symmetric(
                                          //       horizontal: 15, vertical: 15),
                                          //   margin: const EdgeInsets.symmetric(
                                          //       horizontal: 30),
                                          //   width: Get.width,
                                          //   decoration: BoxDecoration(
                                          //     color: Colors.grey[300],
                                          //     borderRadius:
                                          //         const BorderRadius.all(
                                          //       Radius.circular(10.0),
                                          //     ),
                                          //   ),
                                          //   child: Column(
                                          //     children: [
                                          //       Row(
                                          //         mainAxisAlignment:
                                          //             MainAxisAlignment
                                          //                 .spaceBetween,
                                          //         children: [
                                          //           Text(
                                          //             'Tanggal Pesanan',
                                          //             style: TextStyle(
                                          //                 color:
                                          //                     Colors.grey[400]),
                                          //           ),
                                          //           Text(
                                          //             DateFormat(
                                          //                     'dd MMMM yyyy, HH:mm',
                                          //                     'id_ID')
                                          //                 .format(
                                          //               DateTime.parse(
                                          //                 Get.find<ControllerLogin>()
                                          //                         .dataNotif[
                                          //                     index]['date'],
                                          //               ),
                                          //             ),
                                          //           ),
                                          //         ],
                                          //       ),
                                          //       Row(
                                          //         mainAxisAlignment:
                                          //             MainAxisAlignment
                                          //                 .spaceBetween,
                                          //         children: [
                                          //           Column(
                                          //             crossAxisAlignment:
                                          //                 CrossAxisAlignment
                                          //                     .start,
                                          //             children: [
                                          //               Text(
                                          //                 'Mulai Order',
                                          //                 style: TextStyle(
                                          //                     color: Colors
                                          //                         .grey[400]),
                                          //               ),
                                          //               Text(
                                          //                 'Selesai Order',
                                          //                 style: TextStyle(
                                          //                     color: Colors
                                          //                         .grey[400]),
                                          //               ),
                                          //             ],
                                          //           ),
                                          //           Column(
                                          //             children: [
                                          //               Text(
                                          //                 DateFormat('dd MMMM yyyy, kk:mm', "id_ID").format(DateTime.parse(Get.find<ControllerLogin>()
                                          //                                 .dataNotif[index][
                                          //                             'order'] ==
                                          //                         null
                                          //                     ? Get.find<ControllerLogin>()
                                          //                                 .dataNotif[index]
                                          //                             ['nurse_order'][
                                          //                         'startDateCustomer']
                                          //                     : Get.find<ControllerLogin>()
                                          //                                 .dataNotif[index]
                                          //                             ['order']
                                          //                         ['startDateCustomer'])),
                                          //                 // CurrencyFormat.convertToIdr(discount, 0),
                                          //               ),
                                          //               Text(
                                          //                 DateFormat('dd MMMM yyyy, kk:mm', "id_ID").format(DateTime.parse(Get.find<ControllerLogin>()
                                          //                                 .dataNotif[index][
                                          //                             'order'] ==
                                          //                         null
                                          //                     ? Get.find<ControllerLogin>()
                                          //                                 .dataNotif[index]
                                          //                             ['nurse_order'][
                                          //                         'endDateCustomer']
                                          //                     : Get.find<ControllerLogin>()
                                          //                                 .dataNotif[index]
                                          //                             ['order']
                                          //                         ['endDateCustomer'])),
                                          //                 // CurrencyFormat.convertToIdr(discount, 0),
                                          //               ),
                                          //             ],
                                          //           ),
                                          //         ],
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30),
                                              child: ButtonGradient(
                                                  onPressed: () async {
                                                    Get.find<
                                                            ControllerPesanan>()
                                                        .idOrder
                                                        .value = Get.find<
                                                            HomeController>()
                                                        .idOrderFromPesan
                                                        .value;

                                                    // ignore: unrelated_type_equality_checks
                                                    if (controller.serviceId != 2 && controller.serviceId != 1) {
                                                      log('masuuuk zee');
                                                      await Get.find<
                                                              ControllerPesanan>()
                                                          .getDetailOrderNurse();
                                                      controller.role.value =
                                                          "nurse";
                                                          
                                                    } else {
                                                      log('masuuuk');
                                                      await Get.find<
                                                              ControllerPesanan>()
                                                          .getOrderDetail();
                                                      controller.role.value =
                                                          "doctor";
                                                    }
                                                    log("Service ==== ${controller.serviceId}");
                                                    Get.to(() => PesananDetailScreen(
                                                        data: Get.find<
                                                                ControllerPesanan>()
                                                            .detailDataOrder[0]));
                                                    log("CEK CEK${Get.find<ControllerPesanan>().detailDataOrder[0]}");
                                                  },
                                                  label: Get.find<ControllerLogin>()
                                                                          .dataNotif[
                                                                      index]
                                                                  ['title'] ==
                                                              "Mulai Sekarang" ||
                                                          Get.find<ControllerLogin>()
                                                                      .dataNotif[
                                                                  index]['title'] ==
                                                              "Waktu layanan dimulai"
                                                      ? "Mulai Sekarang"
                                                      : "Lihat Pesanan")),
                                          verticalSpace(10),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }

  Cntr cardPerawat(String title, String subtitle, String imageUrl) {
    return Cntr(
      border: Border.all(color: Color(0xffE2E2E2)),
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(horizontal: 25),
      radius: BorderRadius.circular(10),
      child: Row(
        children: [
          Cntr(
            image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover),
            height: 45,
            width: 45,
            color: Colors.grey,
            radius: BorderRadius.circular(100),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Txt(
                text: title,
                size: 12,
              ),
              Txt(
                text: subtitle,
                size: 16,
                weight: FontWeight.bold,
              ),
            ],
          )
        ],
      ),
    );
  }

  Cntr detailPaket(int index) {
    return Cntr(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      alignment: Alignment.centerLeft,
      width: Get.width,
      border: Border.all(color: Color(0xffE2E2E2)),
      radius: BorderRadius.circular(10),
      child: ExpansionTile(
          title: Row(
            children: [
              Image.asset('assets/icons/icon_pesan.png'),
              const SizedBox(
                width: 15.0,
              ),
              Txt(
                text: 'Detail Pesanan',
                weight: FontWeight.bold,
              ),
            ],
          ),
          children: [
            Cntr(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              radius: BorderRadius.circular(10),
              width: Get.width,
              child: Column(
                children: [
                  Get.find<ControllerLogin>().dataNotif[index]['order'] == null
                      ? detailPesan(
                          title: 'Paket',
                          detail: Get.find<ControllerLogin>()
                              .dataNotif[index]['nurse_order']['package_name']
                              .toString(),
                          index: index)
                      : const SizedBox(
                          height: 1.0,
                        ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  detailPesan(
                      index: index,
                      title: 'Harga',
                      detail: Get.find<ControllerLogin>().dataNotif[index]
                                  ['order'] ==
                              null
                          ?CurrencyFormat.convertToIdr(Get.find<ControllerLogin>()
                              .dataNotif[index]['nurse_order']['service_price_nurse']['price'],0)
                          : CurrencyFormat.convertToIdr(Get.find<ControllerLogin>()
                              .dataNotif[index]['order']['service_price']['price'],0)),
                  const SizedBox(
                    height: 12.0,
                  ),
                  detailPesan(
                      index: index,
                      title: 'Diskon',
                      detail: Get.find<ControllerLogin>().dataNotif[index]
                                  ['order'] ==
                              null
                          ? "${Get.find<ControllerLogin>()
                              .dataNotif[index]['nurse_order']['discount']} %"
                          : "${Get.find<ControllerLogin>()
                              .dataNotif[index]['order']['discount']} %"),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: Get.width / 2.6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Txt(
                text: 'Metode pmebayaran',
                color: Colors.grey,
              ),
              Txt(
                text: ':',
                color: Colors.grey,
              ),
            ],
          ),
        ),
        Get.find<ControllerLogin>().dataNotif[index]
                                  ['order'] ==
                              null ?  Get.find<ControllerLogin>()
                              .dataNotif[index]['nurse_order']['payment'] == null ? Txt(text: "null") :
        Get.find<ControllerLogin>()
                              .dataNotif[index]['nurse_order']['payment']['debit_from_bank'] == '014'
                                ? Image.asset(
                                    'assets/icons/logo_bca.png',
                                    width: 50,
                                  
                                  )
                                : Get.find<ControllerLogin>()
                              .dataNotif[index]['nurse_order']['payment']['debit_from_bank'] ==
                                        '002'
                                    ? Image.asset(
                                        'assets/icons/logo_briva.png',
                                        width: 50,
                                      
                                      )
                                    : Get.find<ControllerLogin>()
                              .dataNotif[index]['nurse_order']['payment']
                                                ['debit_from_bank'] ==
                                            '013'
                                        ? Image.asset(
                                            'assets/icons/logo_permata.png',
                                            width: 50,
                                          
                                          )
                                        : Get.find<ControllerLogin>()
                              .dataNotif[index]['nurse_order']['payment']
                                                    ['debit_from_bank'] ==
                                                '022'
                                            ? Image.asset(
                                                'assets/icons/logo_cimb.png',
                                                width: 50,
                                              
                                              )
                                            : Get.find<ControllerLogin>()
                              .dataNotif[index]['nurse_order']['payment']
                                                        ['debit_from_bank'] ==
                                                    '503'
                                                ? Image.asset(
                                                    'assets/icons/logo_ovo.png',
                                                    width: 50,
                                                  
                                                  )
                                                : Get.find<ControllerLogin>()
                              .dataNotif[index]['nurse_order']['payment'][
                                                            'debit_from_bank'] ==
                                                        '016'
                                                    ? Image.asset(
                                                        'assets/icons/logo_maybank.png',
                                                        width: 50,
                                                      
                                                      )
                                                    : Get.find<ControllerLogin>()
                              .dataNotif[index]['nurse_order']['payment'][
                                                                'debit_from_bank'] ==
                                                            '011'
                                                        ? Image.asset(
                                                            'assets/icons/logo_danamon.png',
                                                            width: 50,
                                                          
                                                          )
                                                        : Get.find<ControllerLogin>()
                              .dataNotif[index]['nurse_order']['payment']['product_code'] ==
                                                                'MANDIRIATM'
                                                            ? Image.asset(
                                                                'assets/icons/logo_mandiri.png',
                                                                width: 50,
                                                              
                                                              )
                                                            : Get.find<ControllerLogin>()
                              .dataNotif[index]['nurse_order']['payment']
                                                                        ['product_code'] ==
                                                                    'SHOPEEJUMPPAY'
                                                                ? Image.asset(
                                                                    'assets/icons/logo_shopeepay.png',
                                                                    width: 50,
                                                                  
                                                                  )
                                                                : Get.find<ControllerLogin>()
                              .dataNotif[index]['nurse_order']['payment']['product_code'] == 'LINKAJAAPPLINK'
                                                                    ? Image.asset(
                                                                        'assets/icons/logo_linkaja.png',
                                                                        width:
                                                                            50,
                                                                      )
                                                                    : Get.find<ControllerLogin>()
                              .dataNotif[index]['nurse_order']['payment']['product_code'] == 'DANAPAY'
                                                                        ? Image.asset(
                                                                            'assets/icons/logo_dana.png',
                                                                            width:
                                                                                50,
                                                                          )
                                                                        : Get.find<ControllerLogin>()
                              .dataNotif[index]['nurse_order']['payment']['debit_from_bank'] == '157'
                                                                            ? Image.asset(
                                                                                'assets/icons/logo_maspion.png',
                                                                                width: 50,
                                                                              
                                                                              )
                                                                            : Get.find<ControllerLogin>()
                              .dataNotif[index]['nurse_order']['payment']['debit_from_bank'] == '037'
                                                                                ? Image.asset(
                                                                                    'assets/icons/logo_artha.png',
                                                                                    width: 50,
                                                                                  
                                                                                  )
                                                                                : Get.find<ControllerLogin>()
                              .dataNotif[index]['nurse_order']['payment']['debit_from_bank'] == '200'
                                                                                    ? Image.asset(
                                                                                        'assets/icons/logo_btn.png',
                                                                                        width: 50,
                                                                                      
                                                                                      )
                                                                                    : Get.find<ControllerLogin>()
                              .dataNotif[index]['nurse_order']['payment']['debit_from_bank'] == '213'
                                                                                        ? Image.asset(
                                                                                            'assets/icons/logo_btpn.png',
                                                                                            width: 50,
                                                                                          
                                                                                          )
                                                                                        : Image.asset(
                                                                                            'assets/icons/bni.png',
                                                                                            width: 50,
                                                                                          
                                                                                          ) 
                                  //  : Txt(text: 'null')
                                :  Get.find<ControllerLogin>()
                              .dataNotif[index]['order']['payment'] == null ?Txt(text: 'null', weight: FontWeight.bold, color: Colors.blue,) :                                
                                Get.find<ControllerLogin>()
                              .dataNotif[index]['order']['payment']['debit_from_bank'] ==
                                        '002'
                                    ? Image.asset(
                                        'assets/icons/logo_briva.png',
                                        width: 50,
                                      
                                      )
                                    : Get.find<ControllerLogin>()
                              .dataNotif[index]['order']['payment']
                                                ['debit_from_bank'] ==
                                            '013'
                                        ? Image.asset(
                                            'assets/icons/logo_permata.png',
                                            width: 50,
                                          
                                          )
                                        : Get.find<ControllerLogin>()
                              .dataNotif[index]['order']['payment']
                                                    ['debit_from_bank'] ==
                                                '022'
                                            ? Image.asset(
                                                'assets/icons/logo_cimb.png',
                                                width: 50,
                                              
                                              )
                                            : Get.find<ControllerLogin>()
                              .dataNotif[index]['order']['payment']
                                                        ['debit_from_bank'] ==
                                                    '503'
                                                ? Image.asset(
                                                    'assets/icons/logo_ovo.png',
                                                    width: 50,
                                                  
                                                  )
                                                : Get.find<ControllerLogin>()
                              .dataNotif[index]['order']['payment'][
                                                            'debit_from_bank'] ==
                                                        '016'
                                                    ? Image.asset(
                                                        'assets/icons/logo_maybank.png',
                                                        width: 50,
                                                      
                                                      )
                                                    : Get.find<ControllerLogin>()
                              .dataNotif[index]['order']['payment'][
                                                                'debit_from_bank'] ==
                                                            '011'
                                                        ? Image.asset(
                                                            'assets/icons/logo_danamon.png',
                                                            width: 50,
                                                          
                                                          )
                                                        : Get.find<ControllerLogin>()
                              .dataNotif[index]['order']['payment']['product_code'] ==
                                                                'MANDIRIATM'
                                                            ? Image.asset(
                                                                'assets/icons/logo_mandiri.png',
                                                                width: 50,
                                                              
                                                              )
                                                            : Get.find<ControllerLogin>()
                              .dataNotif[index]['order']['payment']
                                                                        ['product_code'] ==
                                                                    'SHOPEEJUMPPAY'
                                                                ? Image.asset(
                                                                    'assets/icons/logo_shopeepay.png',
                                                                    width: 50,
                                                                  
                                                                  )
                                                                : Get.find<ControllerLogin>()
                              .dataNotif[index]['order']['payment']['product_code'] == 'LINKAJAAPPLINK'
                                                                    ? Image.asset(
                                                                        'assets/icons/logo_linkaja.png',
                                                                        width:
                                                                            50,
                                                                        height:
                                                                            50,
                                                                      )
                                                                    : Get.find<ControllerLogin>()
                              .dataNotif[index]['order']['payment']['product_code'] == 'DANAPAY'
                                                                        ? Image.asset(
                                                                            'assets/icons/logo_dana.png',
                                                                            width:
                                                                                50,
                                                                            height:
                                                                                50,
                                                                          )
                                                                        : Get.find<ControllerLogin>()
                              .dataNotif[index]['order']['payment']['debit_from_bank'] == '157'
                                                                            ? Image.asset(
                                                                                'assets/icons/logo_maspion.png',
                                                                                width: 50,
                                                                              
                                                                              )
                                                                            : Get.find<ControllerLogin>()
                              .dataNotif[index]['order']['payment']['debit_from_bank'] == '037'
                                                                                ? Image.asset(
                                                                                    'assets/icons/logo_artha.png',
                                                                                    width: 50,
                                                                                  
                                                                                  )
                                                                                : Get.find<ControllerLogin>()
                              .dataNotif[index]['order']['payment']['debit_from_bank'] == '200'
                                                                                    ? Image.asset(
                                                                                        'assets/icons/logo_btn.png',
                                                                                        width: 50,
                                                                                      
                                                                                      )
                                                                                    : Get.find<ControllerLogin>()
                              .dataNotif[index]['order']['payment']['debit_from_bank'] == '213'
                                                                                        ? Image.asset(
                                                                                            'assets/icons/logo_btpn.png',
                                                                                            width: 50,
                                                                                          
                                                                                          )
                                                                                        : Image.asset(
                                                                                            'assets/icons/bni.png',
                                                                                            width: 50,
                                                                                          
                                                                                          ),
      ],
    ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  detailPesan(
                      index: index,
                      title: 'Total pembayaran',
                      detail: Get.find<ControllerLogin>().dataNotif[index]
                                  ['order'] ==
                              null
                          ?CurrencyFormat.convertToIdr(Get.find<ControllerLogin>()
                              .dataNotif[index]['nurse_order']['totalPrice'],0)
                          : CurrencyFormat.convertToIdr(Get.find<ControllerLogin>()
                              .dataNotif[index]['order']['totalPrice'],0),),
                              const SizedBox(
                              height: 5.0,
                              ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 14,
                      ),
                      Txt(
                        text: 'Terverifikasi bayar',
                        color: Colors.green,
                        size: 10,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ]),
    );
  }

  Row detailPesan(
      {required String title, required String detail, required int index}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: Get.width / 2.6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Txt(
                text: title,
                color: Colors.grey,
              ),
              Txt(
                text: ':',
                color: Colors.grey,
              ),
            ],
          ),
        ),
        Txt(
          text: detail,
          weight: FontWeight.bold,
        ),
      ],
    );
  }
}
