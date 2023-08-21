import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../constant/styles.dart';

class CardPesanan extends StatelessWidget {
  const CardPesanan({
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
                      image: AssetImage("assets/images/img-hemaviton.png"),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Hemaviton", style: TextStyles.h5),
                  const SizedBox(height: 8),
                  Text("1 Set", style: TextStyles.subtitle3),
                  const SizedBox(height: 8),
                  Text("Rp. 90.000",
                      style:
                          TextStyles.h6.copyWith(color: AppColor.greenColor)),
                  const SizedBox(height: 10),
                  // ignore: sized_box_for_whitespace
                  Container(
                    height: 26,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        // ignore: deprecated_member_use
                        primary: AppColor.bluePrimary2,
                        // ignore: deprecated_member_use
                        onSurface: Colors.transparent,
                      ),
                      child: Text(
                        "Sedang Dikemas",
                        style: TextStyles.callout1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
