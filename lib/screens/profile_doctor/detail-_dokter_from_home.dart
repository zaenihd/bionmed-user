import 'package:auto_size_text/auto_size_text.dart';
import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/screens/login/controller_login.dart';
import 'package:bionmed_app/screens/payment/controller_payment.dart';
import 'package:bionmed_app/screens/profile_doctor/profil_dokter_controller.dart';
import 'package:bionmed_app/screens/select_service/select_service_screen.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:bionmed_app/widgets/other/loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../services/controller_service_on_call.dart';

class DetailProfileDoctorUmumFromHome extends StatefulWidget {
  const DetailProfileDoctorUmumFromHome({Key? key}) : super(key: key);

  @override
  State<DetailProfileDoctorUmumFromHome> createState() =>
      _DetailProfileDoctorUmumFromHomeState();
}

class _DetailProfileDoctorUmumFromHomeState extends State<DetailProfileDoctorUmumFromHome> {
  final cLog = Get.find<ControllerLogin>();
  final myC = Get.put(ProfileJadwalController());
  @override
  Widget build(BuildContext context) {
    // myC.jadwalDokter();
    return Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: Obx(
          () => cLog.isloading.isTrue
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    Stack(
                      children: [
                        Obx(
                          () => CachedNetworkImage(
                            imageUrl: cLog.dataDoctorDetail['image'] ?? "",
                            width: Get.width,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                loadingIndicator(color: AppColor.primaryColor),
                            errorWidget: (context, url, error) =>
                                Image.asset('assets/images/img-doctor2.png'),
                          ),
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
                                margin:
                                    const EdgeInsets.fromLTRB(26, 20, 26, 16),
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
                                margin:
                                    const EdgeInsets.fromLTRB(26, 20, 26, 16),
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
                          Obx(
                            (() => Text(
                                  cLog.dataDoctorDetail['name'],
                                  style: TextStyles.h5.copyWith(
                                    fontSize: 24,
                                  ),
                                )),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Icon(Icons.person, size: 16),
                                  const SizedBox(width: 10),
                                  Obx(() => Text(
                                      cLog.dataDoctorDetail['old'] ??
                                          // ignore: prefer_adjacent_string_concatenation
                                          "" + " Tahun",
                                      style: TextStyles.subtitle3)),
                                ],
                              ),
                              Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Icon(Icons.business_center, size: 16),
                                  const SizedBox(width: 10),
                                  Obx((() => SizedBox(
                                        width: Get.width / 2,
                                        child: AutoSizeText(
                                            cLog.dataDoctorDetail[
                                                    'experience'] ??
                                                "",
                                            style: TextStyles.subtitle3),
                                      ))),
                                ],
                              ),
                              Obx(
                                (() => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: List.generate(
                                              cLog.dataDoctorDetail['rating'],
                                              (index) {
                                            return const Icon(Icons.star,
                                                size: 16,
                                                color: AppColor.yellowColor);
                                          }),
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                            '${cLog.dataDoctorDetail['rating']}.0',
                                            style: TextStyles.subtitle2),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(height: defaultPadding),
                          Obx(
                            () => Text(
                              cLog.dataDoctorDetail['specialist']['name'] ?? '',
                              style: TextStyles.title1
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            clipBehavior: Clip.antiAlias,
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                  title: Text("Jadwal Dokter",
                                      style: TextStyles.callout1),
                                  leading: Image.asset(
                                      "assets/icons/calendar.png",
                                      height: 26,
                                      width: 26),
                                  collapsedBackgroundColor: AppColor.bgForm,
                                  backgroundColor: AppColor.bgForm,
                                  textColor: AppColor.bodyColor,
                                  iconColor: AppColor.bodyColor,
                                  // childrenPadding: EdgeInsets.symmetric(
                                  //     horizontal: defaultPadding),
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: Get.width / 1.2,
                                          height: 300,
                                          child: ListView.builder(
                                              itemBuilder:
                                                  (context, i) => Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        margin: const EdgeInsets
                                                                .only(
                                                            top: 5,
                                                            left: 5,
                                                            right: 5),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(
                                                                12.0),
                                                          ),
                                                          border: Border.all(
                                                            width: 1.0,
                                                            color: Colors
                                                                .grey[500]!,
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                myC.dataJadwalDokter[
                                                                    i]['days'],
                                                                style: TextStyles
                                                                    .subtitle2),
                                                            Row(
                                                              children: [
                                                                myC.dataJadwalDokter[i]['schedules'].length >
                                                                        2
                                                                    ? Icon(Icons
                                                                        .swap_vert)
                                                                    : const SizedBox(
                                                                        height:
                                                                            1.0,
                                                                      ),
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  height: 50,
                                                                  width: 100,
                                                                  child: ListView
                                                                      .builder(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top: 4,
                                                                        bottom:
                                                                            4),
                                                                    itemCount: myC
                                                                        .dataJadwalDokter[
                                                                            i][
                                                                            'schedules']
                                                                        .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                                index) =>
                                                                            Container(
                                                                      height: myC.dataJadwalDokter[i]['schedules'].length ==
                                                                              1
                                                                          ? 40
                                                                          : 20,
                                                                      width:
                                                                          100,
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child: Text(
                                                                          myC.dataJadwalDokter[i]['isActive'] == false
                                                                              ? "-"
                                                                              : myC.dataJadwalDokter[i]['schedules'][index]['startTime'] + " - " + myC.dataJadwalDokter[i]['schedules'][index]['endTime'],
                                                                          // myC.dataJadwalDokter[
                                                                          //         i][
                                                                          //         'schedules']
                                                                          //         [i]['startTime']
                                                                          //     .toString(),
                                                                          // +
                                                                          //     " - " +
                                                                          //     myC.dataJadwalDokter[i]['schedules'][i]['endTime'],
                                                                          style: TextStyles.subtitle2),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                              itemCount:
                                                  myC.dataJadwalDokter.length),
                                        ),
                                        //  Container(
                                        //   width: 100,
                                        //   height: 200,
                                        //    child: ListView.builder(
                                        //           itemBuilder: (context, i) => Text(
                                        //             myC.dataJadwalDokter[i]['schedules'].toString(),
                                        //             // +
                                        //             //     " - " +
                                        //             //     myC.dataJadwalDokter[i]['schedules'][i]['endTime'],
                                        //             style: TextStyles.subtitle2),
                                        //           itemCount: 2
                                        //             ),
                                        //  ),
                                      ],
                                    )
                                  ]
                                  // List.generate(
                                  //   cLog.doctorSchedul.length,
                                  //   (index) => ListTile(
                                  //     title: Text(myC.dataJadwalDokter[index]['days'],
                                  //         style: TextStyles.subtitle3),
                                  //     trailing: Container(
                                  //       height: 50,
                                  //       width: 100,
                                  //       child: ListView.builder(
                                  //         itemCount: myC.dataJadwalDokter[index]['schedules'].length,
                                  //         itemBuilder: (context, i) => Text(
                                  //           cLog.doctorSchedul[i]['startTime'] +
                                  //               " - " +
                                  //               cLog.doctorSchedul[i]['endTime'],
                                  //           style: TextStyles.subtitle2),)
                                  //     ),
                                  //   ),
                                  // ),
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
                                title: Text("Pendidikan",
                                    style: TextStyles.callout1),
                                leading: Image.asset(
                                    "assets/icons/pendidikan.png",
                                    height: 26,
                                    width: 26),
                                collapsedBackgroundColor: AppColor.bgForm,
                                backgroundColor: AppColor.bgForm,
                                textColor: AppColor.bodyColor,
                                iconColor: AppColor.bodyColor,
                                childrenPadding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                // ignore: prefer_const_literals_to_create_immutables
                                children: List.generate(
                                  cLog.doctorEducation.length,
                                  (index) => ListTile(
                                    title: Text(
                                        cLog.doctorEducation[index]
                                            ['education'],
                                        style: TextStyles.subtitle3),
                                    trailing: Text(
                                        // ignore: prefer_interpolation_to_compose_strings
                                        "${"(" + cLog.doctorEducation[index]['year']})",
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
                                title: Text("Tempat Praktek",
                                    style: TextStyles.callout1),
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
                                  cLog.doctorExperience.length,
                                  (index) => ListTile(
                                    title: Text(
                                        cLog.doctorExperience[index]
                                            ['description'],
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
                                title: Text("Nomor STR",
                                    style: TextStyles.callout1),
                                leading: Image.asset("assets/icons/no_str.png",
                                    height: 26, width: 26),
                                collapsedBackgroundColor: AppColor.bgForm,
                                backgroundColor: AppColor.bgForm,
                                textColor: AppColor.bodyColor,
                                iconColor: AppColor.bodyColor,
                                childrenPadding: EdgeInsets.symmetric(
                                    horizontal: defaultPadding),
                                // ignore: prefer_const_literals_to_create_immutables
                                children: List.generate(
                                  1,
                                  (index) => ListTile(
                                    title: Text(
                                        cLog.dataDoctorDetail['strNumber'] ??
                                            "",
                                        style: TextStyles.subtitle3.copyWith(
                                            fontWeight: FontWeight.w500)),
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
                                title: Text("Nomor SIP",
                                    style: TextStyles.callout1),
                                leading: Image.asset("assets/icons/no_str.png",
                                    height: 26, width: 26),
                                collapsedBackgroundColor: AppColor.bgForm,
                                backgroundColor: AppColor.bgForm,
                                textColor: AppColor.bodyColor,
                                iconColor: AppColor.bodyColor,
                                childrenPadding: EdgeInsets.symmetric(
                                    horizontal: defaultPadding),
                                // ignore: prefer_const_literals_to_create_immutables
                                children: List.generate(
                                  1,
                                  (index) => ListTile(
                                    title: Text(
                                        cLog.dataDoctorDetail['sipNumber'] ??
                                            "",
                                        style: TextStyles.subtitle3.copyWith(
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ],
                ),
        ));
  }
}
