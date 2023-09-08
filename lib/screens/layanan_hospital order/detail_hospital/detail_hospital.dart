import 'dart:developer';

import 'package:bionmed_app/constant/colors.dart';
import 'package:bionmed_app/screens/layanan_nurse_home/controller/input_layanan_controller.dart';
import 'package:bionmed_app/screens/login/controller_login.dart';
import 'package:bionmed_app/screens/profile_doctor/profil_dokter_controller.dart';
import 'package:bionmed_app/screens/select_service/select_service_screen.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:bionmed_app/widgets/container/container.dart';
import 'package:bionmed_app/widgets/other/loading_indicator.dart';
import 'package:bionmed_app/widgets/txt/text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class DetailHospital extends StatefulWidget {
  DetailHospital({Key? key, this.data}) : super(key: key);
  var data;

  @override
  State<DetailHospital> createState() => _DetailHospitalState();
}

class _DetailHospitalState extends State<DetailHospital> {
  final cLog = Get.put(InputLayananController());
  final myC = Get.put(ProfileJadwalController());
  @override
  Widget build(BuildContext context) {
    // myC.jadwalNurse();
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: ListView(
        children: [
          Stack(
            children: [
              // Obx(
              //   () =>
              CachedNetworkImage(
                  imageUrl: widget.data['hospital']['image'] ?? "",
                  width: Get.width,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      loadingIndicator(color: AppColor.primaryColor),
                  errorWidget: (context, url, error) => Cntr(
                        height: 230,
                        width: Get.width,
                        image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/hospital.png',
                            ),
                            fit: BoxFit.cover),
                      )
                  // Image.asset('assets/images/hospital.png'),
                  ),
              // ),
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
            width: Get.width,
            height: Get.height,
            transform: Matrix4.translationValues(0.0, -25.0, 0.0),
            decoration: const BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Txt(
                  text: widget.data['hospital']['name'] ?? "null",
                  size: 24,
                  weight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.green,
                        ),
                        Txt(text: "${widget.data['hospital']['city']}"),
                      ],
                    ),
                    // const SizedBox(
                    // width: 140.0,
                    // ),
                    Row(
                      children: [
                        RatingBar.builder(
                          itemSize: 20,
                          ignoreGestures: true,
                          initialRating: 5.0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                        const SizedBox(
                          width: 3.0,
                        ),
                        Txt(
                          text: "${widget.data['hospital']['rating']}",
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Cntr(
                  radius: BorderRadius.circular(10),
                  padding: const EdgeInsets.all(15),
                  gradient: AppColor.gradient1,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/icons/hospital.png'),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Txt(
                                text: widget.data['name'],
                                color: Colors.white,
                                weight: FontWeight.bold,
                              ),
                              Txt(
                                text: "${widget.data['hospital']['name']}",
                                weight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Cntr(
                        radius: BorderRadius.circular(5),
                        width: Get.width,
                        padding: const EdgeInsets.all(10),
                        child: Txt(text: "${widget.data['description']}"),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                height: 20.0,
                ),
                Txt(
                  text: 'Detail Rumah Sakit',
                  size: 16,
                  weight: FontWeight.w500,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Cntr(
                  height: 325,
                  color: const Color(0xffECECEC),
                  child: CupertinoScrollbar(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 16),
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/images/icon_hospital.png'),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Txt(text: 'Deskripsi')
                          ],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Txt(text: widget.data['hospital']['description'])
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: ButtonGradient(
          margin: const EdgeInsets.all(24),
          onPressed: () async {
            await cLog.getPaketbyNurseFilter();
            Get.find<ControllerLogin>().priceService.value =
                cLog.detailNurse['service_price_nurses'];
            log(Get.find<ControllerLogin>().priceService.value.toString());
            // Get.find<ControllerPayment>().dates.value = "";
            // Get.find<ControllerServiceOnCall>()
            //     .controllerSearch
            //     .clear();
            // Get.find<ControllerServiceOnCall>()
            //     .searchDoctor
            //     .value = [];
            // Get.find<ControllerPayment>()
            //     .dataPayloadOrder
            //     .clear();
            // Get.find<ControllerPayment>()
            //         .dataPayloadOrder['customerId'] =
            //     cLog.dataUser['customer']['id'];
            // Get.find<ControllerPayment>()
            //         .dataPayloadOrder['doctorId'] =
            //     cLog.detailNurse['id'];
            // // ignore: avoid_print
            // print(Get.find<ControllerPayment>()
            //     .dataPayloadOrder['doctorId']
            //     .toString());
            Get.to(() => const SelectServiceScreen());
          },
          label: "Pesan Sekarang"),
    );
  }
}
