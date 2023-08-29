import 'package:bionmed_app/constant/colors.dart';
import 'package:bionmed_app/screens/layanan_nurse_home/controller/input_layanan_controller.dart';
import 'package:bionmed_app/screens/profile_doctor/profil_dokter_controller.dart';
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
  const DetailHospital({Key? key}) : super(key: key);

  @override
  State<DetailHospital> createState() => _DetailHospitalState();
}

class _DetailHospitalState extends State<DetailHospital> {
  final cLog = Get.put(InputLayananController());
  final myC = Get.put(ProfileJadwalController());
  @override
  Widget build(BuildContext context) {
    myC.jadwalNurse();
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: ListView(
        children: [
          Stack(
            children: [
              // Obx(
              //   () =>
              CachedNetworkImage(
                  imageUrl: cLog.detailNurse['image'] ?? "",
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
                  text: 'Rumah Sakit Dedari',
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
                        Txt(text: 'Kupang'),
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
                          text: "5.0",
                          weight: FontWeight.bold,
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                height: 10.0,
                ),
                Txt(text: 'Detail Rumah Sakit', size: 16, weight: FontWeight.w500,),
                const SizedBox(
                height: 10.0,
                ),
                Cntr(
                  height: 325,
                  color: const Color(0xffECECEC),
                  child: CupertinoScrollbar(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
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
                        Txt(
                            text:
                                'Lorem ipsum dolor sit amet consectetur. A volutpat elementum leo ut id nunc enim eleifend auctor. Molestie ac in nulla sit. In etiam molestie cum eget non sodales egestas. Tortor vitae mi consectetur morbi. \nVitae fermentum dictumst tempor est congue tellus tortor nulla. Pellentesque egestas in at cursus egestas.\n\n 1.Lorem ipsum\n2.Lorem ipsum\n2.Lorem ipsum\n\nVitae fermentum dictumst tempor est congue tellus tortor nulla. Pellentesque egestas in at cursus egestas.Vitae fermentum dictumst tempor est congue tellus tortor nulla. Pellentesque egestas in at cursus egestas.')
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                ButtonGradient(onPressed: () {}, label: "Pesan Sekarang"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
