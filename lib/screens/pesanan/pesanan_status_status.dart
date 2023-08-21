import 'package:bionmed_app/constant/helper.dart';
import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/screens/home/home.dart';
import 'package:bionmed_app/screens/payment/controller_payment.dart';
import 'package:bionmed_app/screens/pesanan/controller_pesanan.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../constant/colors.dart';
import '../pilih_jadwal/controllers/pilih_jadwal_controller.dart';

class PesananStatusScreen extends StatefulWidget {
  const PesananStatusScreen({Key? key}) : super(key: key);
  static const routeName = "/pesanan_status_screen";

  @override
  State<PesananStatusScreen> createState() => _PesananStatusScreenState();
}

class _PesananStatusScreenState extends State<PesananStatusScreen>
    with SingleTickerProviderStateMixin {
  String title = "Status Transaksi Anda";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ButtonGradient(
          onPressed: () {
            // ignore: prefer_const_constructors
            Get.offAll(() => Home(
                  indexPage: 2,
                ));
          },
          label: "Cek pesanan Anda sekarang ",
        ),
      ),
      appBar: AppBar(
        title: Text(title),
        titleTextStyle: TextStyles.subtitle1,
        elevation: 0.0,
        // leading: IconButton(
        //     onPressed: () {

        //     },
        //     icon: Icon(Icons.arrow_back)),
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColor.gradient1,
          ),
        ),
      ),
      body: Column(
        children: [
          widgetStatusWaiting(),
          verticalSpace(30.h),
          wodgetTabInvoice(),
          verticalSpace(20.h),
          Get.find<ControllerPayment>().dataOrder['service'] == null ||
                  // ignore: unnecessary_null_comparison
                  Get.find<ControllerPesanan>().dataOrderChoice == null
              ? verticalSpace(0)
              : widgetDetailOrder()
        ],
      ),
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
              InkWell(
                onTap: () {
                  // ignore: avoid_print
                  print('zen${Get.find<PilihJadwalController>().namaLayanan.value}');
                  
                },
                child: Text(
                  "Jenis Layanan",
                  style: TextStyles.subtitle3,
                ),
              ),
              Text(
                Get.find<ControllerPayment>().dataOrder['service'] != null
                    ? Get.find<ControllerPayment>().dataOrder['service']['name']
                    : Get.find<ControllerPesanan>().dataOrderChoice['order']
                        ['service']['name'],
                style:
                    TextStyles.subtitle3.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          verticalSpace(10.h),
          Get.find<PilihJadwalController>().namaLayanan.value == "Home Visit" || Get.find<PilihJadwalController>().namaLayanan.value == "Nursing Home"? const SizedBox(
          height: 0.0,
          ) : 
            Get.find<ControllerPayment>().sequenceId.value == 4 || Get.find<ControllerPayment>().sequenceId.value == 5 ||  Get.find<ControllerPayment>().sequenceId.value == 6 ?
            const SizedBox(
            height: 1.0,
            ) : 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Durasi Layanan",
                style: TextStyles.subtitle3,
              ),
              Text(
                Get.find<PilihJadwalController>().durasiLayanan.value,
                style:
                    TextStyles.subtitle3.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
           Get.find<ControllerPayment>().sequenceId.value == 4 || Get.find<ControllerPayment>().sequenceId.value == 5 ||  Get.find<ControllerPayment>().sequenceId.value == 6 ?
           const SizedBox(
           height: 1.0,
           ) : 
          verticalSpace(10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Harga Konsultasi",
                style: TextStyles.subtitle3,
              ),
                Get.find<ControllerPayment>().sequenceId.value == 4 || Get.find<ControllerPayment>().sequenceId.value == 5 ||  Get.find<ControllerPayment>().sequenceId.value == 6 ?
              Text(
                priceFormat(Get.find<ControllerPayment>()
                            .dataOrder['service_price_nurse'] !=
                        null
                    ? Get.find<ControllerPayment>().dataOrder['service_price_nurse']
                        ['price']
                    : Get.find<ControllerPesanan>().dataOrderChoice['order']
                        ['service_price_nurse']['price']),
                style:
                    TextStyles.subtitle3.copyWith(fontWeight: FontWeight.bold),
              ) :
              Text(
                priceFormat(Get.find<ControllerPayment>()
                            .dataOrder['service_price'] !=
                        null
                    ? Get.find<ControllerPayment>().dataOrder['service_price']
                        ['price']
                    : Get.find<ControllerPesanan>().dataOrderChoice['order']
                        ['service_price']['price']),
                style:
                    TextStyles.subtitle3.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          verticalSpace(10.h),
            Get.find<ControllerPayment>().sequenceId.value == 4 || Get.find<ControllerPayment>().sequenceId.value == 5 ||  Get.find<ControllerPayment>().sequenceId.value == 6 ?
            Row(
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
                Text('${Get.find<ControllerPayment>().dataOrder['discount']}%',
                  // priceFormat(
                  //     Get.find<ControllerPayment>().dataOrder['discount']),
                  style: TextStyles.subtitle3.copyWith(
                      fontWeight: FontWeight.bold, color: AppColor.errorColor),
                ),
              ],
            ) :
           Visibility(
            visible: Get.find<PilihJadwalController>().diskon.value != 0,
            child: 
            Row(
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
                Text('${Get.find<PilihJadwalController>().diskon.value}%',
                  // priceFormat(
                  //     Get.find<ControllerPayment>().dataOrder['discount']),
                  style: TextStyles.subtitle3.copyWith(
                      fontWeight: FontWeight.bold, color: AppColor.errorColor),
                ),
              ],
            ),
          ),
          verticalSpace(10.h),
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
              Text('${Get.find<ControllerPayment>().dicount.value}%',
                // priceFormat(
                //     Get.find<ControllerPayment>().dataOrder['discount']),
                style: TextStyles.subtitle3.copyWith(
                    fontWeight: FontWeight.bold, color: AppColor.errorColor),
              ),
            ],
          ),),
          verticalSpace(10.h),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       "Diskon",
          //       style: TextStyles.subtitle3,
          //     ),
          //     // Text(
          //     //   priceFormat((Get.find<ControllerPayment>()
          //     //           .dataOrder['service_price']['price'] *
          //     //       Get.find<ControllerPayment>().dataOrder['service_price']
          //     //           ['discount'] /
          //     //       100)),
          //     Text(
          //           "${Get.find<ControllerPayment>().dataOrder['discount']} % ",
          //       style: TextStyles.subtitle3.copyWith(
          //           fontWeight: FontWeight.bold, color: AppColor.errorColor),
          //     ),
          //   ],
          // ),
          widgetCardSubAmount()
        ]),
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
          Get.find<ControllerPayment>().dataOrder['totalPrice'] != null
              ? Text(
                  priceFormat(
                      Get.find<ControllerPayment>().dataOrder['totalPrice']),
                  style: TextStyles.subtitle3.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColor.successColor),
                )
              : Text(
                  priceFormat(Get.find<ControllerPesanan>()
                          .dataOrderChoice['order']['totalPrice']
                      //      -
                      // Get.find<ControllerPesanan>().dataOrderChoice['order']
                      //     ['discount']
                          ),
                  style: TextStyles.subtitle3.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColor.successColor),
                )
        ]),
      ),
    );
  }

  Padding wodgetTabInvoice() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DottedBorder(
          dashPattern: const [8, 4],
          strokeCap: StrokeCap.butt,
          color: AppColor.bodyColor.shade300,
          radius: const Radius.circular(5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("No. Invoice :"),
                        verticalSpace(5),
                        Text(
                          "INV/20229876/FL/82761",
                          style: TextStyles.subtitle2,
                        ),
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios_outlined)
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Column widgetStatusWaiting() {
    return Column(
      children: [
        verticalSpace(30.h),
        Center(
          child: LottieBuilder.asset(
            'assets/json/waiting.json',
            width: 100.w,
          ),
        ),Obx(()=>
        Text(
          Get.find<ControllerPesanan>().dataOrder[0]["order"]['status'] == 2 || Get.find<ControllerPesanan>().dataOrder[0]["order"]['status'] == 1? "Pembayaran Berhasil" : 
          "Menunggu Pembayaran",
            style: TextStyles.subtitle1.copyWith(
              color: AppColor.bodyColor.shade400,
            ),),)
      ],
    );
  }

  Column widgetStatusSucces() {
    return Column(
      children: [
        verticalSpace(30.h),
        Center(
          child: LottieBuilder.asset(
            'assets/json/succes.json',
            width: 150.w,
          ),
        ),
        Text("Pembayaran Berhasil",
            style: TextStyles.subtitle1.copyWith(
              color: AppColor.successColor,
            ))
      ],
    );
  }

  Column widgetStatusFail() {
    return Column(
      children: [
        verticalSpace(30.h),
        Center(
          child: LottieBuilder.asset(
            'assets/json/eror.json',
            width: 150.w,
          ),
        ),
        Text("Pembayaran Gagal",
            style: TextStyles.subtitle1.copyWith(
              color: AppColor.errorColor,
            ))
      ],
    );
  }
}
