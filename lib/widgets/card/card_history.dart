import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../constant/styles.dart';

class CardHistory extends StatelessWidget {
  const CardHistory({
    Key? key,
    this.isLive = false,
  }) : super(key: key);

  final bool isLive;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: defaultPadding, right: defaultPadding, top: 6, bottom: 6),
      padding: const EdgeInsets.all(8),
      // height: 128,
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [AppColor.shadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 86,
                width: 71,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  // color: AppColor.bluePrimary2,
                  image: const DecorationImage(
                      image: AssetImage("assets/images/img-doctor3.jpg"),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Dr. Ketrin Selon",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Doctor On Call",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          // ignore: sized_box_for_whitespace
                          Container(
                            height: 22,
                            width: 22,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/icons/call2.png"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text("Chat",
                              style: TextStyles.callout1
                                  .copyWith(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            // height: 50,
            decoration: BoxDecoration(
                color: AppColor.bgForm, borderRadius: BorderRadius.circular(4)),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              // ignore: sized_box_for_whitespace
              leading: Container(
                  height: 20, child: Image.asset("assets/icons/calendar.png")),
              title: Text(
                "8 Okt 2022, 11:00",
                style: TextStyles.callout1
                    .copyWith(color: AppColor.bodyColor.shade600),
              ),
              trailing: Text(
                "Lihat riwayat",
                style: TextStyles.callout1.copyWith(
                  decoration: TextDecoration.underline,
                  color: AppColor.bluePrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
