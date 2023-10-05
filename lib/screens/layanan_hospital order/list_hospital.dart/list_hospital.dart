import 'package:bionmed_app/screens/layanan_hospital%20order/detail_hospital/detail_hospital.dart';
import 'package:bionmed_app/screens/layanan_nurse_home/controller/input_layanan_controller.dart';
import 'package:bionmed_app/screens/login/controller_login.dart';
import 'package:bionmed_app/screens/payment/controller_payment.dart';
import 'package:bionmed_app/screens/services/controller_service_on_call.dart';
import 'package:bionmed_app/widgets/appbar/appbar_gradient.dart';
import 'package:bionmed_app/widgets/container/container.dart';
import 'package:bionmed_app/widgets/txt/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListHospital extends StatelessWidget {
  ListHospital({super.key});
  final myC = Get.put(ControllerServiceOnCall());
  final inputC = Get.put(InputLayananController());
  final cLog = Get.put(ControllerLogin());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarGradient('Hospital'),
      body: ListView.builder(
        itemCount: inputC.listDataNurse.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () async {
            Get.find<InputLayananController>().idNurse.value =
                inputC.listDataNurse[index]['id'];
            // ignore: avoid_print
            print(
                'zezen + ${Get.find<InputLayananController>().idNurse.value}');
            if (Get.find<ControllerPayment>().sequenceId.value == 8) {
              await Get.find<InputLayananController>().getDetailAmbulance();
            } else {
              await Get.find<InputLayananController>().getDetailNurse();
            Get.find<InputLayananController>().educationNurse.value =
                Get.find<InputLayananController>()
                    .detailNurse['nurse_educations'];
            }
            // cLog.isloading.isTrue
            //     ? showDialog(
            //         context: context,
            //         builder: (BuildContext context) {
            //           return Align(
            //             alignment: Alignment.center,
            //             child: Container(
            //               width: 300.0,
            //               height: 200.0,
            //               decoration: BoxDecoration(
            //                 color: Colors.transparent,
            //                 borderRadius: BorderRadius.circular(10.0),
            //               ),
            //               child: Padding(
            //                 padding: EdgeInsets.all(20.0),
            //                 child: Center(child: CircularProgressIndicator()),
            //               ),
            //             ),
            //           );
            //         },
            //       )
            //     :

            Get.to(() => DetailHospital(
                  data: inputC.listDataNurse[index],
                ));
          },
          child: Cntr(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            height: 100,
            width: Get.width,
            radius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[200]!, spreadRadius: 1, blurRadius: 5)
            ],
            child: Row(
              children: [
                Cntr(
                  width: 115,
                  height: 85,
                  radius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(inputC.listDataNurse[index]
                              ['hospital']['image'] ??
                          'https://img.freepik.com/free-vector/people-walking-sitting-hospital-building-city-clinic-glass-exterior-flat-vector-illustration-medical-help-emergency-architecture-healthcare-concept_74855-10130.jpg?w=2000&t=st=1694367961~exp=1694368561~hmac=dc0a60debe1925ff62ec0fb9171e5466998617fa775ef32cac6f5113af4dcc42'),
                      fit: BoxFit.cover),
                ),
                // Image.network('https://picsum.photos/seed/picsum/200/300'),
                const SizedBox(
                  width: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Txt(
                            text: inputC.listDataNurse[index]['hospital']
                                ['name'],
                            size: 16,
                            weight: FontWeight.bold,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Txt(
                              text: inputC.listDataNurse[index]['hospital']
                                      ['city'] ??
                                  "null"),
                        ],
                      ),
                      Cntr(
                        width: Get.width / 1.7,
                        padding: const EdgeInsets.all(2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Row(
                            //   children: [
                            //     const Icon(
                            //       Icons.check_circle,
                            //       color: Colors.green,
                            //       size: 15,
                            //     ),
                            //     const SizedBox(
                            //       width: 4.0,
                            //     ),
                            //     Txt(
                            //       text: '2 paket',
                            //       size: 11,
                            //     )
                            //   ],
                            // ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                Txt(
                                  text: inputC.listDataNurse[index]['hospital']
                                          ['rating']
                                      .toString(),
                                  size: 11,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
