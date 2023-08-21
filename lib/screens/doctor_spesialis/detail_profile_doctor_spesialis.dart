import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../select_service/select_service_screen.dart';

class DetailProfileDoctorSpesialis extends StatefulWidget {
  const DetailProfileDoctorSpesialis({Key? key}) : super(key: key);

  @override
  State<DetailProfileDoctorSpesialis> createState() =>
      _DetailProfileDoctorSpesialisState();
}

class _DetailProfileDoctorSpesialisState
    extends State<DetailProfileDoctorSpesialis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: ListView(
        children: [
          Stack(
            children: [
              Image.asset(
                "assets/images/img-doctor3.jpg",
                width: double.infinity,
                height: 280,
                fit: BoxFit.cover,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(26, 20, 26, 16),
                      height: 36,
                      width: 36,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.whiteColor,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 18,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        // _clickBookmark();
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(26, 20, 26, 16),
                      height: 36,
                      width: 36,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        // color: AppColor.whiteColor,
                        color: AppColor.whiteColor,
                      ),
                      child: const Icon(
                        Icons.share,
                        color: AppColor.bodyColor,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: double.infinity,
            transform: Matrix4.translationValues(0.0, -25.0, 0.0),
            decoration: const BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: ListView(
              padding: EdgeInsets.all(defaultPadding),
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              children: [
                Text(
                  "Drs. Ketrin Selon",
                  style: TextStyles.h5.copyWith(
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 10),
                Text('Spesialis',
                    style: TextStyles.subtitle3
                        .copyWith(color: AppColor.bodyColor.shade600)),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 36,
                          width: 36,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: AppColor.weak2Color,
                              borderRadius: BorderRadius.circular(4)),
                          child: Image.asset("assets/icons/paru_paru2.png"),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Paru-Paru",
                          style: TextStyles.subtitle3.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            return const Icon(Icons.star,
                                size: 16, color: AppColor.yellowColor);
                          }),
                        ),
                        const SizedBox(width: 6),
                        Text('5.0', style: TextStyles.subtitle2),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Icon(Icons.person, size: 16),
                        const SizedBox(width: 10),
                        Text("30 Tahun", style: TextStyles.subtitle3),
                      ],
                    ),
                    const SizedBox(width: 26),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Icon(Icons.business_center, size: 16),
                        const SizedBox(width: 10),
                        Text("3 Tahun", style: TextStyles.subtitle3),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: defaultPadding),
                Text(
                  "Pranala",
                  style:
                      TextStyles.title1.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  clipBehavior: Clip.antiAlias,
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: Text("Jadwal Dokter", style: TextStyles.callout1),
                      leading: Image.asset("assets/icons/calendar.png",
                          height: 26, width: 26),
                      collapsedBackgroundColor: AppColor.bgForm,
                      backgroundColor: AppColor.bgForm,
                      textColor: AppColor.bodyColor,
                      iconColor: AppColor.bodyColor,
                      childrenPadding:
                          EdgeInsets.symmetric(horizontal: defaultPadding),
                      // ignore: prefer_const_literals_to_create_immutables
                      children: List.generate(
                        5,
                        (index) => ListTile(
                          title: Text("Senin", style: TextStyles.subtitle3),
                          trailing: Text("10.00 - 12.20",
                              style: TextStyles.subtitle2),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  clipBehavior: Clip.antiAlias,
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: Text("Pendidikan", style: TextStyles.callout1),
                      leading: Image.asset("assets/icons/pendidikan.png",
                          height: 26, width: 26),
                      collapsedBackgroundColor: AppColor.bgForm,
                      backgroundColor: AppColor.bgForm,
                      textColor: AppColor.bodyColor,
                      iconColor: AppColor.bodyColor,
                      childrenPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      // ignore: prefer_const_literals_to_create_immutables
                      children: List.generate(
                        2,
                        (index) => ListTile(
                          title: Text("Sulaiman Al-Rajhi Colleges",
                              style: TextStyles.subtitle3),
                          trailing: Text("(2001)", style: TextStyles.subtitle3),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  clipBehavior: Clip.antiAlias,
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: Text("Tempat Praktek", style: TextStyles.callout1),
                      leading: Image.asset("assets/icons/rs.png",
                          height: 26, width: 26),
                      collapsedBackgroundColor: AppColor.bgForm,
                      backgroundColor: AppColor.bgForm,
                      textColor: AppColor.bodyColor,
                      iconColor: AppColor.bodyColor,
                      childrenPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      // ignore: prefer_const_literals_to_create_immutables
                      children: List.generate(
                        1,
                        (index) => ListTile(
                          title: Text("Rumah Sakit Gunung Salak",
                              style: TextStyles.subtitle3),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  clipBehavior: Clip.antiAlias,
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: Text("Nomor STR", style: TextStyles.callout1),
                      leading: Image.asset("assets/icons/no_str.png",
                          height: 26, width: 26),
                      collapsedBackgroundColor: AppColor.bgForm,
                      backgroundColor: AppColor.bgForm,
                      textColor: AppColor.bodyColor,
                      iconColor: AppColor.bodyColor,
                      childrenPadding:
                          EdgeInsets.symmetric(horizontal: defaultPadding),
                      // ignore: prefer_const_literals_to_create_immutables
                      children: List.generate(
                        1,
                        (index) => ListTile(
                          title: Text("0192312893612761246",
                              style: TextStyles.subtitle3
                                  .copyWith(fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                ButtonGradient(onPressed: () {
                  Get.to(() => const SelectServiceScreen());
                  // print('object');
                }, label: 'Daftar Konsultasi')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
