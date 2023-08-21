// ignore_for_file: file_names

import 'package:bionmed_app/screens/pesanan/controller_pesanan.dart';
import 'package:bionmed_app/widgets/card/card_konsultasi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CardService1 extends StatelessWidget {
  CardService1({
    Key? key,
    required this.myC,
    required this.statusList,
    required this.statusList1,
    this.statusList2,
  }) : super(key: key);

  final ControllerPesanan myC;
  int statusList;
  int statusList1;
  int? statusList2;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => myC.dataOrder.isNotEmpty
          ? RefreshIndicator(
              onRefresh: () {
                myC.getOrderAll(status: 0);
                return Future.delayed(const Duration(seconds: 1));
              },
              child: ListView.builder(
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: myC.dataOrder.length,
                  itemBuilder: (context, index) {
                    // ignore: unused_local_variable
                    var layanan =
                        myC.dataOrder[index]['user']['role'] == 'nurse'
                            ? myC.dataOrder[index]['order']
                                ['service_price_nurse']['name']
                            : myC.dataOrder[index]['order']['service_price']
                                ['name'];
                    // ignore: unused_local_variable
                    var dataService =
                        myC.dataOrder[index]['order']['service']['name'];
                    var dataLayanan = myC.dataOrder[index]['order']['status'];
                    return dataLayanan == statusList ||
                            dataLayanan == statusList1 ||
                            dataLayanan == statusList2
                        ? CardPesananService(
                            data:
                                Get.find<ControllerPesanan>().dataOrder[index],
                          )
                        : const SizedBox(
                            width: 1.0,
                          );
                  }),
            )
          : const Center(child: Text("Tidak ada data")),
    );
  }
}
