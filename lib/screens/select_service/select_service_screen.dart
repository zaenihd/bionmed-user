import 'dart:developer';

import 'package:bionmed_app/screens/layanan_hospital%20order/indput_data_order_ambulance/screen/detail_pesanan_ambulance.dart';
import 'package:bionmed_app/screens/layanan_nurse_home/controller/input_layanan_controller.dart';
import 'package:bionmed_app/screens/login/controller_login.dart';
import 'package:bionmed_app/screens/payment/controller_payment.dart';
import 'package:bionmed_app/widgets/card/card_select_service.dart';
import 'package:bionmed_app/widgets/other/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../constant/styles.dart';
import '../../widgets/container/container.dart';
import '../../widgets/txt/text.dart';

class SelectServiceScreen extends StatefulWidget {
  SelectServiceScreen({Key? key, this.data}) : super(key: key);
  var data;

  @override
  State<SelectServiceScreen> createState() => _SelectServiceScreenState();
}

final inputC = Get.put(InputLayananController());

class _SelectServiceScreenState extends State<SelectServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(onTap: () {}, child: const Text('Pilih Layanan')),
        titleTextStyle: TextStyles.subtitle1,
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColor.gradient1,
          ),
        ),
      ),
      body: Obx(
        () => Get.find<ControllerPayment>().loading.value == true
            ? Center(child: loadingIndicator())
            : ListView.builder(
                padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: 15),
                itemCount:
                    // Get.find<ControllerPayment>().serviceId.value == 4
                    Get.find<ControllerPayment>().sequenceId.value == 4 ||
                            Get.find<ControllerPayment>().sequenceId.value ==
                                5 ||
                            Get.find<ControllerPayment>().sequenceId.value ==
                                6 ||
                            Get.find<ControllerPayment>().sequenceId.value == 8
                        ? Get.put(InputLayananController())
                            .listPaketDataNurse
                            .length
                        : Get.find<ControllerLogin>().priceService.length,
                itemBuilder: (BuildContext context, int index) {
                  // return
                  if (Get.find<ControllerPayment>().sequenceId.value == 8) {
                    return cardPaketAmbulance(index);
                  } else {
                    return CardSelectService(
                      // paketNurseSop: Get.find<ControllerPayment>().serviceId.value == 9 ? Get.put(InputLayananController()).listPaketDataNurse[index]['package']['package_nurse_sops'][index] : '',
                      dataPaketFilter:
                          // Get.find<ControllerPayment>().serviceId.value == 4
                          Get.find<ControllerPayment>().sequenceId.value == 4 ||
                                  Get.find<ControllerPayment>()
                                          .sequenceId
                                          .value ==
                                      5 ||
                                  Get.find<ControllerPayment>()
                                          .sequenceId
                                          .value ==
                                      6
                              ? Get.put(InputLayananController())
                                  .listPaketDataNurse[index]
                              : '',
                      dataNurse:
                          // Get.find<ControllerPayment>().serviceId.value == 4
                          Get.find<ControllerPayment>().sequenceId.value == 4 ||
                                  Get.find<ControllerPayment>()
                                          .sequenceId
                                          .value ==
                                      5 ||
                                  Get.find<ControllerPayment>()
                                          .sequenceId
                                          .value ==
                                      6
                              ? Get.put(InputLayananController())
                                          .detailNurse['service_price_nurses']
                                      [index] ??
                                  Get.put(InputLayananController())
                                          .detailNurse['service_price_nurses']
                                      [index]
                              : '',
                      data: Get.find<ControllerLogin>().priceService[index],
                    );
                  }
                },
              ),
      ),
    );
  }

  cardPaketAmbulance(int index) {
    return InkWell(
      onTap: () {
        for (var i = 0;
            i <
                inputC
                    .listPaketDataNurse[index]['service_price_zona_ambulances']
                    .length;
            i++) {
          inputC.servicePriceIdAmbulance.value =
              inputC.listPaketDataNurse[index]['service_price_zona_ambulances']
                  [i]['servicePriceAmbulanceId'];
          inputC.endCityAmbulance.value = inputC.listPaketDataNurse[index]
              ['service_price_zona_ambulances'][i]['city'];
        }
        log(inputC.servicePriceIdAmbulance.value.toString() +
            inputC.endCityAmbulance.value.toString());
        Get.to(() => DataPesananAMbulance(
              data: widget.data,
              dataPaket: inputC.listPaketDataNurse[index]
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColor.whiteColor,
            boxShadow: [AppColor.shadow],
            gradient: AppColor.gradient1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(inputC.listPaketDataNurse[index]['name'],
                    style: TextStyles.body1.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(
                  height: 5.0,
                ),
                Text(inputC.listPaketDataNurse[index]['type'],
                    style: TextStyles.body1.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: Colors.white)),
                Visibility(
                  visible: inputC.listPaketDataNurse[index]
                              ['service_price_zona_ambulances']
                          .toString() !=
                      "[]",
                  child: Text(
                      "Tersedia ${inputC.listPaketDataNurse[index]['service_price_zona_ambulances'].length} Zona CSR",
                      style: TextStyles.body1.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.yellow)),
                )
              ],
            ),
            Visibility(
              visible: inputC.listPaketDataNurse[index]['discount'] != 0,
              child: Cntr(
                  radius: BorderRadius.circular(10),
                  padding: const EdgeInsets.all(10),
                  color: Colors.white,
                  child: Txt(
                    text: '${inputC.listPaketDataNurse[index]['discount']}%',
                    color: Colors.red,
                    weight: FontWeight.bold,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
