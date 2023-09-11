import 'package:bionmed_app/constant/helper.dart';
import 'package:bionmed_app/screens/layanan_nurse_home/controller/input_layanan_controller.dart';
import 'package:bionmed_app/screens/payment/controller_payment.dart';
import 'package:bionmed_app/screens/payment/metode_pembayaran_screen.dart';
import 'package:bionmed_app/screens/payment/voucher_screen.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:bionmed_app/widgets/other/loading_indicator.dart';
import 'package:bionmed_app/widgets/other/show_dialog.dart';
import 'package:bionmed_app/widgets/txt/text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../constant/styles.dart';

class PaymentScreenNurse extends StatefulWidget {
  const PaymentScreenNurse({Key? key}) : super(key: key);
  static const routeName = "/pay_screen";

  @override
  State<PaymentScreenNurse> createState() => _PaymentScreenNurseState();
}

class _PaymentScreenNurseState extends State<PaymentScreenNurse> {
  final inputC = Get.put(InputLayananController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerPayment>(
      init: ControllerPayment(),
      builder: ((controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Pembayaran'),
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
              () => ButtonGradient(
                onPressed: () async {
                  // Get.find<PilihJadwalController>().startDate.value = "";

                  if (controller.vaCode.value == 'ovo' ||
                      controller.vaCode.value == 'dana' ||
                      controller.vaCode.value == "shopeePay" ||
                      controller.vaCode.value == "linkAja") {
                    await controller.orderPlaceByDigital();
                  } else if (controller.vaCode.value == 'bniM') {
                    showPopUp(
                        onTap: () {
                          Get.back();
                        },
                        imageAction: "assets/json/eror.json",
                        description: "Under Development");
                  } else {
                    await controller.createVa();

                    // Get.to(() => PaymentScreenDetai());
                  }
                  // controller.createVa();

                  //   Get.find<ControllerPayment>().dicount.value = 0;
                  // //  Get.find<ControllerPayment>().orderAddVocuher(orderId: Get.find<ControllerPayment>().idOrder.value,voucherId:  )
                  //  Get.find<ControllerPesanan>()
                  //                     .spesialist
                  //                     .value = "";
                  // Get.find<PilihJadwalController>().startDate.value = "";
                  //   Get.find<ControllerPayment>().dates.value = "";
                  //   controller.vaCode.value = "";
                  //   Get.find<ControllerPayment>().paymentChecked.value = {};
                },
                label: "Bayar Sekarang !",
                enable: Get.find<ControllerPayment>().paymentChecked.isEmpty
                    ? false
                    : true,
              ),
            ),
          ),
          body: Obx(
            () => controller.loading.value == true
                ? loadingIndicator(color: AppColor.primaryColor)
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: ListView(children: [
                      Text(
                        "Perawat Yang Di Pilih :",
                        style: TextStyles.subtitle3,
                      ),
                      verticalSpace(10.h),
                      widgetDoctorProfile(),
                      verticalSpace(30.h),
                      widgetCardVoucher(),
                      verticalSpace(15.h),
                      Text(
                        "Pilih pembayaran :",
                        style: TextStyles.subtitle3,
                      ),
                      verticalSpace(15.h),
                      widgetCardPayment(),
                      verticalSpace(20.h),
                      Obx(
                        () => controller.vaCode.value.isEmpty
                            ? widgetChoisePayment()
                            : widgetCardChekedPay(),
                      ),
                      verticalSpace(20.h),
                      widgetDetailOrder(),
                      verticalSpace(20),
                    ]),
                  ),
          ),
        );
      }),
    );
  }

  Container widgetDetailOrder() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.bodyColor.shade300.withOpacity(0.2)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Detail Pesanan",
            style: TextStyles.subtitle2,
          ),
          verticalSpace(15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Jenis Layanan",
                style: TextStyles.subtitle3,
              ),
              Text(
                "${Get.find<ControllerPayment>().dataOrder['service']['name']}",
                // Get.find<ControllerPayment>().dataOrder['service']['name'],
                style:
                    TextStyles.subtitle3.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Harga Konsultasi",
                style: TextStyles.subtitle3,
              ),
              Text(
                priceFormat(double.parse(inputC.priceBeforeDiskon.value)),
                // priceFormat(Get.find<ControllerPayment>()
                //     .dataOrder['service_price']['price']),
                style:
                    TextStyles.subtitle3.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          verticalSpace(10.h),
          Visibility(
            // visible: Get.find<PilihJadwalController>().diskon.value != 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Diskon",
                  style: TextStyles.subtitle3,
                ),
                // Text(
                //   priceFormat((Get.find<ControllerPayment>()
                //           .dataOrder['service_price']['price'] *
                //       Get.find<ControllerPayment>().dataOrder['service_price']
                //           ['discount'] /
                //       100)),
                Text(
                  '${inputC.diskonPesananNurse}%',
                  // priceFormat(
                  //     Get.find<ControllerPayment>().dataOrder['discount']),
                  style: TextStyles.subtitle3.copyWith(
                      fontWeight: FontWeight.bold, color: AppColor.errorColor),
                ),
              ],
            ),
          ),
          Visibility(
            visible: Get.find<ControllerPayment>().dicount.value != 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Diskon Voucher",
                  style: TextStyles.subtitle3,
                ),
                // Text(
                //   priceFormat((Get.find<ControllerPayment>()
                //           .dataOrder['service_price']['price'] *
                //       Get.find<ControllerPayment>().dataOrder['service_price']
                //           ['discount'] /
                //       100)),
                Text(
                  '${Get.find<ControllerPayment>().dicount.value}%',
                  // priceFormat(
                  //     Get.find<ControllerPayment>().dataOrder['discount']),
                  style: TextStyles.subtitle3.copyWith(
                      fontWeight: FontWeight.bold, color: AppColor.errorColor),
                ),
              ],
            ),
          ),
          verticalSpace(20.h),
          widgetCardSubAmount()
        ]),
      ),
    );
  }

  DottedBorder widgetChoisePayment() {
    return DottedBorder(
      color: AppColor.bodyColor.shade300, //color of dotted/dash line
      strokeWidth: 2, //thickness of dash/dots
      dashPattern: const [5, 6],

      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
              child: Text(
            "Pilih metode pembayaran",
            style:
                TextStyles.body2.copyWith(color: AppColor.bodyColor.shade300),
          )),
        ),
      ),
    );
  }

  Container widgetCardVoucher() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFFFF9D8)),
      child: InkWell(
        onTap: () {
          Get.to(() => const VoucherScreen());
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Image.asset(
                  'assets/icons/voucher.png',
                  width: 35.w,
                ),
                horizontalSpace(10.w),
                Text(
                  "Gunakan Voucher",
                  style: TextStyles.subtitle3,
                ),
              ]),
              Row(
                children: [
                  Obx(
                    () => Get.find<ControllerPayment>().dicount.value != 0
                        ? Row(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                size: 20,
                                color: AppColor.successColor,
                              ),
                              horizontalSpace(5),
                              Text(
                                "${Get.find<ControllerPayment>().dicount.value} %",
                                style: TextStyles.subtitle2
                                    .copyWith(color: AppColor.errorColor),
                              ),
                              horizontalSpace(5),
                            ],
                          )
                        : verticalSpace(0),
                  ),
                  const Icon(Icons.arrow_forward_ios),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Container widgetCardChekedPay() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Image.asset(
                Get.find<ControllerPayment>().paymentChecked['logo'],
                width: 35.w,
              ),
              horizontalSpace(10.w),
              Text(
                Get.find<ControllerPayment>().paymentChecked['label'],
                style: TextStyles.subtitle3,
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Container widgetCardPayment() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFF9F9F9)),
      child: InkWell(
        onTap: () {
          Get.to(() => const MetodePaymentScreen());
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Text(
                "Metode Pembayaran",
                style: TextStyles.subtitle3,
              ),
            ]),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }

  Container widgetCardSubAmount() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF00DD23).withOpacity(0.2)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "Total Biaya",
            style: TextStyles.body1,
          ),
          Text(
            priceFormat(double.parse(inputC.totalPriceFix.toString())),
          )
          //  Obx(()=>Get.find<PilihJadwalController>().totalBiayaFixWithVoucher.value == 0.0 ?
          //       Text(
          //         priceFormat(Get.find<PilihJadwalController>().totalBiayaFix.value),
          //         // "${Get.find<PilihJadwalController>().totalBiayaFix.value}",

          //     // priceFormat(Get.find<ControllerPayment>().dataOrder['totalPrice'] -
          //     //     Get.find<ControllerPayment>().dataOrder['discount']),
          //     style: TextStyles.subtitle3.copyWith(
          //         fontWeight: FontWeight.bold, color: AppColor.successColor),
          //   ) : Text(
          //         priceFormat(Get.find<PilihJadwalController>().totalBiayaFixWithVoucher.value),
          //         // "${Get.find<PilihJadwalController>().totalBiayaFix.value}",

          //     // priceFormat(Get.find<ControllerPayment>().dataOrder['totalPrice'] -
          //     //     Get.find<ControllerPayment>().dataOrder['discount']),
          //     style: TextStyles.subtitle3.copyWith(
          //         fontWeight: FontWeight.bold, color: AppColor.successColor),
          //   ),)
        ]),
      ),
    );
  }

  Row widgetDoctorProfile() {
    final inputC = Get.put(InputLayananController());
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      // Get.find<ControllerPayment>().dataOrder['doctor']['image'] == null
      // Image.asset("assets/images/img-doctor1.png"),
      // Image.network("${inputC.detailNurse['image']}" ?? ,
      //   // Get.find<ControllerPayment>().dataOrder['doctor']['image'],
      //   width: 100.w,
      //   fit: BoxFit.contain,
      // ),
      Obx(
        () => SizedBox(
          height: 100,
          width: 100,
          child: CachedNetworkImage(
            imageUrl: inputC.detailNurse['hospital'] == null
                ? inputC.detailNurse['image']
                : inputC.detailNurse['hospital']['image'] ?? 'https://img.freepik.com/free-vector/people-walking-sitting-hospital-building-city-clinic-glass-exterior-flat-vector-illustration-medical-help-emergency-architecture-healthcare-concept_74855-10130.jpg?w=2000&t=st=1694367961~exp=1694368561~hmac=dc0a60debe1925ff62ec0fb9171e5466998617fa775ef32cac6f5113af4dcc42',
            width: Get.width,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                loadingIndicator(color: AppColor.primaryColor),
            errorWidget: (context, url, error) =>
                Image.asset('assets/images/img-doctor2.png'),
          ),
        ),
      ),
      horizontalSpace(10.h),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            inputC.detailNurse['hospital'] == null
                ? inputC.detailNurse['name']
                : inputC.detailNurse['hospital']['name'],
            // Get.find<ControllerPayment>().dataOrder['doctor']['name'],
            style: TextStyles.subtitle2,
          ),
          // Row(
          //   children: [
          //     Image.network(
          //             '${Get.find<ControllerLogin>().dataDoctorDetail['specialist']['image']}',

          //       width: 20.w,
          //     ),
          //     horizontalSpace(10),
          //     SizedBox(
          //       width: 120,
          //       child: Text(
          //               '${Get.find<ControllerLogin>().dataDoctorDetail['specialist']['name']}',

          //         style: TextStyles.subtitle3,
          //       ),
          //     ),
          //   ],
          // ),
          verticalSpace(10.h),
          Visibility(
              visible: inputC.detailNurse['hospital'] != null,
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.green,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Txt(
                      text: Get.find<InputLayananController>()
                          .detailNurse['hospital']['city'])
                ],
              )),
          // Row(
          //   children: [
          //     Row(
          //       children: List.generate(1,
          //           // Get.find<ControllerPayment>().dataOrder['doctor']['rating'],
          //           (index) {
          //         return const Icon(Icons.star,
          //             size: 16, color: AppColor.yellowColor);
          //       }),
          //     ),
          //     horizontalSpace(10),
          //     Text(
          //       "",
          //       // Get.find<ControllerPayment>()
          //       //         .dataOrder['doctor']['rating']
          //       //         .toString() +
          //       //     ".0",
          //       style: TextStyles.subtitle2,
          //     ),
          //   ],
          // ),
        ],
      ),
    ]);
  }
}
