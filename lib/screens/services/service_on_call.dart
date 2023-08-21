import 'package:bionmed_app/constant/colors.dart';
import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/screens/login/controller_login.dart';
import 'package:bionmed_app/screens/payment/controller_payment.dart';
import 'package:bionmed_app/screens/pesanan/controller_pesanan.dart';
import 'package:bionmed_app/screens/services/controller_service_on_call.dart';
import 'package:bionmed_app/widgets/card/card_perawat.dart';
import 'package:bionmed_app/widgets/card/card_rec_doctor.dart';
import 'package:bionmed_app/widgets/other/title_tile.dart';
import 'package:bionmed_app/widgets/search/form_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../history/history_screen.dart';
import '../layanan_nurse_home/controller/input_layanan_controller.dart';

class ServiceOnCall extends StatefulWidget {
  final String title;
  const ServiceOnCall({Key? key, required this.title}) : super(key: key);

  @override
  State<ServiceOnCall> createState() => _ServiceOnCallState();
}

class _ServiceOnCallState extends State<ServiceOnCall> {
  final myC = Get.put(ControllerServiceOnCall());
  final inputC = Get.put(InputLayananController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        titleTextStyle: TextStyles.subtitle1,
        title: Text(widget.title),
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () => Get.to(() => const HistoryScreen()),
              icon: const Icon(Icons.history))
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColor.gradient1,
          ),
        ),
      ),
      body:
          Obx(() => 
      inputC.listDataNurse.isNotEmpty ? 
      ListView(
                  padding: const EdgeInsets.only(top: 20),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                      child: TitleTile(
                          title: "Rekomendasi Perawat Sekitar Anda",
                          onTap: () {}),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                      child: Text(
                        "Perawat Sekitar Anda",
                        style: TextStyles.callout1.copyWith(
                            color: AppColor.bodyColor.shade600,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    ListView.builder(
                        itemCount:  inputC.listDataNurse
                            .length,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return CardPerawat(
                            id:  inputC.listDataNurse[index]['id'],
                            data: inputC.listDataNurse[index],

                          );
                        }),
                    const SizedBox(height: 20),
                    SizedBox(height: defaultPadding),
                  ],
                ):
          Get.find<ControllerPesanan>().listDokterHomeVisit.isNotEmpty
              ? ListView(
                  padding: const EdgeInsets.only(top: 20),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                      child: TitleTile(
                          title: "Rekomendasi Dokter Sekitar Anda",
                          onTap: () {}),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                      child: Text(
                        "Dokter Sekitar Anda",
                        style: TextStyles.callout1.copyWith(
                            color: AppColor.bodyColor.shade600,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    ListView.builder(
                        itemCount: Get.find<ControllerPesanan>()
                            .listDokterHomeVisit
                            .length,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return CardRecDoctor(
                            data: Get.find<ControllerPesanan>()
                                .listDokterHomeVisit[index],
                          );
                        }),
                    const SizedBox(height: 20),
                    SizedBox(height: defaultPadding),
                  ],
                )
              : Get.find<ControllerLogin>().doctorByService.isEmpty
                  ? 
                  // Get.find<ControllerPayment>().serviceId.value == 4
                Get.find<ControllerPayment>().sequenceId.value == 4

                   ? const Center(child: Text("Perawat tidak tersedia ")) : const Center(child: Text("Dokter tidak tersedia "))
                  : Get.find<ControllerPesanan>().idSpesialist.value == ""
                      ? ListView(
                          padding: const EdgeInsets.only(top: 20),
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultPadding, vertical: 16),
                              child: const FormSearch(
                                  hinText: "Cari dokter yang sesuai..."),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultPadding),
                              child: TitleTile(
                                  title: "Rekomendasi Untuk Anda !",
                                  onTap: () {},
                                  isAll: true),
                            ),
                            SizedBox(height: defaultPadding - 10),
                            ListView.builder(
                                itemCount: myC.searchDoctor.isEmpty
                                    ? Get.find<ControllerLogin>()
                                        .doctorByService
                                        .length
                                    : myC.searchDoctor.length,
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return CardRecDoctor(
                                    data: myC.searchDoctor.isEmpty
                                        ? Get.find<ControllerLogin>()
                                            .doctorByService[index]
                                        : myC.searchDoctor[index],
                                  );
                                }),
                          ],
                        )
                      : ListView(
                          padding: const EdgeInsets.only(top: 20),
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultPadding),
                              child: TitleTile(
                                  title: "Dokter Spesialis", onTap: () {}),
                            ),
                            const SizedBox(height: 4),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultPadding),
                              child: Text(
                                "Cari dokter berdasarkan dengan Spesialis",
                                style: TextStyles.callout1.copyWith(
                                    color: AppColor.bodyColor.shade600,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            ListView.builder(
                                itemCount: Get.find<ControllerLogin>()
                                    .doctorBySpesialis
                                    .length,
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return CardRecDoctor(
                                    data: Get.find<ControllerLogin>()
                                        .doctorBySpesialis[index],
                                  );
                                }),
                            const SizedBox(height: 20),
                            SizedBox(height: defaultPadding),
                          ],
                        )),
    );
  }
}
