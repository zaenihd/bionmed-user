import 'package:bionmed_app/constant/colors.dart';
import 'package:bionmed_app/screens/layanan_nurse_home/controller/input_layanan_controller.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:bionmed_app/widgets/container/container.dart';
import 'package:bionmed_app/widgets/input/input_primary.dart';
import 'package:bionmed_app/widgets/other/loading_indicator.dart';
import 'package:bionmed_app/widgets/txt/text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DataPesananAMbulance extends StatefulWidget {
  const DataPesananAMbulance({Key? key}) : super(key: key);

  @override
  State<DataPesananAMbulance> createState() => _DataPesananAMbulanceState();
}

class _DataPesananAMbulanceState extends State<DataPesananAMbulance> {
  final cLog = Get.put(InputLayananController());
  // final myC = Get.put(ProfileJadwalController());
  // final myC = Get.put(MapsController());

  @override
  Widget build(BuildContext context) {
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
                              'assets/images/ambulance.png',
                            ),
                            fit: BoxFit.cover),
                      )
                  // Image.asset('assets/images/hospital.png'),
                  ),
              Padding(
                padding: const EdgeInsets.only(left: 45, top: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/ambulance1.png'),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Txt(
                      text: 'Layanan',
                      size: 20,
                      weight: FontWeight.w300,
                    ),
                    Txt(
                      text: 'Ambulance',
                      size: 20,
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
              )
              // ),
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
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(24),
              children: [
                Txt(
                  text: 'Detail Pesanan',
                  size: 16,
                  weight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Txt(
                  text: 'Detail Pesanan Anda',
                  color: Color(0xff7C7C7C),
                  size: 11,
                  weight: FontWeight.normal,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Cntr(
                  radius: BorderRadius.circular(10),
                  width: Get.width,
                  padding: EdgeInsets.all(18),
                  color: Color(0xffCCCCCC),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Txt(
                            text: 'Layanan',
                            color: Color(0xff7C7C7C),
                          ),
                          Txt(
                            text: 'Ambulance Jenazah',
                            color: Colors.black,
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Txt(
                            text: 'Jadwal',
                            color: Color(0xff7C7C7C),
                          ),
                          Txt(
                            text: '13, Juni 2023',
                            color: Colors.black,
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                tujuanAmbulance(),
                const SizedBox(
                  height: 20.0,
                ),
                Cntr(
                  radius: BorderRadius.circular(10),
                  width: Get.width,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  color: Color.fromARGB(62, 0, 221, 37),
                  child: Row(
                    children: [
                      Txt(
                        text: 'Total Biaya',
                        color: Colors.black,
                        weight: FontWeight.normal,
                      ),
                      Txt(
                        text: 'Rp 1.000.000',
                        color: Color(0xff0B9444),
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ButtonGradient(onPressed: () async{

                  }, label: "Pesan Sekarang"),
      ),
    );
  }

  Cntr tujuanAmbulance() {
    return Cntr(
      width: Get.width,
      padding: EdgeInsets.all(25),
      color: Colors.grey[300],
      radius: BorderRadius.circular(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.green,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Txt(text: 'Alamat'),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Icon(
                        Icons.edit_note_rounded,
                        size: 18,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Txt(
                    text: 'Jl.Padjajaran',
                    weight: FontWeight.bold,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.green,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Txt(text: 'Tujuan'),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Icon(
                        Icons.edit_note_rounded,
                        size: 18,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Txt(
                    text: 'Jl.Padjajaran',
                    weight: FontWeight.bold,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
