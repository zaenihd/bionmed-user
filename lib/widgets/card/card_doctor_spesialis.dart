import 'package:bionmed_app/screens/login/controller_login.dart';
import 'package:bionmed_app/screens/profile_doctor/detail_profile_doctor_umum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../constant/styles.dart';

class CardDoctorSpesialis extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  const CardDoctorSpesialis({Key? key, this.data}) : super(key: key);

  @override
  State<CardDoctorSpesialis> createState() => _CardDoctorSpesialisState();
}

class _CardDoctorSpesialisState extends State<CardDoctorSpesialis> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
        Get.find<ControllerLogin>()
            .getDoctorDetail(id: widget.data['id'].toString());
        Get.to(() => const DetailProfileDoctorUmum());
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 7),
        padding: const EdgeInsets.all(6),
        height: 128,
        width: Get.width,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [AppColor.shadow],
        ),
        child: Row(
          children: [
            Image.asset("assets/images/img-doctor2.png"),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  widget.data['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: 26,
                      width: 26,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColor.weak2Color,
                          borderRadius: BorderRadius.circular(4)),
                      child: Image.network(widget.data['specialist']['image']),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      widget.data['specialist']['name'],
                      style: TextStyles.callout1,
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColor.bgForm,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      // ignore: prefer_const_literals_to_create_immutables
                      child: Row(children: [
                        Icon(
                          Icons.business_center,
                          size: 16,
                          color: AppColor.bodyColor[700],
                        ),
                        const SizedBox(width: 6),
                        Text(widget.data['experience'],
                            style: TextStyles.callout2),
                      ]),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColor.bgForm,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      // ignore: prefer_const_literals_to_create_immutables
                      child: Row(children: [
                        Icon(
                          Icons.person,
                          size: 16,
                          color: AppColor.bodyColor[700],
                        ),
                        const SizedBox(width: 6),
                        Text(widget.data['old'], style: TextStyles.callout2),
                      ]),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Row(
                        children: List.generate(
                            widget.data['rating'],
                            (index) => const Icon(
                                  Icons.star,
                                  size: 16,
                                  color: AppColor.yellowColor,
                                ))),
                    const SizedBox(width: 6),
                    Text(widget.data['rating'].toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
