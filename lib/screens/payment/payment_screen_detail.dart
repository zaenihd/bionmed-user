import 'dart:developer';

import 'package:bionmed_app/constant/helper.dart';
import 'package:bionmed_app/screens/home/home.dart';
import 'package:bionmed_app/screens/payment/controller_payment.dart';
import 'package:bionmed_app/screens/pesanan/controller_pesanan.dart';
import 'package:bionmed_app/screens/pilih_jadwal/controllers/pilih_jadwal_controller.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:bionmed_app/widgets/button/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import '../../constant/colors.dart';
import '../../constant/styles.dart';

class PaymentScreenDetai extends StatefulWidget {
  const PaymentScreenDetai({Key? key}) : super(key: key);
  static const routeName = "/pay_screen_detail";

  @override
  State<PaymentScreenDetai> createState() => _PaymentScreenDetaiState();
}

class _PaymentScreenDetaiState extends State<PaymentScreenDetai> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerPayment>(
      init: ControllerPayment(),
      builder: ((controller) {
        String namebank = controller.vaCode.value;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Transfer Bank'),
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
              verticalSpace(10.h),
              batasPembayaran(),
              // widgetDoctorProfile(),
              verticalSpace(30.h),
              widgetCardInformation(),
              verticalSpace(15.h),

              verticalSpace(15.h),
              // widgetCardPayment(),
              verticalSpace(20.h),

              widgetCardNorek(),

              verticalSpace(20.h),

              widgetDetailOrder(),
              verticalSpace(20),
              stepPayment(controller, namebank),
              actionButton(),
              verticalSpace(30)
            ]),
          ),
        );
      }),
    );
  }

  Column stepPayment(ControllerPayment controller, String namebank) {
    return Column(
      children: [
        Row(
          children: const [
            Text("Cara Pembayaran :"),
          ],
        ),
        Accordion(
          // maxOpenSections: 2,
          // headerBackgroundColorOpened: Colors.black54,
          scaleWhenAnimating: true,
          openAndCloseAnimation: true,
          headerPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 0,
          ),
          sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
          sectionClosingHapticFeedback: SectionHapticFeedback.light,
          children: [
            AccordionSection(
              // isOpen: true,
              rightIcon: const Icon(
                Icons.keyboard_arrow_down,
                color: AppColor.bodyColor,
              ),
              headerBackgroundColor: const Color(0xffFBFBFB),
              headerBackgroundColorOpened: const Color(0xffFBFBFB),
              header: Text('ATM ${controller.vaCode.value}',
                  style: const TextStyle(
                    color: AppColor.bodyColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  )),
              content: Text(
                "1. Masukkan Kartu ATM ${controller.vaCode.value} & PIN \n 2. Pilih menu Transfer > VA Billing \n 3. Pada Halaman Konfirmasi pembayaran, pastikan detail pembayaran anda sudah sesuai seperti No   VA, Nama, Layanan dan Total Tagihan \n  5. Masukkan 5 angka kode perusahaan untuk       AsisitenKu (xxxxx) dan Nomor HP yang terdaftar di akun  Biommed Anda (Cth : xxxxx089564435456) \n   6. Pembayaran diproses, selesai! dan Simpan struk / Bukti Transaksi Pembayaran Anda",
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColor.bodyColor,
                  fontWeight: FontWeight.w400,
                  height: 2.2,
                ),
              ),
              contentBackgroundColor: const Color(0xffFBFBFB),
              contentHorizontalPadding: 0,
              contentBorderWidth: 0,
              // onOpenSection: () => print('onOpenSection ...'),
              // onCloseSection: () => print('onCloseSection ...'),
            ),
            AccordionSection(
              // isOpen: true,
              rightIcon: const Icon(
                Icons.keyboard_arrow_down,
                color: AppColor.bodyColor,
              ),
              headerBackgroundColor: const Color(0xffFBFBFB),
              headerBackgroundColorOpened: const Color(0xffFBFBFB),
              header: Text('${controller.vaCode.value} Mobile',
                  style: const TextStyle(
                    color: AppColor.bodyColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  )),
              content: Text(
                "1. Lakukkan Log in pada aplikasi  Mobile $namebank \n2. Pilih menu Transfer > Virtual Account Billing \n3.  Masukkan No VA / No.Billing dan Nama singkat   anda \n4. Konfirmasi transaksi dengan Masukkan PIN & Nominal Bayar \n5. Pembayaran selesai. ",
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColor.bodyColor,
                  fontWeight: FontWeight.w400,
                  height: 2.2,
                ),
              ),
              contentBackgroundColor: const Color(0xffFBFBFB),
              contentHorizontalPadding: 0,
              contentBorderWidth: 0,
              // onOpenSection: () => print('onOpenSection ...'),
              // onCloseSection: () => print('onCloseSection ...'),
            ),
            AccordionSection(
              // isOpen: true,
              rightIcon: const Icon(
                Icons.keyboard_arrow_down,
                color: AppColor.bodyColor,
              ),
              headerBackgroundColor: const Color(0xffFBFBFB),
              headerBackgroundColorOpened: const Color(0xffFBFBFB),
              header: Text('Internet Banking ${controller.vaCode.value}',
                  style: const TextStyle(
                    color: AppColor.bodyColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  )),
              content: Text(
                "1. Login oada alamat Internet Banking $namebank \n  (https://ibank.$namebank.co.id) \n2. Pilih menu Transaksi > Transfer > Virtual Account   Billing \n3. Pada Kolom Nomor VA/Nomor Billing, masukkan 5   angka kode perusahaan untuk AsisitenKu (xxxxx)   dan Nomor HP yang terdaftar di akun Biommed Anda (Cth : xxxxx089564435456) \n4. Pada Halaman konfirmasi, pastikan detail pembayaran anda sudah sesuai seperti No VA, Nama, Layanan dan Total Tagihan \n5. Masukkan Kode Otentikasi dan mToken anda \n6. Pembayaran anda selesai!",
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColor.bodyColor,
                  fontWeight: FontWeight.w400,
                  height: 2.2,
                ),
              ),
              contentBackgroundColor: const Color(0xffFBFBFB),
              contentHorizontalPadding: 0,
              contentBorderWidth: 0,
              // onOpenSection: () => print('onOpenSection ...'),
              // onCloseSection: () => print('onCloseSection ...'),
            ),
            AccordionSection(
              // isOpen: true,
              rightIcon: const Icon(
                Icons.keyboard_arrow_down,
                color: AppColor.bodyColor,
              ),
              headerBackgroundColor: const Color(0xffFBFBFB),
              headerBackgroundColorOpened: const Color(0xffFBFBFB),
              header: Text('Outlet Bank ${controller.vaCode.value}',
                  style: const TextStyle(
                    color: AppColor.bodyColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  )),
              content: Text(
                "1. Ambil no. antrian transaksi Teller dan isi Formulir setoran rekening \n2. Serahkan Formulir dan jumlah setoran kepada  Teller $namebank \n3. Teller $namebank akan melakukkan validasi transaksi \n4. Simpan formulir setoran hasil validasi sebagai bukti pembayaran anda",
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColor.bodyColor,
                  fontWeight: FontWeight.w400,
                  height: 2.2,
                ),
              ),
              contentBackgroundColor: const Color(0xffFBFBFB),
              contentHorizontalPadding: 0,
              contentBorderWidth: 0,
              // onOpenSection: () => print('onOpenSection ...'),
              // onCloseSection: () => print('onCloseSection ...'),
            ),
          ],
        ),
      ],
    );
  }

  Column actionButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ButtonGradient(
          onPressed: () {
            Get.offAll(() => const Home(
                  indexPage: 2,
                ));
          },
          label: "Cek Status Pesanan ? ",
        ),
        verticalSpace(20),
        ButtonPrimary(
          color: AppColor.bodyColor.shade300,
          onPressed: () {},
          label: "Ubah Metode Pembayaran",
        ),
        verticalSpace(20),
        ButtonPrimary(
          color: AppColor.redColor,
          onPressed: () {},
          label: "Batalkan Pembayaran ? ",
        ),
      ],
    );
  }

  SizedBox batasPembayaran() {
    return SizedBox(
      width: 100.w,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text("Batas Pembayaran Anda"),
            verticalSpace(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.timelapse_sharp,
                  color: AppColor.redColor,
                ),
                horizontalSpace(5),
                Text(
                  Get.find<ControllerPayment>().dataOrderPayment['expired'] ??
                      "",
                  style: const TextStyle(color: AppColor.redColor),
                ),
              ],
            ),
            verticalSpace(20),
            const Text(
              "Pembayaran akan otomatis gagal bila waktu di atas telah habis",
              style: TextStyle(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
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
              Text(
                "Jenis Layanan",
                style: TextStyles.subtitle3,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Durasi Layanan",
                style: TextStyles.subtitle3,
              ),
              Text(
                "${Get.put(PilihJadwalController()).durasiLayanan.value} Menit",
                style:
                    TextStyles.subtitle3.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          verticalSpace(10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Harga Konsultasi",
                style: TextStyles.subtitle3,
              ),
              Text(
                priceFormat(
                  Get.find<ControllerPayment>()
                            .dataOrder['service_price'] !=
                        null
                    ? Get.find<ControllerPayment>().dataOrder['service_price']
                        ['price']
                    :  Get.find<ControllerPayment>().dataOrder['totalPrice']
                    //  Get.find<ControllerPesanan>().dataOrderChoice['order']
                    //     ['totalPrice']
                    //  Get.find<ControllerPesanan>().dataOrderChoice['order']
                    //     ['service_price']['price']
                        ),
                style:
                    TextStyles.subtitle3.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          verticalSpace(10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  log('zen ${Get.find<ControllerPayment>().dataOrder}');
                },
                child: Text(
                  "Diskon",
                  style: TextStyles.subtitle3,
                ),
              ),
              // Text(
              //   priceFormat((Get.find<ControllerPayment>()
              //           .dataOrder['service_price']['price'] *
              //       Get.find<ControllerPayment>().dataOrder['service_price']
              //           ['discount'] /
              //       100)),
              Text(
                    Get.find<ControllerPayment>().dataOrder['discount'] == null ? 
                        "${Get.find<ControllerPesanan>().dataOrderChoice['order']
                            ['discount']}%" : "${Get.find<ControllerPayment>().dataOrder['discount']}%",
                style: TextStyles.subtitle3.copyWith(
                    fontWeight: FontWeight.bold, color: AppColor.errorColor),
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
                "Pembayaran Via",
                style: TextStyles.subtitle3,
              ),
              // Text(
              //   priceFormat((Get.find<ControllerPayment>()
              //           .dataOrder['service_price']['price'] *
              //       Get.find<ControllerPayment>().dataOrder['service_price']
              //           ['discount'] /
              //       100)),
              Text(
                   Get.find<ControllerPayment>().paymentChecked['label'] ?? "",
                style: TextStyles.subtitle3.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
          verticalSpace(20.h),
          widgetCardSubAmount()
        ]),
      ),
    );
  }

  Container widgetCardInformation() {
    return Container(
      width: 300.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: const Color(0xFFFFF9D8)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              "Setelah melakukan pembayaran silahkan mulai konsultasi bersama dokter dengan mengakses halaman Transaksi",
              style: TextStyles.body2,
            ),
          ],
        ),
      ),
    );
  }

  Container widgetCardNorek() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Image.asset(
                    Get.find<ControllerPayment>().paymentChecked['logo'] ?? "",
                    width: 35.w,
                  ),
                  horizontalSpace(10.w),
                  Text(
                    Get.find<ControllerPayment>().paymentChecked['label'] ?? "",
                    style: TextStyles.subtitle3,
                  ),
                ]),
              ],
            ),
            verticalSpace(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("No. Virtual Account :"),
                    verticalSpace(5),
                    Text(
                      Get.find<ControllerPayment>()
                              .dataOrderPayment['va_number'] ??
                          "",
                      style: TextStyles.subtitle1,
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      Clipboard.setData(ClipboardData(
                              text: Get.find<ControllerPayment>()
                                      .dataOrderPayment['va_number'] ??
                                  ""))
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Copied to clipboard")));
                      });
                    });
                  },
                  icon: const Icon(
                    Icons.file_copy,
                    size: 21,
                    color: Color(0xff838383),
                  ),
                ),
              ],
            )
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
                          .dataOrderChoice['order']['totalPrice']),
                  style: TextStyles.subtitle3.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColor.successColor),
                )
        ]),
      ),
    );
  }

  Row widgetDoctorProfile() {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Get.find<ControllerPayment>().dataOrder['doctor']['image'] != null
          ? Image.network(
              Get.find<ControllerPayment>().dataOrder['doctor']['image'])
          : Image.network(Get.find<ControllerPayment>().dataOrder['order']
              ['doctor']['image']),
      horizontalSpace(10.h),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Get.find<ControllerPayment>().dataOrder['doctor']['name'] ??
                Get.find<ControllerPayment>().dataOrder['order']['doctor']
                    ['name'],
            style: TextStyles.subtitle2,
          ),
          verticalSpace(10),
          Text(
            "Spesialis",
            style: TextStyles.subtitle3,
          ),
          verticalSpace(10.h),
          Row(
            children: [
              Image.asset(
                "assets/icons/paru_paru2.png",
                width: 20.w,
              ),
              horizontalSpace(10),
              Text(
                "Paru - Paru",
                style: TextStyles.subtitle3,
              ),
            ],
          ),
          verticalSpace(10.h),
          Get.find<ControllerPayment>().dataOrder['doctor']['rating'] != null
              ? Row(
                  children: [
                    Row(
                      children: List.generate(
                          Get.find<ControllerPayment>().dataOrder['doctor']
                                  ['rating'] ??
                              "", (index) {
                        return const Icon(Icons.star,
                            size: 16, color: AppColor.yellowColor);
                      }),
                    ),
                    horizontalSpace(10),
                    Text(
                      "${Get.find<ControllerPayment>()
                              .dataOrder['doctor']['rating']}.0",
                      style: TextStyles.subtitle2,
                    ),
                  ],
                )
              : Row(
                  children: [
                    Row(
                      children: List.generate(
                          Get.find<ControllerPesanan>().dataOrderChoice['order']
                                  ['doctor']['rating'] ??
                              "", (index) {
                        return const Icon(Icons.star,
                            size: 16, color: AppColor.yellowColor);
                      }),
                    ),
                    horizontalSpace(10),
                    Text(
                      "${Get.find<ControllerPesanan>()
                              .dataOrderChoice['order']['doctor']['rating']}.0",
                      style: TextStyles.subtitle2,
                    ),
                  ],
                )
        ],
      ),
    ]);
  }
}
