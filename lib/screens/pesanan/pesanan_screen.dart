import 'dart:async';

import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/screens/pesanan/cardPesanan.dart';
import 'package:bionmed_app/screens/pesanan/controller_pesanan.dart';
import 'package:bionmed_app/widgets/other/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../widgets/card/card_konsultasi.dart';

class PesananScreen extends StatefulWidget {
  const PesananScreen({Key? key}) : super(key: key);
  static const routeName = "/pesanan_screen";

  @override
  State<PesananScreen> createState() => _PesananScreenState();
}

class _PesananScreenState extends State<PesananScreen>
    with SingleTickerProviderStateMixin {
  String title = "Pesanan Anda";
  Timer? timer;

  late TabController _tabController;

  final List<Tab> myTabs = <Tab>[
    const Tab(
      text: "Semua",
    ),
    const Tab(
      text: "Berlangsung",
    ),
    const Tab(
      text: "Selesai",
    ),
    const Tab(
      text: "Gagal",
    ),
  ];

  @override
  void initState() {
    _tabController = TabController(length: myTabs.length, vsync: this);
    getData();
    super.initState();
  }

  void getData() {
    // Get.find<ControllerPesanan>().realtimeApi();
    // Get.find<ControllerPesanan>().getOrderAll(status: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get.find<ControllerPesanan>().realtimeApi();

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: Text(title),
        titleTextStyle: TextStyles.subtitle1,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColor.gradient1,
          ),
        ),
      ),
      body: GetBuilder<ControllerPesanan>(
        init: ControllerPesanan(),
        builder: ((controller) {
          return Column(
            children: [
              // give the tab bar a height [can change hheight to preferred height]
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: 12),
                height: 48,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColor.weak2Color,
                  borderRadius: BorderRadius.circular(
                    4.0,
                  ),
                ),
                child: TabBar(
                  isScrollable: true,
                  onTap: ((value) {
                    // Get.find<ControllerPesanan>().getOrderPage(status: 0);
                    // ignore: avoid_print
                    print("order : $value");
                    switch (value) {
                      case 0:
                        Get.find<ControllerPesanan>().getOrderAll(status: 0);

                        break;
                    }
                  }),
                  controller: _tabController,
                  // give the indicator a decoration (color and border radius)
                  indicator: BoxDecoration(
                    gradient: AppColor.gradient1,
                    borderRadius: BorderRadius.circular(
                      4.0,
                    ),
                  ),
                  labelColor: AppColor.whiteColor,
                  unselectedLabelColor: AppColor.bodyColor.shade700,
                  labelStyle:
                      TextStyles.callout1.copyWith(fontWeight: FontWeight.w500),
                  tabs: myTabs,
                ),
              ),
              // tab bar view here
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    RefreshIndicator(
                      onRefresh: () async {
                        Get.find<ControllerPesanan>().getOrderPage(status: 0);
                      },
                      child: Obx(
                        () => controller.loading.value == true
                            ? loadingIndicator(color: AppColor.primaryColor)
                            : controller.dataOrder.isEmpty
                                ? const Center(child: Text("Tidak ada pesanan"))
                                : 
                                ListView.builder(
                                    // NOTE : page konsultasi
                                    // ignore: prefer_const_literals_to_create_immutables
                                    shrinkWrap: true,
                                    itemCount: Get.find<ControllerPesanan>()
                                        .dataOrder
                                        .length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CardPesananService(
                                        data: Get.find<ControllerPesanan>()
                                            .dataOrder[index],
                                      );
                                    },
                                  ),
                      ),
                    ),
                    RefreshIndicator(
                      onRefresh: () async {
                        Get.find<ControllerPesanan>().getOrderPage(status: 0);
                      },
                      child: Obx(
                        () => controller.loading.value == true
                            ? loadingIndicator(color: AppColor.primaryColor)
                            : controller.dataOrder.isEmpty
                                ? const Center(
                                    child:
                                        Text("Tidak ada pesanan berlangsung"))
                                : 
                                CardService1(
                                  myC: Get.find<ControllerPesanan>(),
                                  statusList1: 4,
                                  statusList: 4,
                                )
                                // ListView.builder(
                                //     // NOTE : page konsultasi
                                //     // ignore: prefer_const_literals_to_create_immutables
                                //     shrinkWrap: true,
                                //     itemCount: Get.find<ControllerPesanan>()
                                //         .dataOrder
                                //         .length,
                                //     itemBuilder:
                                //         (BuildContext context, int index) {
                                //       return CardPesananService(
                                //         data: Get.find<ControllerPesanan>()
                                //             .dataOrder[index],
                                //       );
                                //     },
                                //   ),
                      ),
                    ),
                    RefreshIndicator(
                      onRefresh: () async {
                        Get.find<ControllerPesanan>().getOrderPage(status: 0);
                      },
                      child: Obx(
                        () => controller.loading.value == true
                            ? loadingIndicator(color: AppColor.primaryColor)
                            : controller.dataOrder.isEmpty
                                ? const Center(
                                    child: Text("Tidak ada pesanan selesai"))
                                : 
                                CardService1(
                                  myC: Get.find<ControllerPesanan>(),
                                  statusList1: 5,
                                  statusList: 6,
                                )
                                // ListView.builder(
                                //     // NOTE : page konsultasi
                                //     // ignore: prefer_const_literals_to_create_immutables
                                //     shrinkWrap: true,
                                //     itemCount: Get.find<ControllerPesanan>()
                                //         .dataOrder
                                //         .length,
                                //     itemBuilder:
                                //         (BuildContext context, int index) {
                                //       return CardPesananService(
                                //         data: Get.find<ControllerPesanan>()
                                //             .dataOrder[index],
                                //       );
                                //     },
                                //   ),
                      ),
                    ),
                    RefreshIndicator(
                      onRefresh: () async {
                        Get.find<ControllerPesanan>().getOrderPage(status: 0);
                      },
                      child: Obx(
                        () => controller.loading.value == true
                            ? loadingIndicator(color: AppColor.primaryColor)
                            : controller.dataOrder.isEmpty
                                ? const Center(child: Text("Tidak ada pesanan gagal"))
                                : CardService1(
                                  myC: Get.find<ControllerPesanan>(),
                                  statusList1: 99,
                                  statusList: 99,
                                )
                                // ListView.builder(
                                //     // NOTE : page konsultasi
                                //     // ignore: prefer_const_literals_to_create_immutables
                                //     shrinkWrap: true,
                                //     itemCount: Get.find<ControllerPesanan>()
                                //         .dataOrder
                                //         .length,
                                //     itemBuilder:
                                //         (BuildContext context, int index) {
                                //       return CardPesananService(
                                //         data: Get.find<ControllerPesanan>()
                                //             .dataOrder[index],
                                //       );
                                //     },
                                //   ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
