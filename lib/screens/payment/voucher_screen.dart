import 'package:bionmed_app/screens/payment/controller_payment.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:bionmed_app/widgets/input/input_primary.dart';
import 'package:bionmed_app/widgets/other/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../constant/styles.dart';

class VoucherScreen extends StatefulWidget {
  const VoucherScreen({Key? key}) : super(key: key);
  static const routeName = "/voucher_screen";

  @override
  State<VoucherScreen> createState() => _VoucherScreenState();
}

TextEditingController kodeVoucher = TextEditingController();

class _VoucherScreenState extends State<VoucherScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerPayment>(
      init: ControllerPayment(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Pilih Voucher'),
            titleTextStyle: TextStyles.subtitle1,
            elevation: 0.0,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: AppColor.gradient1,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: ListView(children: [
              Text(
                "Gunakan Voucher Anda : ",
                style: TextStyles.subtitle2,
              ),
              verticalSpace(10.h),
              Text(
                "Pilih Voucher Agar Mendapatkan Potongan Harga ",
                style: TextStyles.subtitle3
                    .copyWith(color: AppColor.bodyColor.shade400),
              ),
              verticalSpace(10.h),
              Row(
                children: [
                  SizedBox(
                    width: 200.w,
                    child: InputPrimary(
                        hintText: "Masukkan Kode Voucher",
                        onChange: ((p0) {}),
                        controller: kodeVoucher,
                        onTap: () {}),
                  ),
                  horizontalSpace(10.w),
                  Obx(
                    () => controller.loading.value == true
                        ? loadingIndicator()
                        : SizedBox(
                            width: 90.w,
                            child: ButtonGradient(
                                onPressed: ()async {
                                 await controller.findVoucher(
                                      code: kodeVoucher.text);
                                      kodeVoucher.text = "";
                                      // var harga =double.parse(Get.find<PilihJadwalController>().hargaKonsultasi.value) ;
                                      //             var jumlahDiskon = Get.find<PilihJadwalController>().diskon.value + Get.find<ControllerPayment>().dicount.value;
                                      //             var diskonHome = jumlahDiskon.toDouble();
                                      //             var persenDisko =
                                      //                 jumlahDiskon / 100;
                                      //             Get.find<PilihJadwalController>().totalBiayaFixWithVoucher.value =
                                      //                 harga -
                                      //                     (harga * persenDisko);
                                      //             print("HAHAHAH " +
                                      //                 Get.find<PilihJadwalController>().totalBiayaFixWithVoucher.value
                                      //                     .toString());
                                },
                                label: "Pakai")),
                  ),
                ],
              ),
              verticalSpace(10.w),
              // Text(
              //   "Voucher Saya : ",
              //   style: TextStyles.subtitle2,
              // ),
              // verticalSpace(10.w),
              // widgetCardVoucher(context)
            ]),
          ),
        );
      },
    );
  }

  InkWell widgetCardVoucher(BuildContext context) {
    return InkWell(
      onTap: () {
        detailVoucher(context);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.bodyColor.shade200.withOpacity(0.2)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Image.asset(
              'assets/icons/voucher.png',
              width: 40.w,
            ),
            horizontalSpace(15.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Diskon Konsultasi ",
                      style: TextStyles.subtitle3,
                    ),
                    Text(
                      "50%",
                      style: TextStyles.subtitle1
                          .copyWith(color: AppColor.errorColor),
                    )
                  ],
                ),
                verticalSpace(5),
                Row(
                  children: [
                    Text(
                      "Gunakan voucher ini ",
                      style: TextStyles.small1,
                    ),
                    horizontalSpace(5),
                    Text("Lihat Detail",
                        style: TextStyles.callout1.copyWith(
                          color: AppColor.primaryColor,
                        ))
                  ],
                ),
                verticalSpace(5),
                Row(
                  children: [
                    const Icon(Icons.timelapse),
                    horizontalSpace(10),
                    Text(
                      "1 Hari 12 Jam",
                      style: TextStyles.small1,
                    ),
                  ],
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }

  InkWell widgetCardVoucherDetail(BuildContext context) {
    return InkWell(
      onTap: () {
        // detailVoucher(context);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.bodyColor.shade200.withOpacity(0.2)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Image.asset(
              'assets/icons/voucher.png',
              width: 40.w,
            ),
            horizontalSpace(15.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Diskon Konsultasi ",
                      style: TextStyles.subtitle3,
                    ),
                    Text(
                      "50%",
                      style: TextStyles.subtitle1
                          .copyWith(color: AppColor.errorColor),
                    )
                  ],
                ),
                verticalSpace(5),
                Row(
                  children: [
                    Text(
                      "Gunakan voucher ini ",
                      style: TextStyles.small1,
                    ),
                    // horizontalSpace(5),
                    // Text("Lihat Detail",
                    //     style: TextStyles.callout1.copyWith(
                    //       color: AppColor.primaryColor,
                    //     ))
                  ],
                ),
                verticalSpace(5),
                Row(
                  children: [
                    const Icon(Icons.timelapse),
                    horizontalSpace(10),
                    Text(
                      "1 Hari 12 Jam",
                      style: TextStyles.small1,
                    ),
                  ],
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }

  void detailVoucher(context) {
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
                width: MediaQuery.of(context).size.width / 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColor.bodyColor[300],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: widgetCardVoucherDetail(context),
              ),
              verticalSpace(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Anda dapat menggunakan voucher ini untuk mendapatkan potongan harga sebesar 15.000, clik pakai untuk menggunakan voucher potongan harga dan nikmati berbagai voucher kami lainnya.",
                  style: TextStyles.body2,
                  textAlign: TextAlign.start,
                ),
              ),
              verticalSpace(20.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Syarat & Ketentuan",
                            style: TextStyles.subtitle1.copyWith(
                              color: AppColor.bodyColor,
                            )),
                      ],
                    ),
                    verticalSpace(20.h),
                    Text("1. Khusus pengguna baru",
                        style: TextStyles.subtitle3.copyWith(
                          color: AppColor.bodyColor,
                        )),
                    verticalSpace(20.h),
                    Text("2. Mendapatkan potongan harga sebesar 15.000,-",
                        style: TextStyles.subtitle3.copyWith(
                          color: AppColor.bodyColor,
                        )),
                    verticalSpace(20.h),
                    Text("3. Berlaku untuk waktu yang sudah di tentukan",
                        style: TextStyles.subtitle3.copyWith(
                          color: AppColor.bodyColor,
                        )),
                    verticalSpace(20.h),
                    Text(
                        "4. Dapat di gunakan diatas pembayaran sebesar 50.000,-",
                        style: TextStyles.subtitle3.copyWith(
                          color: AppColor.bodyColor,
                        )),
                  ],
                ),
              ),
              verticalSpace(20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                child: ButtonGradient(
                  onPressed: () {
                    Get.back();
                  },
                  label: "Gunakan Voucher",
                  enable: true,
                ),
              ),
              const SizedBox(height: 26),
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
}
