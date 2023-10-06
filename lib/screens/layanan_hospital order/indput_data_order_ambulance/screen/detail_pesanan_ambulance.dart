import 'package:bionmed_app/constant/colors.dart';
import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/screens/layanan_hospital%20order/indput_data_order_ambulance/controller/input_data_order_ambulance_controller.dart';
import 'package:bionmed_app/screens/layanan_hospital%20order/indput_data_order_ambulance/screen/waiting_response_ambulance.dart';
import 'package:bionmed_app/screens/layanan_nurse_home/controller/input_layanan_controller.dart';
import 'package:bionmed_app/screens/pesanan/maps.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:bionmed_app/widgets/container/container.dart';
import 'package:bionmed_app/widgets/other/loading_indicator.dart';
import 'package:bionmed_app/widgets/txt/text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/card/card_select_service.dart';
import '../../../../widgets/other/show_dialog.dart';

class DataPesananAMbulance extends StatefulWidget {
  DataPesananAMbulance({Key? key, required this.data, required this.dataPaket})
      : super(key: key);
  var data;
  var dataPaket;

  @override
  State<DataPesananAMbulance> createState() => _DataPesananAMbulanceState();
}

class _DataPesananAMbulanceState extends State<DataPesananAMbulance> {
  // final inputC = Get.put(InputLayananController());
  // final myC = Get.put(ProfileJadwalController());
  final myC = Get.put(MapsController());
  final controller = Get.put(InputDataOrderAmbulanceController());
  final inputC = Get.put(InputLayananController());

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
                  imageUrl: inputC.detailNurse['image'] ?? "",
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
            height: 650,
            transform: Matrix4.translationValues(0.0, -25.0, 0.0),
            decoration: const BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(24),
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
                  color: const Color(0xff7C7C7C),
                  size: 11,
                  weight: FontWeight.normal,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Cntr(
                  radius: BorderRadius.circular(10),
                  width: Get.width,
                  padding: const EdgeInsets.all(18),
                  // color: const Color(0xffCCCCCC),
                  gradient: AppColor.gradient1,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Txt(
                            text: 'Jadwal',
                            color: Colors.white,
                          ),
                          Txt(
                            text: controller.tanggalC.text,
                            color: Colors.white,
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
                            text: 'Layanan',
                            color: Colors.white,
                          ),
                          Txt(
                            text: widget.dataPaket['name'],
                            color: Colors.white,
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      InkWell(
                        onTap: () {
                          zonaCsr(context);
                        },
                        child: Cntr(
                          radius: BorderRadius.circular(10),
                          alignment: Alignment.center,
                          width: Get.width,
                          border: Border.all(color: Colors.white),
                          color: Colors.transparent,
                          padding: const EdgeInsets.all(15),
                          child: Txt(
                            text: 'Lihat zona CSR',
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Txt(
                          text: 'Tentukan tujuan',
                          size: 16,
                          weight: FontWeight.w500,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Txt(
                          text: 'Masukkan tujuan lokasi anda',
                          size: 11,
                          weight: FontWeight.normal,
                        ),
                      ],
                    ),
                    Image.asset('assets/icons/icons_map.png')
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                tujuanAmbulance(),
                const SizedBox(
                  height: 20.0,
                ),
                Obx(
                  () => controller.isCrs.isFalse
                      ? const SizedBox(
                          height: 1.0,
                        )
                      : Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Txt(
                              text: 'Anda termasuk zona',
                              color: Colors.amber,
                            ),
                            Txt(
                              text: ' CSR Rumah Sakit (Gratis)',
                              color: Colors.amber,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Cntr(
                  radius: BorderRadius.circular(10),
                  width: Get.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  color: const Color.fromARGB(62, 0, 221, 37),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Txt(
                        text: 'Total Biaya',
                        color: Colors.black,
                        weight: FontWeight.normal,
                      ),
                      Obx(
                        () => controller.isCrs.isTrue
                            ? Txt(
                                text: "Gratis",
                                color: const Color(0xff0B9444),
                                weight: FontWeight.bold,
                              )
                            : Txt(
                                text: (CurrencyFormat.convertToIdr(
                                    (widget.dataPaket['price'] -
                                        (widget.dataPaket['price'] *
                                            widget.dataPaket['discount'] /
                                            100)),
                                    0)),
                                color: const Color(0xff0B9444),
                                weight: FontWeight.bold,
                              ),
                      )
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
        child: Obx(() => ButtonGradient(
            onPressed: () async {
              if (myC.city.isEmpty) {
                showPopUp(
                    onTap: () {
                      Get.back();
                    },
                    imageAction: "assets/json/eror.json",
                    description: "Mohon isi Alamat anda\nterlebih dahulu");
              } else {
                if (controller.isLoading.isFalse) {
                  inputC.diskonPesananNurse.value =
                      widget.dataPaket['discount'];
                  inputC.priceBeforeDiskon.value =
                      widget.dataPaket['price'].toString();
                  inputC.totalPrice.value =
                      '${(widget.dataPaket['price'] - (widget.dataPaket['price'] * inputC.diskonPesananNurse.value / 100))}';
                  inputC.totalPriceDouble.value =
                      double.parse(inputC.totalPrice.value);
                  inputC.totalPriceFix.value = inputC.totalPriceDouble.toInt();
                  await controller.addOrderAmbulance(
                      ambulanceId: widget.dataPaket['ambulanceId'],
                      servicePriceAmbulanceId: widget.dataPaket['id'],
                      discount: widget.dataPaket['discount'],
                      totalPrice: inputC.totalPriceFix.value,
                      endLat: widget.data['hospital']['lat'],
                      endLong: widget.data['hospital']['long'],
                      endDistrict: widget.data['hospital']['district'],
                      endCity: widget.data['hospital']['city'],
                      endCountry: widget.data['hospital']['country'],
                      endProvince: myC.kabupaten.value);

                  Get.to(() => WaitingResponAmbulance(
                        data: widget.data,
                      ));
                } else {}
              }
              // await inputC.getPaketbyAmbulanceFilter();
              // Get.to(() =>  SelectServiceScreen());
            },
            label:
                controller.isLoading.isTrue ? "Loading..." : "Pesan Sekarang")),
      ),
    );
  }

  Cntr tujuanAmbulance() {
    return Cntr(
      width: Get.width,
      // padding: const EdgeInsets.all(25),
      // color: Colors.grey[300],
      // radius: BorderRadius.circular(10),
      child:
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Row(
          //       children: [
          //         const Icon(
          //           Icons.location_on,
          //           color: Colors.green,
          //         ),
          //         const SizedBox(
          //           width: 10.0,
          //         ),
          //         Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Row(
          //               children: [
          //                 Txt(text: 'Alamat'),
          //                 const SizedBox(
          //                   width: 6.0,
          //                 ),
          //                 InkWell(
          //                   onTap: () async {
          //                     myC.isTujuan.value = false;
          //                     controller.isLoadingAlamat.value = true;
          //                     await myC.getCurrentLocation().then((value) {
          //                       myC.lat.value = value.latitude;
          //                       myC.long.value = value.longitude;
          //                     });
          //                     await myC.getUserLocation();
          //                     Get.to(() => const Maaapp());
          //                     controller.isLoadingAlamat.value = false;
          //                   },
          //                   child: const Icon(
          //                     Icons.edit_note_rounded,
          //                     size: 18,
          //                   ),
          //                 )
          //               ],
          //             ),
          //             const SizedBox(
          //               height: 10.0,
          //             ),
          //             SizedBox(
          //               // height: 30,
          //               width: Get.width / 1.7,
          //               child: Obx(() => Txt(
          //                     text: controller.isLoadingAlamat.isTrue
          //                         ? "Membuat Map...."
          //                         :
          //                         myC.city.isEmpty ? "Alamat anda" :
          //                         '${myC.desa.value} ${myC.kecamatan.value} ${myC.city.value}, ${myC.kabupaten.value}, ${myC.kodePos.value}, ${myC.negara.value}',
          //                     weight:myC.city.isEmpty ? FontWeight. FontWeight.bold,
          //                   )),
          //             ),
          //           ],
          //         )
          //       ],
          //     ),
          //     const SizedBox(
          //       height: 20.0,
          //     ),
          //     Row(
          //       children: [
          //         const Icon(
          //           Icons.location_on,
          //           color: Colors.green,
          //         ),
          //         const SizedBox(
          //           width: 10.0,
          //         ),
          //         Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Row(
          //               children: [
          //                 Txt(text: 'Tujuan'),
          //                 const SizedBox(
          //                   width: 6.0,
          //                 ),
          //                 InkWell(
          //                   onTap: () async {
          //                     myC.isTujuan.value = true;
          //                     controller.isLoadingTujuan.value = true;
          //                     await myC.getCurrentLocation().then((value) {
          //                       myC.latTujuan.value = value.latitude;
          //                       myC.longTujuan.value = value.longitude;
          //                     });
          //                     await myC.getUserLocation();
          //                     Get.to(() => const Maaapp());
          //                     controller.isLoadingTujuan.value = false;
          //                   },
          //                   child: const Icon(
          //                     Icons.edit_note_rounded,
          //                     size: 18,
          //                   ),
          //                 )
          //               ],
          //             ),
          //             const SizedBox(
          //               height: 10.0,
          //             ),
          //             SizedBox(
          //               // height: 30,
          //               width: Get.width / 1.7,
          //               child: Obx(() => Txt(
          //                     text: controller.isLoadingTujuan.isTrue
          //                         ? "Membuat Map...."
          //                         : '${myC.desaTujuan.value} ${myC.kecamatanTujuan.value} ${myC.cityTujuan.value}, ${myC.kabupatenTujuan.value}, ${myC.kodePosTujuan.value}, ${myC.negaraTujuan.value}',
          //                     weight: FontWeight.bold,
          //                   )),
          //             ),
          //           ],
          //         )
          //       ],
          //     ),
          //   ],
          // ),

          Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () async {
                      controller.serviceAmbulance.value = 1;
                      myC.isTujuan.value = false;
                      controller.isLoadingAlamat.value = true;
                      await myC.getCurrentLocation().then((value) {
                        myC.lat.value = value.latitude;
                        myC.long.value = value.longitude;
                      });
                      await myC.getUserLocation();
                      controller.endCityCsr.value = widget.dataPaket['service_price_zona_ambulances'][0]['city'];
                      Get.to(() => const Maaapp());
                      controller.isLoadingAlamat.value = false;
                    },
                    child: Cntr(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      height: 45,
                      alignment: Alignment.centerLeft,
                      width: Get.width / 1.3,
                      color: AppColor.bgForm,
                      radius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[300]!),
                      child: Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Cntr(
                                color: Colors.transparent,
                                width: Get.width / 1.6,
                                child: Txt(
                                  textOverFlow: TextOverflow.ellipsis,
                                  text: controller.isLoadingAlamat.isTrue
                                      ? "Memuat maps.."
                                      : myC.city.isNotEmpty
                                          ? '${myC.desa.value} ${myC.kecamatan.value} ${myC.city.value}, ${myC.kabupaten.value}, ${myC.kodePos.value}, ${myC.negara.value}'
                                          : 'Masukkan posisi alamat anda',
                                  color: myC.city.isNotEmpty
                                      ? Colors.black
                                      : AppColor.bodyColor.shade500,
                                ),
                              ),
                              const Icon(
                                Icons.map,
                                color: Colors.green,
                              )
                            ],
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    onTap: () async {
                      // myC.isTujuan.value = true;
                      // controller.isLoadingTujuan.value = true;
                      // await myC.getCurrentLocation().then((value) {
                      //   myC.latTujuan.value = value.latitude;
                      //   myC.longTujuan.value = value.longitude;
                      // });
                      // await myC.getUserLocation();
                      // Get.to(() => const Maaapp());
                      // controller.isLoadingTujuan.value = false;
                    },
                    child: Cntr(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      height: 45,
                      alignment: Alignment.centerLeft,
                      width: Get.width / 1.3,
                      color: AppColor.bgForm,
                      radius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[300]!),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Cntr(
                            color: Colors.transparent,
                            width: Get.width / 1.6,
                            child: Txt(
                                textOverFlow: TextOverflow.ellipsis,
                                maxLines: 1,
                                text: widget.data['address'],
                                color: Colors.black),
                          ),
                          const Icon(
                            Icons.map,
                            color: Colors.green,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Image.asset('assets/icons/arrow.png')
            ],
          ),
        ],
      ),
    );
  }

  zonaCsr(BuildContext context) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return SizedBox(
              height: 600,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 18, top: 14),
                            width: Get.width / 1.9,
                            height: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffEDEDED)),
                          ),
                          Image.asset('assets/icons/scr.png'),
                          const SizedBox(
                            height: 20.0,
                          ),
                          const Text(
                            'Zona gratis (CSR)',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: 280,
                            width: Get.width,
                            child: ListView.builder(
                              itemCount: widget
                                  .dataPaket['service_price_zona_ambulances']
                                  .length,
                              itemBuilder: (context, index) => Cntr(
                                margin: EdgeInsets.symmetric(
                                    horizontal: defaultPadding, vertical: 5),
                                color: Colors.grey[200],
                                radius: BorderRadius.circular(10),
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: Get.width /1.4,
                                      child: Txt(
                                        maxLines: 1,
                                        textOverFlow: TextOverflow.ellipsis,
                                        text:
                                            "${widget.dataPaket['service_price_zona_ambulances'][index]['districts']}, ${widget.dataPaket['service_price_zona_ambulances'][index]['city']}, ${widget.dataPaket['service_price_zona_ambulances'][index]['country']} ",
                                      ),
                                    ),
                                    const Icon(
                                      Icons.map_outlined,
                                      color: Colors.green,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ])
                  ]));
        });
  }
}
