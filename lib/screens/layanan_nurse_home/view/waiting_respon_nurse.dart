import 'package:bionmed_app/screens/layanan_nurse_home/controller/waiting_respon_nurse_controller.dart';
import 'package:bionmed_app/screens/services/service_on_call.dart';
import 'package:get/get.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:bionmed_app/screens/layanan_nurse_home/controller/input_layanan_controller.dart';
import 'package:bionmed_app/screens/payment/controller_payment.dart';
import 'package:bionmed_app/screens/payment/payscreen_nurse.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:bionmed_app/widgets/button/button_primary.dart';
import 'package:bionmed_app/widgets/container/container.dart';
import 'package:bionmed_app/widgets/txt/text.dart';
import 'package:flutter/material.dart';

class WaitingResponNurse extends StatelessWidget {
  WaitingResponNurse({super.key});

  final paymentC = Get.put(ControllerPayment());
  final myC = Get.put(WaitingResponNurseController());

  @override
  Widget build(BuildContext context) {
    myC.startTimer();
    myC.stopWaiting.value = false;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Txt(text: 'Kembali'),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Column(
          children: [
            Center(
              child: AvatarGlow(
                glowColor: Colors.grey,
                endRadius: 100.0,
                duration: const Duration(milliseconds: 2000),
                repeat: true,
                showTwoGlows: true,
                repeatPauseDuration: const Duration(milliseconds: 100),
                child: Material(

                    // Replace this child with your own
                    elevation: 8.0,
                    shape: const CircleBorder(),
                    child: Cntr(
                      radius: BorderRadius.circular(100),
                      height: 150,
                      width: 150,
                      image: DecorationImage(
                          image: NetworkImage(
                            Get.find<InputLayananController>()
                                        .detailNurse['hospital'] ==
                                    null
                                ? Get.find<InputLayananController>()
                                    .detailNurse['image']
                                :  Get.find<InputLayananController>().detailNurse['hospital']
                                            ['image'] ??
                                        'https://img.freepik.com/free-vector/people-walking-sitting-hospital-building-city-clinic-glass-exterior-flat-vector-illustration-medical-help-emergency-architecture-healthcare-concept_74855-10130.jpg?w=2000&t=st=1694367961~exp=1694368561~hmac=dc0a60debe1925ff62ec0fb9171e5466998617fa775ef32cac6f5113af4dcc42',
                          ),
                          fit: BoxFit.cover),
                    )),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Txt(
              text: Get.find<InputLayananController>()
                          .detailNurse['hospital'] ==
                      null
                  ? Get.find<InputLayananController>().detailNurse['name']
                  : Get.find<InputLayananController>().detailNurse['hospital']
                      ['name'],
              size: 24,
              weight: FontWeight.bold,
            ),
            const SizedBox(
            height: 10.0,
            ),
            Visibility(
              visible: Get.find<InputLayananController>().detailNurse['hospital'] != null,
              child: Txt(text: '${Get.find<InputLayananController>().detailNurse['name']}')),
                                    
            // const SizedBox(
            //   height: 5.0,
            // ),
            // Txt(
            //   text: 'Mengurus Lansia',
            //   size: 14,
            //   weight: FontWeight.normal,
            //   color: Colors.grey[400],
            // ),
            const SizedBox(
              height: 40.0,
            ),
            Obx(() => Visibility(
                  visible: myC.nurseReciveOrderStatus.value == 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.access_time_filled_sharp),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Txt(
                        text: 'Menunggu Konfirmasi',
                        size: 14,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                )),
            Obx(() => Visibility(
                  visible: myC.nurseReciveOrderStatus.value == 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Txt(
                        text: 'Gagal',
                        color: Colors.red,
                        size: 14,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                )),
            Obx(() => Visibility(
                  visible: myC.nurseReciveOrderStatus.value == 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      InkWell(
                        onTap: () {
                          myC.stopWaiting.value = true;
                        },
                        child: Txt(
                          text: 'Terkonfirmasi',
                          color: Colors.green,
                          size: 14,
                          weight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )),
            const SizedBox(
              height: 25.0,
            ),
            Obx(() {
              return Visibility(
                visible: myC.nurseReciveOrderStatus.value == 0,
                child: Txt(
                  text:
                      'Menunggu konfirmasi dari perawat\napakah akan menggambil pesanan Anda\natau tidak',
                  color: Colors.grey,
                  textAlign: TextAlign.center,
                ),
              );
            }),
            Obx(() {
              return Visibility(
                visible: myC.nurseReciveOrderStatus.value == 2,
                child: Txt(
                  text:
                      'Mohon maaf pesanan tidak dapat dilanjutkan,\nsilahkan pilih perawat\nlainnya',
                  color: Colors.grey,
                  textAlign: TextAlign.center,
                ),
              );
            }),
            Obx(() {
              return Visibility(
                visible: myC.nurseReciveOrderStatus.value == 1,
                child: Txt(
                  text:
                      'Pesanan anda telah di konfirmasi oleh\nperawat, ayo lanjutkan ',
                  color: Colors.grey,
                  textAlign: TextAlign.center,
                ),
              );
            })
          ],
        ),
        bottomSheet: Obx(
          () => myC.nurseReciveOrderStatus.value == 0
              ? Container(
                  margin: const EdgeInsets.all(20),
                  child: ButtonPrimary(
                      labelStyle: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                      color: const Color(0xFFFFE4E4),
                      onPressed: () {},
                      label: 'Batalkan Pesanan'))
              : myC.nurseReciveOrderStatus.value == 1
                  ? Container(
                      margin: const EdgeInsets.all(20),
                      child: ButtonGradient(
                          onPressed: () {
                            myC.stopWaiting.value = true;
                            Get.to(() => const PaymentScreenNurse());
                          },
                          label: 'Lanjutkan'),
                    )
                  : Container(
                      height: 100,
                      width: Get.width,
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          ButtonGradient(
                              onPressed: () {
                                Get.to(() => ServiceOnCall(
                                      title: Get.find<ControllerPayment>()
                                                  .nameService
                                                  .value ==
                                              2
                                          ? "Personal Doctor"
                                          : Get.find<ControllerPayment>()
                                                      .nameService
                                                      .value ==
                                                  4
                                              ? "Nursing Home"
                                              : Get.find<ControllerPayment>()
                                                          .nameService
                                                          .value ==
                                                      5
                                                  ? "Mother Care"
                                                  : Get.find<ControllerPayment>()
                                                              .nameService
                                                              .value ==
                                                          6
                                                      ? "Baby Care"
                                                      : "Telemedicine",
                                    ));
                              },
                              label: 'Pilih Perawat Lagi'),
                          const SizedBox(
                            height: 10.0,
                          ),
                          ButtonPrimary(
                              labelStyle: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                              color: const Color(0xFFFFE4E4),
                              onPressed: () {},
                              label: 'Batalkan Pesanan')
                        ],
                      ),
                    ),
        ));
  }
}
