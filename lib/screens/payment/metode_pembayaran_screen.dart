import 'dart:developer';

import 'package:bionmed_app/screens/payment/controller_payment.dart';
import 'package:bionmed_app/screens/pesanan/controller_pesanan.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:bionmed_app/widgets/other/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../constant/styles.dart';

class MetodePaymentScreen extends StatefulWidget {
  final bool? paymentScreen;
  const MetodePaymentScreen({Key? key, this.paymentScreen}) : super(key: key);
  static const routeName = "/metode_pay_screen";

  @override
  State<MetodePaymentScreen> createState() => _MetodePaymentScreenState();
}

class _MetodePaymentScreenState extends State<MetodePaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerPayment>(
      init: ControllerPayment(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Pilih Metode Pembayaran'),
            titleTextStyle: TextStyles.subtitle1,
            elevation: 0.0,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: AppColor.gradient1,
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => controller.loading.value == true
                  ? loadingIndicator(color: AppColor.primaryColor)
                  : ButtonGradient(
                      onPressed: () {
                        if (widget.paymentScreen == true) {
                          controller.paymentChecked.value = {
                            "logo": controller.logoPay.value,
                            "label": controller.labelPay.value,
                          };
                          // ignore: avoid_print
                          print(
                              "cekk : ${controller.vaValue.value}");
                          if (controller.vaCode.value == 'ovo' || controller.vaCode.value == 'dana' ||controller.vaCode.value == "shopeePay"|| controller.vaCode.value == "linkAja") {
                            Get.find<ControllerPesanan>().orderPlaceByDigital(
                              labelPay: controller.labelPay.value,
                              vaValue: controller.vaValue.value,
                            );
                          } else {
                            Get.find<ControllerPesanan>().createVa(
                                codeBank: controller.vaValue.value.toString());
                            // print('cekcek ' + controller.vaValue.value.toString() );
                          }
                        } else {
                          log('zaeni${controller.labelPay.value}');
                          Get.back();

                          controller.paymentChecked.value = {
                            "logo": controller.logoPay.value,
                            "label": controller.labelPay.value,
                          };
                        }
                      },
                      label: "Pilih Pembayaran",
                      enable: controller.vaCode.value.isNotEmpty ? true : false,
                    ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: ListView(children: [
              Text(
                "Virtual Account : ",
                style: TextStyles.subtitle3,
              ),
              verticalSpace(20.h),
              widgetCardVa(),
              // const Divider(
              //   height: 20,
              //   thickness: 2,
              // ),
              // Text(
              //   "Tranfer Manual : ",
              //   style: TextStyles.subtitle3,
              // ),
              // verticalSpace(20.h),
              // widgetCardManual(),
              const Divider(
                height: 20,
                thickness: 2,
              ),
              Text(
                "Dompet Digital : ",
                style: TextStyles.subtitle3,
              ),
              verticalSpace(20.h),
              widgetCarddomoetDigital(),
            ]),
          ),
        );
      },
    );
  }

  Container widgetCardManual() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Get.find<ControllerPayment>().vaCode.value = 'bniM';
              Get.find<ControllerPayment>().vaValue.value = '009';
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Image.asset(
                      'assets/icons/bni.png',
                      width: 35.w,
                    ),
                    horizontalSpace(10.w),
                    Text(
                      "Bank Negara Indonesia",
                      style: TextStyles.subtitle3,
                    ),
                  ]),
                  // ignore: unrelated_type_equality_checks
                  Obx((() => Get.find<ControllerPayment>().vaCode == "bniM"
                      ? const Icon(
                          Icons.check_circle_rounded,
                          color: AppColor.successColor,
                        )
                      : Icon(
                          Icons.circle,
                          color: AppColor.bodyColor.shade200,
                        ))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container widgetCarddomoetDigital() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Get.find<ControllerPayment>().vaCode.value = 'dana';
              Get.find<ControllerPayment>().vaValue.value = '008';
              Get.find<ControllerPayment>().labelPay.value = 'DANAPAY';
              Get.find<ControllerPayment>().logoPay.value =
                  'assets/icons/logo_dana.png';
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Image.asset(
                      'assets/icons/logo_dana.png',
                      width: 35.w,
                    ),
                    horizontalSpace(10.w),
                    Text(
                      "Dana",
                      style: TextStyles.subtitle3,
                    ),
                  ]),
                  // ignore: unrelated_type_equality_checks
                  Obx((() => Get.find<ControllerPayment>().vaCode == "dana"
                      ? const Icon(
                          Icons.check_circle_rounded,
                          color: AppColor.successColor,
                        )
                      : Icon(
                          Icons.circle,
                          color: AppColor.bodyColor.shade200,
                        ))),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.find<ControllerPayment>().vaCode.value = 'linkAja';
              Get.find<ControllerPayment>().vaValue.value = '008';
              Get.find<ControllerPayment>().labelPay.value = 'LINKAJAAPPLINK';
              Get.find<ControllerPayment>().logoPay.value =
                  'assets/icons/logo_linkaja.png';
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Image.asset(
                      'assets/icons/logo_linkaja.png',
                      width: 35.w,
                    ),
                    horizontalSpace(10.w),
                    Text(
                      "Link Aja",
                      style: TextStyles.subtitle3,
                    ),
                  ]),
                  // ignore: unrelated_type_equality_checks
                  Obx((() => Get.find<ControllerPayment>().vaCode == "linkAja"
                      ? const Icon(
                          Icons.check_circle_rounded,
                          color: AppColor.successColor,
                        )
                      : Icon(
                          Icons.circle,
                          color: AppColor.bodyColor.shade200,
                        ))),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.find<ControllerPayment>().vaCode.value = 'shopeePay';
              Get.find<ControllerPayment>().vaValue.value = '008';
              Get.find<ControllerPayment>().labelPay.value = 'SHOPEEJUMPPAY';
              Get.find<ControllerPayment>().logoPay.value =
                  'assets/icons/logo_shopeepay.png';
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Image.asset(
                      'assets/icons/logo_shopeepay.png',
                      width: 35.w,
                    ),
                    horizontalSpace(10.w),
                    Text(
                      "Shopee Pay",
                      style: TextStyles.subtitle3,
                    ),
                  ]),
                  // ignore: unrelated_type_equality_checks
                  Obx((() => Get.find<ControllerPayment>().vaCode == "shopeePay"
                      ? const Icon(
                          Icons.check_circle_rounded,
                          color: AppColor.successColor,
                        )
                      : Icon(
                          Icons.circle,
                          color: AppColor.bodyColor.shade200,
                        ))),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.find<ControllerPayment>().vaCode.value = 'ovo';
              Get.find<ControllerPayment>().vaValue.value = '503';
              Get.find<ControllerPayment>().labelPay.value = 'OVO';
              Get.find<ControllerPayment>().logoPay.value =
                  'assets/icons/logo_ovo.png';
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Image.asset(
                      'assets/icons/logo_ovo.png',
                      width: 35.w,
                    ),
                    horizontalSpace(10.w),
                    Text(
                      "Ovo",
                      style: TextStyles.subtitle3,
                    ),
                  ]),
                  // ignore: unrelated_type_equality_checks
                  Obx((() => Get.find<ControllerPayment>().vaCode == "ovo"
                      ? const Icon(
                          Icons.check_circle_rounded,
                          color: AppColor.successColor,
                        )
                      : Icon(
                          Icons.circle,
                          color: AppColor.bodyColor.shade200,
                        ))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container widgetCardVa() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Get.find<ControllerPayment>().vaCode.value = 'bni';
              Get.find<ControllerPayment>().vaValue.value = '009';
              Get.find<ControllerPayment>().labelPay.value =
                  'Bank Negara Indonesia';
              Get.find<ControllerPayment>().logoPay.value =
                  'assets/icons/logo_bni.png';
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Image.asset(
                      'assets/icons/logo_bni.png',
                      width: 35.w,
                    ),
                    horizontalSpace(10.w),
                    Text(
                      "BNI VA",
                      style: TextStyles.subtitle3,
                    ),
                  ]),
                  // ignore: unrelated_type_equality_checks
                  Obx((() => Get.find<ControllerPayment>().vaCode == "bni"
                      ? const Icon(
                          Icons.check_circle_rounded,
                          color: AppColor.successColor,
                        )
                      : Icon(
                          Icons.circle,
                          color: AppColor.bodyColor.shade200,
                        ))),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.find<ControllerPayment>().vaCode.value = 'maybank';
              Get.find<ControllerPayment>().vaValue.value = '016';
              Get.find<ControllerPayment>().labelPay.value =
                  'Maybank';
              Get.find<ControllerPayment>().logoPay.value =
                  'assets/icons/logo_maybank.png';
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Image.asset(
                      'assets/icons/logo_maybank.png',
                      width: 35.w,
                    ),
                    horizontalSpace(10.w),
                    Text(
                      "Maybank VA",
                      style: TextStyles.subtitle3,
                    ),
                  ]),
                  // ignore: unrelated_type_equality_checks
                  Obx((() => Get.find<ControllerPayment>().vaCode == "maybank"
                      ? const Icon(
                          Icons.check_circle_rounded,
                          color: AppColor.successColor,
                        )
                      : Icon(
                          Icons.circle,
                          color: AppColor.bodyColor.shade200,
                        ))),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.find<ControllerPayment>().vaCode.value = 'danamon';
              Get.find<ControllerPayment>().vaValue.value = '011';
              Get.find<ControllerPayment>().labelPay.value =
                  'Danamon';
              Get.find<ControllerPayment>().logoPay.value =
                  'assets/icons/logo_danamon.png';
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Image.asset(
                      'assets/icons/logo_danamon.png',
                      width: 35.w,
                    ),
                    horizontalSpace(10.w),
                    Text(
                      "Danamon VA",
                      style: TextStyles.subtitle3,
                    ),
                  ]),
                  // ignore: unrelated_type_equality_checks
                  Obx((() => Get.find<ControllerPayment>().vaCode == "danamon"
                      ? const Icon(
                          Icons.check_circle_rounded,
                          color: AppColor.successColor,
                        )
                      : Icon(
                          Icons.circle,
                          color: AppColor.bodyColor.shade200,
                        ))),
                ],
              ),
            ),
          ),
          //MANDIRI
          InkWell(
            onTap: () {
              Get.find<ControllerPayment>().vaCode.value = 'mandiri';
              Get.find<ControllerPayment>().vaValue.value = '008';
              Get.find<ControllerPayment>().labelPay.value =
                  'Mandiri';
              Get.find<ControllerPayment>().logoPay.value =
                  'assets/icons/logo_mandiri.png';
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Image.asset(
                      'assets/icons/logo_mandiri.png',
                      width: 35.w,
                    ),
                    horizontalSpace(10.w),
                    Text(
                      "Mandiri VA",
                      style: TextStyles.subtitle3,
                    ),
                  ]),
                  // ignore: unrelated_type_equality_checks
                  Obx((() => Get.find<ControllerPayment>().vaCode == "mandiri"
                      ? const Icon(
                          Icons.check_circle_rounded,
                          color: AppColor.successColor,
                        )
                      : Icon(
                          Icons.circle,
                          color: AppColor.bodyColor.shade200,
                        ))),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.find<ControllerPayment>().vaCode.value = 'maspion';
              Get.find<ControllerPayment>().vaValue.value = '157';
              Get.find<ControllerPayment>().labelPay.value =
                  'Maspion';
              Get.find<ControllerPayment>().logoPay.value =
                  'assets/icons/logo_maspion.png';
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Image.asset(
                      'assets/icons/logo_maspion.png',
                      width: 35.w,
                    ),
                    horizontalSpace(10.w),
                    Text(
                      "Maspion VA",
                      style: TextStyles.subtitle3,
                    ),
                  ]),
                  // ignore: unrelated_type_equality_checks
                  Obx((() => Get.find<ControllerPayment>().vaCode == "maspion"
                      ? const Icon(
                          Icons.check_circle_rounded,
                          color: AppColor.successColor,
                        )
                      : Icon(
                          Icons.circle,
                          color: AppColor.bodyColor.shade200,
                        ))),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.find<ControllerPayment>().vaCode.value = ' arthaGraha ';
              Get.find<ControllerPayment>().vaValue.value = '037';
              Get.find<ControllerPayment>().labelPay.value =
                  ' Artha Graha ';
              Get.find<ControllerPayment>().logoPay.value =
                  'assets/icons/logo_artha.png';
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Image.asset(
                      'assets/icons/logo_artha.png',
                      width: 35.w,
                    ),
                    horizontalSpace(10.w),
                    Text(
                      " Artha Graha  VA",
                      style: TextStyles.subtitle3,
                    ),
                  ]),
                  // ignore: unrelated_type_equality_checks
                  Obx((() => Get.find<ControllerPayment>().vaCode == " arthaGraha "
                      ? const Icon(
                          Icons.check_circle_rounded,
                          color: AppColor.successColor,
                        )
                      : Icon(
                          Icons.circle,
                          color: AppColor.bodyColor.shade200,
                        ))),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.find<ControllerPayment>().vaCode.value = 'btn';
              Get.find<ControllerPayment>().vaValue.value = '200';
              Get.find<ControllerPayment>().labelPay.value =
                  'BTN';
              Get.find<ControllerPayment>().logoPay.value =
                  'assets/icons/logo_btn.png';
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Image.asset(
                      'assets/icons/logo_btn.png',
                      width: 35.w,
                    ),
                    horizontalSpace(10.w),
                    Text(
                      "BTN  VA",
                      style: TextStyles.subtitle3,
                    ),
                  ]),
                  // ignore: unrelated_type_equality_checks
                  Obx((() => Get.find<ControllerPayment>().vaCode == "btn"
                      ? const Icon(
                          Icons.check_circle_rounded,
                          color: AppColor.successColor,
                        )
                      : Icon(
                          Icons.circle,
                          color: AppColor.bodyColor.shade200,
                        ))),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.find<ControllerPayment>().vaCode.value = 'BTPN';
              Get.find<ControllerPayment>().vaValue.value = '213';
              Get.find<ControllerPayment>().labelPay.value =
                  'BTPN';
              Get.find<ControllerPayment>().logoPay.value =
                  'assets/icons/logo_btpn.png';
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Image.asset(
                      'assets/icons/logo_btpn.png',
                      width: 35.w,
                    ),
                    horizontalSpace(10.w),
                    Text(
                      "BTPN  VA",
                      style: TextStyles.subtitle3,
                    ),
                  ]),
                  // ignore: unrelated_type_equality_checks
                  Obx((() => Get.find<ControllerPayment>().vaCode == "BTPN"
                      ? const Icon(
                          Icons.check_circle_rounded,
                          color: AppColor.successColor,
                        )
                      : Icon(
                          Icons.circle,
                          color: AppColor.bodyColor.shade200,
                        ))),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.find<ControllerPayment>().vaCode.value = 'bri';
              Get.find<ControllerPayment>().vaValue.value = '002';
              Get.find<ControllerPayment>().labelPay.value =
                  'Bank Republik Indonesia';
              Get.find<ControllerPayment>().logoPay.value =
                  'assets/icons/logo_bri.png';
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Image.asset(
                      'assets/icons/logo_bri.png',
                      width: 35.w,
                    ),
                    horizontalSpace(10.w),
                    Text(
                      "BRI VA",
                      style: TextStyles.subtitle3,
                    ),
                  ]),
                  // ignore: unrelated_type_equality_checks
                  Obx((() => Get.find<ControllerPayment>().vaCode == "bri"
                      ? const Icon(
                          Icons.check_circle_rounded,
                          color: AppColor.successColor,
                        )
                      : Icon(
                          Icons.circle,
                          color: AppColor.bodyColor.shade200,
                        ))),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.find<ControllerPayment>().vaCode.value = 'permata';
              Get.find<ControllerPayment>().vaValue.value = '013';
              Get.find<ControllerPayment>().labelPay.value = 'Permata Bank';
              Get.find<ControllerPayment>().logoPay.value =
                  'assets/icons/logo_permata.png';
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Image.asset(
                      'assets/icons/logo_permata.png',
                      width: 35.w,
                    ),
                    horizontalSpace(10.w),
                    Text(
                      "Permata VA",
                      style: TextStyles.subtitle3,
                    ),
                  ]),
                  // ignore: unrelated_type_equality_checks
                  Obx((() => Get.find<ControllerPayment>().vaCode == "permata"
                      ? const Icon(
                          Icons.check_circle_rounded,
                          color: AppColor.successColor,
                        )
                      : Icon(
                          Icons.circle,
                          color: AppColor.bodyColor.shade200,
                        ))),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.find<ControllerPayment>().vaCode.value = 'cimb';
              Get.find<ControllerPayment>().vaValue.value = '022';
              Get.find<ControllerPayment>().labelPay.value = 'CIMB Bank';
              Get.find<ControllerPayment>().logoPay.value =
                  'assets/icons/logo_cimb.png';
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Image.asset(
                      'assets/icons/logo_cimb.png',
                      width: 35.w,
                    ),
                    horizontalSpace(10.w),
                    Text(
                      "Cimb VA",
                      style: TextStyles.subtitle3,
                    ),
                  ]),
                  // ignore: unrelated_type_equality_checks
                  Obx((() => Get.find<ControllerPayment>().vaCode == "cimb"
                      ? const Icon(
                          Icons.check_circle_rounded,
                          color: AppColor.successColor,
                        )
                      : Icon(
                          Icons.circle,
                          color: AppColor.bodyColor.shade200,
                        ))),
                ],
              ),
            ),
          ),
          //BSI
          // InkWell(
          //   onTap: () {
          //     Get.find<ControllerPayment>().vaCode.value = 'bsi';
          //     Get.find<ControllerPayment>().vaValue.value = '451';
          //     Get.find<ControllerPayment>().labelPay.value = 'Bank Syariah Indonesia';
          //     Get.find<ControllerPayment>().logoPay.value =
          //         'assets/icons/logo_permata.png';
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Row(children: [
          //           Image.asset(
          //             'assets/icons/logo_permata.png',
          //             width: 35.w,
          //           ),
          //           horizontalSpace(10.w),
          //           Text(
          //             "Bank Syariah Indonesia VA",
          //             style: TextStyles.subtitle3,
          //           ),
          //         ]),
          //         // ignore: unrelated_type_equality_checks
          //         Obx((() => Get.find<ControllerPayment>().vaCode == "bsi"
          //             ? const Icon(
          //                 Icons.check_circle_rounded,
          //                 color: AppColor.successColor,
          //               )
          //             : Icon(
          //                 Icons.circle,
          //                 color: AppColor.bodyColor.shade200,
          //               ))),
          //       ],
          //     ),
          //   ),
          // ),
          // InkWell(
          //   onTap: () {
          //     Get.find<ControllerPayment>().vaCode.value = 'maybank';
          //     Get.find<ControllerPayment>().vaValue.value = '013';
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Row(children: [
          //           Image.asset(
          //             'assets/icons/logo_maybank.png',
          //             width: 35.w,
          //           ),
          //           horizontalSpace(10.w),
          //           Text(
          //             "Maybank VA",
          //             style: TextStyles.subtitle3,
          //           ),
          //         ]),
          //         // ignore: unrelated_type_equality_checks
          //         Obx((() => Get.find<ControllerPayment>().vaCode == "maybank"
          //             ? Icon(
          //                 Icons.check_circle_rounded,
          //                 color: AppColor.successColor,
          //               )
          //             : Icon(
          //                 Icons.circle,
          //                 color: AppColor.bodyColor.shade200,
          //               ))),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
