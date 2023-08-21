import 'package:bionmed_app/screens/layanan_nurse_home/controller/input_layanan_controller.dart';
import 'package:bionmed_app/screens/login/controller_login.dart';
import 'package:bionmed_app/screens/payment/controller_payment.dart';
import 'package:bionmed_app/widgets/other/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../constant/styles.dart';
import '../../widgets/card/card_select_service.dart';

class SelectServiceScreen extends StatefulWidget {
  const SelectServiceScreen({Key? key}) : super(key: key);

  @override
  State<SelectServiceScreen> createState() => _SelectServiceScreenState();
}

class _SelectServiceScreenState extends State<SelectServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            print(Get.find<ControllerLogin>().priceService.toString());
          },
          child: const Text('Pilih Layaaanan')),
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
                            Get.find<ControllerPayment>().sequenceId.value == 6
                        ? Get.put(InputLayananController())
                            .listPaketDataNurse
                            .length
                        : Get.find<ControllerLogin>().priceService.length,
                itemBuilder: (BuildContext context, int index) {
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
                                    .detailNurse['service_price_nurses'][index]
                            : '',
                    data: Get.find<ControllerLogin>().priceService[index],
                  );
                },
              ),
      ),
    );
  }
}
