import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/screens/login/controller_login.dart';
import 'package:bionmed_app/widgets/card/card_artikel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';

class ArticelScreen extends StatefulWidget {
  const ArticelScreen({Key? key}) : super(key: key);
  static const routeName = "/transaksi_screen";

  @override
  State<ArticelScreen> createState() => _ArticelScreenState();
}

class _ArticelScreenState extends State<ArticelScreen> {
  String title = "Artikel untuk Anda";

  @override
  Widget build(BuildContext context) {
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
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: Get.find<ControllerLogin>().dataArticel.length,
            itemBuilder: (BuildContext context, int index) {
              return CardArtikel(
                data: Get.find<ControllerLogin>().dataArticel[index],
              );
            },
          ),
        ),
      ),
    );
  }
}

class CardTransaksi extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;

  const CardTransaksi({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.height,
      margin: const EdgeInsets.only(bottom: 16),
      // height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColor.whiteColor,
        boxShadow: [AppColor.shadow],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 86,
                width: 68,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                      image: NetworkImage(data['order']['doctor']['image']),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data['order']['doctor']['name'], style: TextStyles.h5),
                  const SizedBox(height: 8),
                  Text(data['order']['service']['name'],
                      style: TextStyles.small1),
                  const SizedBox(height: 8),
                  data['order']['status'] == 0
                      ? Row(
                          children: [
                            Icon(
                              Icons.fact_check,
                              color: AppColor.bodyColor.shade300,
                            ),
                            horizontalSpace(10),
                            Text(
                              "Belum Bayar",
                              style: TextStyles.callout1.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.bodyColor.shade300),
                            )
                          ],
                        )
                      : data['order']['status'] == 1
                          ? Row(
                              children: [
                                Icon(
                                  Icons.fact_check,
                                  color: AppColor.successColor.withOpacity(0.2),
                                ),
                                horizontalSpace(10),
                                Text(
                                  "Berhasil",
                                  style: TextStyles.callout1.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.successColor),
                                )
                              ],
                            )
                          : data['order']['status'] == 2
                              ? Row(
                                  children: [
                                    Icon(Icons.schedule,
                                        color: Colors.yellow.shade300),
                                    horizontalSpace(10),
                                    Text(
                                      "Terjadwalkan",
                                      style: TextStyles.callout1.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.yellow),
                                    )
                                  ],
                                )
                              : data['order']['status'] == 3
                                  ? Row(
                                      children: [
                                        Icon(Icons.start,
                                            color: Colors.green.shade300),
                                        horizontalSpace(10),
                                        Text(
                                          "mulai sekarang",
                                          style: TextStyles.callout1.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green),
                                        )
                                      ],
                                    )
                                  : data['order']['status'] == 4
                                      ? Row(
                                          children: [
                                            Icon(Icons.work_history,
                                                color: Colors.green.shade300),
                                            horizontalSpace(10),
                                            Text(
                                              "Sedang Berlangsung",
                                              style: TextStyles.callout1
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.green),
                                            )
                                          ],
                                        )
                                      : data['order']['status'] == 4
                                          ? Row(
                                              children: [
                                                Icon(Icons.done_outline_sharp,
                                                    color:
                                                        Colors.green.shade300),
                                                horizontalSpace(10),
                                                Text(
                                                  "Selesai",
                                                  style: TextStyles.callout1
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.green),
                                                )
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                Icon(Icons.sms_failed,
                                                    color: Colors.red.shade300),
                                                horizontalSpace(10),
                                                Text(
                                                  "Gagal",
                                                  style: TextStyles.callout1
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.red),
                                                )
                                              ],
                                            ),
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 12),
            // height: 50,
            decoration: BoxDecoration(
                color: AppColor.bgForm, borderRadius: BorderRadius.circular(4)),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              // ignore: sized_box_for_whitespace
              leading: Container(
                  height: 18, child: Image.asset("assets/icons/bni.png")),
              title: Text(
                "BNI Virtual Account",
                style:
                    TextStyles.callout1.copyWith(fontWeight: FontWeight.w500),
              ),
              trailing: IconButton(
                onPressed: () {},
                iconSize: 18,
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
