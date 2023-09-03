import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bionmed_app/constant/helper.dart';
import 'package:bionmed_app/screens/payment/metode_pembayaran_screen.dart';
import 'package:bionmed_app/screens/pesanan/controller_pesanan.dart';
import 'package:bionmed_app/screens/pesanan/pesanan_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../constant/colors.dart';
import '../../constant/styles.dart';

class CardPesananService extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  const CardPesananService({
    Key? key,
    this.isLive = false,
    this.data,
  }) : super(key: key);

  final bool isLive;

  @override
  Widget build(BuildContext context) {
    String role = data['user'] == null ? "" : data['user']['role'];
    return InkWell(
      onTap: () async {
                            log('message ${data['order']['status']}');

        if (data['order']['status'] != 0) {
          // Get.find<HomeController>().timePeriodic.value = false;
          //               Get.find<HomeController>().realtimeApiGet.value = false;
          //               if (Get.find<HomeController>().realtimeApiGet.isFalse) {
          //                 await Get.find<HomeController>().realtimeApi();
          //               }
          Get.find<ControllerPesanan>().statusOrder.value =
              data['order']['status'];
          // Get.find<ControllerPesanan>().imageResep.value = data['order']['image_recipe'] == null ? "" : data['order']['image_recipe'];
          if (data['order']['service']['sequence'] != 2 ||
              data['order']['service']['sequence'] != 4) {
            // Get.find<ControllerPesanan>().orderMinute.value =
            //     data['order']['service_price']['minute'];
          }
          Get.find<ControllerPesanan>().idOrder.value = data['order']['id'];
          if (role == 'nurse') {
            await Get.find<ControllerPesanan>().getDetailOrderNurse();
          }
          {
            // await Get.find<ControllerPesanan>().getOrderChat();
          }
          if (data['order']['service']['sequence'] == 1) {
            Get.find<ControllerPesanan>().orderMinute.value =
                data['order']['service_price']['minute'];
          }
          Get.to(() => PesananDetailScreen(
                data: data,
              ));
        } else {
          Get.find<ControllerPesanan>().codeOrder.value =
              data['order']['code'].toString();
          Get.find<ControllerPesanan>().dataOrderChoice.value = data;
          Get.to(() => const MetodePaymentScreen(
                paymentScreen: true,
              ));
        }
      },
      child: Container(
        margin: EdgeInsets.only(
            left: defaultPadding, right: defaultPadding, top: 6, bottom: 6),
        padding: const EdgeInsets.all(8),
        // height: 128,
        width: Get.width,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [AppColor.shadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                role == 'nurse'
                    ? Container(
                        height: 86,
                        width: 71,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          // color: AppColor.bluePrimary2,
                          image: data['order']['nurse']['image'] == ""
                              ? const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/img-doctor2.png'),
                                  fit: BoxFit.cover)
                              : DecorationImage(
                                  image: NetworkImage(
                                      data['order']['nurse']['image']),
                                  fit: BoxFit.cover),
                        ),
                      )
                    : Container(
                        height: 86,
                        width: 71,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          // color: AppColor.bluePrimary2,
                          image: data['order']['doctor']['image'] == ""
                              ? const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/img-doctor2.png'),
                                  fit: BoxFit.cover)
                              : DecorationImage(
                                  image: NetworkImage(
                                      data['order']['doctor']['image']),
                                  fit: BoxFit.cover),
                        ),
                      ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width * 0.48,
                          child: AutoSizeText(
                            role == 'nurse'
                                ? data['order']['nurse']['name']
                                : data['order']['doctor']['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Image.network(
                          data['order']['service']['image'],
                          width: 30.w,
                        ),
                        Text(
                          data['order']['service']['name'],
                          style: const TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColor.bgForm,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          // ignore: prefer_const_literals_to_create_immutables
                          child: Row(children: [
                            Icon(
                              Icons.business_center,
                              size: 16,
                              color: AppColor.bodyColor[700],
                            ),
                            const SizedBox(width: 6),
                            Text(
                                // data['order']['doctor']['experience'],
                                "",
                                style: TextStyles.callout2),
                          ]),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColor.bgForm,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          // ignore: prefer_const_literals_to_create_immutables
                          child: Row(children: [
                            Icon(
                              Icons.person,
                              size: 16,
                              color: AppColor.bodyColor[700],
                            ),
                            const SizedBox(width: 6),
                            Text(
                                // data['order']['doctor']['old'] + " Tahun",
                                'tahun',
                                style: TextStyles.callout2),
                          ]),
                        ),
                      ],
                    ),
                  ],
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
                    Text("Total Pembayaran",
                        style: TextStyles.callout1
                            .copyWith(color: AppColor.bodyColor.shade700)),
                    verticalSpace(5),
                    Text(
                        priceFormat(data['order']['totalPrice']
                            //  -
                            //     data['order']['discount']
                            ),
                        style: TextStyles.callout1.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColor.successColor)),
                  ],
                ),
                data['order']['status'] == 0
                    ? const SizedBox(
                        height: 1.0,
                      )
                    : Row(
                        children: [
                          SizedBox(
                              height: 20,
                              child: Image.asset("assets/icons/calendar.png")),
                          horizontalSpace(10),
                          Text(
                            DateFormat('dd MMMM yyyy, HH:mm', 'id_ID').format(
                                DateTime.parse(
                                        data['order']['startDateCustomer'])
                                    .toLocal()),
                            style: TextStyles.callout1
                                .copyWith(color: AppColor.bodyColor.shade600),
                          )
                        ],
                      ),
              ],
            ),
            const Divider(),
            widgetAction()
          ],
        ),
      ),
    );
  }

  Widget widgetAction() {
    return data['payment'] != null
        ? ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text("Metode Payment :",
                style: TextStyles.callout1
                    .copyWith(color: AppColor.bodyColor.shade700)),
            subtitle: Row(
              children: [
                data['payment']['debit_from_bank'] == '014'
                    ? Image.asset(
                        'assets/icons/logo_bca.png',
                        width: 50,
                        height: 50,
                      )
                    : data['payment']['debit_from_bank'] == '002'
                        ? Image.asset(
                            'assets/icons/logo_briva.png',
                            width: 50,
                            height: 50,
                          )
                        : data['payment']['debit_from_bank'] == '013'
                            ? Image.asset(
                                'assets/icons/logo_permata.png',
                                width: 50,
                                height: 50,
                              )
                            : data['payment']['debit_from_bank'] == '022'
                                ? Image.asset(
                                    'assets/icons/logo_cimb.png',
                                    width: 50,
                                    height: 50,
                                  )
                                : data['payment']['debit_from_bank'] == '503'
                                    ? Image.asset(
                                        'assets/icons/logo_ovo.png',
                                        width: 50,
                                        height: 50,
                                      )
                                    : data['payment']['debit_from_bank'] ==
                                            '016'
                                        ? Image.asset(
                                            'assets/icons/logo_maybank.png',
                                            width: 50,
                                            height: 50,
                                          )
                                        : data['payment']['debit_from_bank'] ==
                                                '011'
                                            ? Image.asset(
                                                'assets/icons/logo_danamon.png',
                                                width: 50,
                                                height: 50,
                                              )
                                            : data['payment']['product_code'] ==
                                                    'MANDIRIATM'
                                                ? Image.asset(
                                                    'assets/icons/logo_mandiri.png',
                                                    width: 50,
                                                    height: 50,
                                                  )
                                                : data['payment']
                                                            ['product_code'] ==
                                                        'SHOPEEJUMPPAY'
                                                    ? Image.asset(
                                                        'assets/icons/logo_shopeepay.png',
                                                        width: 50,
                                                        height: 50,
                                                      )
                                                    : data['payment'][
                                                                'product_code'] ==
                                                            'LINKAJAAPPLINK'
                                                        ? Image.asset(
                                                            'assets/icons/logo_linkaja.png',
                                                            width: 50,
                                                            height: 50,
                                                          )
                                                        : data['payment'][
                                                                    'product_code'] ==
                                                                'DANAPAY'
                                                            ? Image.asset(
                                                                'assets/icons/logo_dana.png',
                                                                width: 50,
                                                                height: 50,
                                                              )
                                                            : data['payment'][
                                                                        'debit_from_bank'] ==
                                                                    '157'
                                                                ? Image.asset(
                                                                    'assets/icons/logo_maspion.png',
                                                                    width: 50,
                                                                    height: 50,
                                                                  )
                                                                : data['payment']
                                                                            [
                                                                            'debit_from_bank'] ==
                                                                        '037'
                                                                    ? Image
                                                                        .asset(
                                                                        'assets/icons/logo_artha.png',
                                                                        width:
                                                                            50,
                                                                        height:
                                                                            50,
                                                                      )
                                                                    : data['payment']['debit_from_bank'] ==
                                                                            '200'
                                                                        ? Image.asset(
                                                                            'assets/icons/logo_btn.png',
                                                                            width:
                                                                                50,
                                                                            height:
                                                                                50,
                                                                          )
                                                                        : data['payment']['debit_from_bank'] == '213'
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
              ],
            ),
            trailing: SizedBox(
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  data['order']['status'] == 99
                      ? InkWell(
                          onTap: () async {
                            // Get.find<HomeController>().timePeriodic.value = false;
                            // Get.find<HomeController>().realtimeApiGet.value = false;
                            // if (Get.find<HomeController>().realtimeApiGet.isFalse) {
                            //   await Get.find<HomeController>().realtimeApi();
                            // }
                            Get.find<ControllerPesanan>().statusOrder.value =
                                data['order']['status'];
                            // Get.find<ControllerPesanan>().imageResep.value = data['order']['image_recipe'] == null ? "" : data['order']['image_recipe'];
                            if (data['order']['service']['sequence'] !=
                                2) {
                              Get.find<ControllerPesanan>().orderMinute.value =
                                  data['order']['service_price']['minute'];
                            }
                            Get.find<ControllerPesanan>().idOrder.value =
                                data['order']['id'];
                            // await Get.find<ControllerPesanan>().getOrderChat();
                            Get.to(() => PesananDetailScreen(
                                  data: data,
                                ));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: AppColor.yellowColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            width: Get.width / 4.7,
                            height: 26,
                            padding: const EdgeInsets.all(5),
                            child: const Text(
                              'Atur Ulang',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(
                          height: 1.0,
                        ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  Container(
                    height: 26,
                    decoration: isLive
                        ? BoxDecoration(
                            gradient: AppColor.gradient1,
                            borderRadius: BorderRadius.circular(2))
                        : null,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Get.find<HomeController>().timePeriodic.value = false;
                        // Get.find<HomeController>().realtimeApiGet.value = false;
                        // if (Get.find<HomeController>().realtimeApiGet.isFalse) {
                        //   await Get.find<HomeController>().realtimeApi();
                        // }
                        Get.find<ControllerPesanan>().statusOrder.value =
                            data['order']['status'];
                        // Get.find<ControllerPesanan>().imageResep.value = data['order']['image_recipe'] == null ? "" : data['order']['image_recipe'];
                        if (data['order']['service']['sequence'] !=
                            2) {
                          Get.find<ControllerPesanan>().orderMinute.value =
                              data['order']['service_price']['minute'];
                        }
                        Get.find<ControllerPesanan>().idOrder.value =
                            data['order']['id'];
                        await Get.find<ControllerPesanan>().getOrderChat();
                        Get.to(() => PesananDetailScreen(
                              data: data,
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        // ignore: deprecated_member_use
                        primary: data['order']['status'] == 1
                            ? AppColor.successColor
                            : data['order']['status'] == 2
                                ? AppColor.yellowColor
                                : data['order']['status'] == 3
                                    ? AppColor.primaryColor
                                    : data['order']['status'] == 4
                                        ? AppColor.bluePrimary2
                                        : data['order']['status'] == 99 || data['order']['status'] == 98
                                            ? Colors.red
                                            : AppColor.greenColor,
                        // ignore: deprecated_member_use
                        onSurface: Colors.transparent,
                      ),
                      child: Text(
                        data['order']['status'] == 1
                            ? "Sudah Bayar"
                            : data['order']['status'] == 2
                                ? "Terjadwalkan"
                                : data['order']['status'] == 3
                                    ? "Mulai Sekarang"
                                    : data['order']['status'] == 4
                                        ? "Sedang Berlangsung"
                                        : data['order']['status'] == 99 
                                            ? "Terlewatkan"
                                            : data['order']['status'] == 6
                                                ? "Konfirmasi selesai"
                                                :data['order']['status'] == 98 ? "Dibatalkan" : "Selesai",
                        style: TextStyles.callout1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Belum Bayar ",
                  style: TextStyles.callout1.copyWith(color: Colors.red)),
              Container(
                height: 26,
                decoration: isLive
                    ? BoxDecoration(
                        gradient: AppColor.gradient1,
                        borderRadius: BorderRadius.circular(2))
                    : null,
                child: ElevatedButton(
                  onPressed: () {
                    Get.find<ControllerPesanan>().codeOrder.value =
                        data['order']['code'].toString();
                    Get.find<ControllerPesanan>().dataOrderChoice.value = data;
                    Get.to(() => const MetodePaymentScreen(
                          paymentScreen: true,
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0.0, backgroundColor: AppColor.redColor),
                  child: Text(
                    "Pilih Pembayaran",
                    style: TextStyles.callout1,
                  ),
                ),
              ),
            ],
          );
  }
}
