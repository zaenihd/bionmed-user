import 'package:bionmed_app/constant/colors.dart';
import 'package:bionmed_app/screens/layanan_hospital%20order/detail_pesanan_hospital/detail_pesanan_hospital_controller.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:bionmed_app/widgets/button/button_primary.dart';
import 'package:bionmed_app/widgets/container/container.dart';
import 'package:bionmed_app/widgets/txt/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';

class DetailPesananHospitalView
    extends GetView<DetailPesananHospitalController> {
  DetailPesananHospitalView({Key? key}) : super(key: key);

  @override
  final controller = Get.put(DetailPesananHospitalController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Order'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  namePasien(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Txt(
                    text: 'Info Pesanan',
                    size: 16,
                    weight: FontWeight.bold,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(
                  height: 10.0,
                  ),
                  Image.asset(
                      'assets/images/step_one_hospital.png',
                      height: 244,
                      width: 279,
                    ),
                  // InfoOrder(status: '3', onTap: () {}),
                  const SizedBox(
                    height: 20.0,
                  ),
                  namaPerawat(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  prosesStatusOrder(),
                  chatRumahSakit(),
                  const SizedBox(
                  height: 20.0,
                  ),
                  detailAmbulance(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  // dataDiriPasien(),
                  detailPaket(),
                  tujuanAmbulance(),
                  Rating(
                    rating: 2.0,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
            hargaDanActionButton(context),
          ],
        ),
      ),
    );
  }

  Cntr prosesStatusOrder() {
    return Cntr(
      margin: const EdgeInsets.only(bottom: 15),
      alignment: Alignment.centerLeft,
      width: Get.width,
      gradient: AppColor.gradient1,
      radius: BorderRadius.circular(10),
      child: ExpansionTile(
          title: Row(
            children: [
              Icon(
                Icons.access_time_filled,
                color: Colors.white,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Txt(
                    text: 'Perawatan Sedang Berlangsung',
                    weight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  Txt(
                    text: 'Lihat laporan harian',
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
          children: [
            Cntr(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Txt(
                        text: 'Senin, 12 Juni 2023',
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    children: [
                      Txt(
                        text: 'Senin, 12 Juni 2023',
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  InkWell(
                    onTap: () {
                      popUpLihatGambar(Get.context!);
                    },
                    child: Cntr(
                      alignment: Alignment.center,
                      radius: BorderRadius.circular(10),
                      color: Colors.transparent,
                      height: 40,
                      width: Get.width,
                      border: Border.all(color: Colors.white),
                      child: Txt(
                        text: "Lihat gambar",
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            )
          ]),
    );
  }

  Cntr chatRumahSakit() {
    return Cntr(
      radius: BorderRadius.circular(10),
      width: Get.width,
      height: 50,
      border: Border.all(color: Colors.blue, width: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (Rect bounds) => const RadialGradient(
              center: Alignment.centerLeft,
              stops: [.5, 1],
              colors: [
                Color(0xff028FD6),
                Color(0xff0DD6E8),
              ],
            ).createShader(bounds),
            child: const Icon(
              Icons.chat,
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: [
                  Color(0xff028FD6),
                  Color(0xff0DD6E8),
                ],
              ).createShader(bounds);
            },
            child: const Text(
              "Chat Rumah Sakit?",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  //METHOD WIDGET
  Cntr tujuanAmbulance() {
    return Cntr(
      width: Get.width,
      padding: EdgeInsets.all(25),
      color: Colors.grey[300],
      radius: BorderRadius.circular(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Txt(
            text: 'Tujuan Anda',
            weight: FontWeight.bold,
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
                  Txt(text: 'Alamat :'),
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
                  Txt(text: 'Tujuan :'),
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

  Cntr detailAmbulance() {
    return Cntr(
      radius: BorderRadius.circular(10),
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 26),
      gradient: AppColor.gradient1,
      child: Column(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      Txt(
                        text: 'Detail Ambulance',
                        size: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Txt(
                        text: 'DK 1234 FGH',
                        weight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Txt(
                        text: 'Ambulance Standar 1',
                        size: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      // popUpkirimLaporanSelesaiAmbulance(Get.context!);
                    },
                    child: Cntr(
                      radius: BorderRadius.circular(100),
                      height: 80,
                      width: 80,
                      image: const DecorationImage(
                          image: NetworkImage(
                              'https://fastly.picsum.photos/id/201/200/300.jpg?blur=2&hmac=Bk1YAURRJgndPj6oL1nVMMPuskT1OVuu7itxEp71aH4'),
                          fit: BoxFit.cover),
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                  ),

                  // const Icon(
                  //   Icons.access_time_filled_outlined,
                  //   color: Colors.white,
                  //   size: 40,
                  // )
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              InkWell(
                onTap: () {
                  popUpLihatGambar(Get.context!);
                },
                child: Cntr(
                  alignment: Alignment.center,
                  radius: BorderRadius.circular(10),
                  color: Colors.transparent,
                  height: 40,
                  width: Get.width,
                  border: Border.all(color: Colors.white),
                  child: Txt(
                    text: "Lihat gambar",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }


  Row namePasien() {
    return Row(
      children: [
        Cntr(
          height: 72,
          width: 112,
          image: const DecorationImage(
              image: NetworkImage('https://picsum.photos/id/233/200/300'),
              fit: BoxFit.cover),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Txt(text: 'Laboratorium'),
            const SizedBox(
              height: 4.0,
            ),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.green,
                  size: 20,
                ),
                Txt(
                  text: 'Jakarta Barat',
                  size: 12,
                  color: Colors.grey,
                )
              ],
            ),
            const SizedBox(
              height: 4.0,
            ),
            Row(
              children: [
                RatingBar.builder(
                  ignoreGestures: true,
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemSize: 15,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                Txt(
                  text: '5.0',
                  size: 12,
                )
              ],
            )
          ],
        )
      ],
    );
  }

  Cntr hargaDanActionButton(BuildContext context) {
    return Cntr(
      boxShadow: [
        BoxShadow(color: Colors.grey[200]!, spreadRadius: 2, blurRadius: 20)
      ],
      height: 350,
      width: Get.width,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Txt(text: "Harga /hari"),
              Txt(text: "Rp 5.000.000 "),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Txt(text: "Hari"),
              Txt(text: "5 Hari"),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Txt(text: "Diskon"),
              Txt(text: "50%"),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          const Divider(
            thickness: 1,
          ),
          const SizedBox(
            height: 21.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Txt(text: "Total Harga :"),
              Txt(
                text: "Rp 5.000.000 ",
                weight: FontWeight.bold,
                size: 16,
                color: Colors.green,
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          const SizedBox(
            height: 25.0,
          ),
          ButtonGradient(
              onPressed: () {
                popUpIsPerawatSudahDatang(context);
              },
              label: "Konfirmasi perawat telah datang"),
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: 45,
            width: Get.width,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    backgroundColor: const Color(0xffFFE4E4)),
                onPressed: () {
                  popUpKasiRating();
                },
                child: Txt(
                  text: "Atur ulang jadwal?",
                  color: Colors.red,
                  weight: FontWeight.bold,
                )),
          ),
        ],
      ),
    );
  }

  Cntr namaPerawat() {
    return Cntr(
      radius: BorderRadius.circular(10),
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 26),
      gradient: AppColor.gradient1,
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Txt(
                        text: 'Detail Perawat',
                        size: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Txt(
                        text: 'Dr. ni putu ani',
                        weight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Txt(
                        text: 'Umur    : 36 Tahun',
                        size: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Txt(
                        text: 'No STR : 12345678',
                        size: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                  Cntr(
                    radius: BorderRadius.circular(100),
                    height: 80,
                    width: 80,
                    image: const DecorationImage(
                        image: NetworkImage(
                            'https://fastly.picsum.photos/id/201/200/300.jpg?blur=2&hmac=Bk1YAURRJgndPj6oL1nVMMPuskT1OVuu7itxEp71aH4'),
                        fit: BoxFit.cover),
                    border: Border.all(color: Colors.white, width: 4),
                  ),

                  // const Icon(
                  //   Icons.access_time_filled_outlined,
                  //   color: Colors.white,
                  //   size: 40,
                  // )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Divider(
                thickness: 2,
                color: Colors.white,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.access_time_filled_outlined,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Txt(
                        text: 'Mohon tunggu jadwal pesanan anda pada :',
                        size: 12,
                        color: Colors.white,
                      ),
                      Txt(
                        text: '21 Juni 2023',
                        size: 12,
                        color: Colors.white,
                        weight: FontWeight.bold,
                      ),
                    ],
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Cntr detailPaket() {
    return Cntr(
      margin: const EdgeInsets.only(bottom: 15),
      alignment: Alignment.centerLeft,
      width: Get.width,
      color: Colors.grey[200],
      radius: BorderRadius.circular(10),
      child: ExpansionTile(
          title: Txt(
            text: 'Detail Paket',
            weight: FontWeight.bold,
          ),
          children: [
            Cntr(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              radius: BorderRadius.circular(10),
              width: Get.width,
              color: Colors.grey[200],
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Txt(
                        text: 'Jenis Layanan',
                        color: Colors.grey,
                      ),
                      Txt(
                        text: 'Paket 1',
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 60 * 3,
                    child: ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) => Cntr(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 50,
                        radius: BorderRadius.circular(10),
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Cntr(
                              height: 16,
                              width: 16,
                              child: Image.asset('assets/images/icon_add.png'),
                            ),
                            const Text('Pengecekan Tensi Darah'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
    );
  }

  Cntr dataDiriPasien() {
    return Cntr(
      margin: const EdgeInsets.only(bottom: 15),
      alignment: Alignment.centerLeft,
      width: Get.width,
      color: Colors.grey[200],
      radius: BorderRadius.circular(10),
      child: ExpansionTile(
          title: Txt(
            text: 'Data Diri Pasien',
            weight: FontWeight.bold,
          ),
          children: [
            Cntr(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 26),
                radius: BorderRadius.circular(10),
                width: Get.width,
                color: Colors.grey[200],
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Txt(
                          text: 'Nama',
                        ),
                        Txt(
                          text: 'Datang Kerumah',
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Txt(
                          text: 'Jenis Kelamin',
                        ),
                        Txt(
                          text: 'Datang Kerumah',
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Txt(
                          text: 'Umur',
                        ),
                        Txt(
                          text: 'Datang Kerumah',
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Txt(
                          text: 'Alamat',
                        ),
                        InkWell(
                          onTap: () {},
                          child: Txt(
                            text: 'Detail',
                            weight: FontWeight.bold,
                            color: Colors.lightBlue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Cntr(
                      padding: const EdgeInsets.all(10),
                      radius: BorderRadius.circular(10),
                      height: 100,
                      width: Get.width,
                      border: Border.all(color: Colors.grey),
                      child: Txt(
                          text:
                              'text'),
                    )
                  ],
                )),
          ]),
    );
  }

  popUpIsPerawatSudahDatang(BuildContext context) {
    showModalBottomSheet(
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return SizedBox(
              height: 260,
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
                          const SizedBox(
                            height: 20.0,
                          ),
                          const Text(
                            'Apakah perawat  telah sampai dirumah anda ?',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          ButtonGradient(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            label: "Ya, Saya sudah",
                            onPressed: () {
                              Get.back();
                              popUpSelesaiKonfirmasi(context);
                            },
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          ButtonPrimary(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              color: Colors.grey,
                              onPressed: () {
                                Get.back();
                              },
                              label: "Tidak")
                        ])
                  ]));
        });
  }

  popUpSelesaiKonfirmasi(BuildContext context) {
    showModalBottomSheet(
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return SizedBox(
              height: 260,
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
                          const SizedBox(
                            height: 20.0,
                          ),
                          const Text(
                            'Terima kasih, telah mengkonfirmasi pesanan',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Image.asset('assets/icons/icon_succes.png'),
                          const SizedBox(
                            height: 22.0,
                          ),
                          ButtonGradient(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            label: "Oke",
                            onPressed: () {
                              Get.back();
                              popUpMengingat3JamKeberangkatan();
                            },
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                        ])
                  ]));
        });
  }

  popUpLihatGambar(BuildContext context) {
    showModalBottomSheet(
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return SizedBox(
              height: 500,
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
                          const SizedBox(
                            height: 20.0,
                          ),
                          Cntr(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            height: 260,
                            width: Get.width,
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://picsum.photos/200/300/?blur'),
                            ),
                          ),
                          const SizedBox(
                            height: 22.0,
                          ),
                          ButtonGradient(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            label: "Kembali",
                            onPressed: () {
                              Get.back();
                            },
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                        ])
                  ]));
        });
  }

  popUpMengingat3JamKeberangkatan() {
    showModalBottomSheet(
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: Get.context!,
        builder: (context) {
          return SizedBox(
              height: 350,
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
                          const Text(
                            'Peringatan!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Image.asset('assets/icons/icon_reminder.png'),
                          const SizedBox(
                            height: 20.0,
                          ),
                          const SizedBox(
                            height: 14.0,
                          ),
                          const Text(
                            'Mengingat waktu untuk pesanan\nakan berlangsung 3 Jam lagi',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          ButtonGradient(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            label: "Oke",
                            onPressed: () {
                              Get.back();
                              popUpReminderKeberangkatanDokter();
                            },
                          )
                        ])
                  ]));
        });
  }

  popUpReminderKeberangkatanDokter() {
    return Get.bottomSheet(
        backgroundColor: Colors.white,
        SizedBox(
            height: 400,
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
                        const Text(
                          'Pemberitahuan',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Image.asset('assets/icons/ic_keberangkatan.png'),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const SizedBox(
                          height: 14.0,
                        ),
                        const Text(
                          'Dokter sedang berangkat menuju ke\nlokasi anda sekarang',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ButtonGradient(
                            label: "Oke",
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        )
                      ])
                ])));
  }
}

popUpKasiRating() {
  return Get.bottomSheet(
    shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      backgroundColor: Colors.white,
      Padding(
        padding: const EdgeInsets.symmetric(horizontal :20.0),
        child: Column(
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
            const SizedBox(
              height: 20.0,
            ),
            Txt(
              text: 'Kepuasan',
              weight: FontWeight.bold,
            ),
            const SizedBox(
              height: 6.0,
            ),
            Txt(
              text: 'Penilaian anda untuk Rumah Sakit',
              weight: FontWeight.w400,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Center(
              child: RatingBar.builder(
                // ignoreGestures: true,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 10,
            ),
          
            // Obx(() =>
            Container(
              height: 120,
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey!)),
                child: Text("Deskripsi")),
                  const SizedBox(
            height: 20.0,
            ),
                 ButtonGradient(
                   label: "Kirim & Selesai",
                   onPressed: () {
                     Get.back();
                   },
                 )
            // ),
          ],
        ),
      ));
}

class Rating extends StatelessWidget {
  Rating({Key? key, this.rating}) : super(key: key);

  double? rating;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Txt(
          text: 'Kepuasan',
          weight: FontWeight.bold,
        ),
        const SizedBox(
          height: 6.0,
        ),
        Txt(
          text: 'Penilaian anda untuk Rumah Sakit',
          weight: FontWeight.w400,
        ),
        const SizedBox(
          height: 20.0,
        ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 20.0, bottom: 20),
        //   child:
        //       Center(child: Image.asset('assets/icon/icon_order_finish.png')),
        // ),
        // Center(
        //     child: Text(
        //   'Konsultasi Selesai',
        //   style: blackTextStyle.copyWith(fontWeight: bold),
        // )),
        // Center(
        //     child: Text(
        //   'Sesi konsultasi telah selesai',
        //   style: subtitleTextStyle.copyWith(fontWeight: normal),
        // )),
        // const SizedBox(
        //   height: 20,
        // ),
        Center(
          child: RatingBar.builder(
            ignoreGestures: true,
            initialRating: double.parse(rating.toString() ?? "5"),
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {},
          ),
        ),
        // SizedBox(
        //   // alignment: Alignment.center,
        //   width: 400,
        //   height: 50,
        //   child: SizedBox(
        //       height: 50,
        //       child: ListView.builder(
        //         // padding: const EdgeInsets.all(10),
        //         itemCount: 5,
        //         // physics: NeverScrollableScrollPhysics(),
        //         scrollDirection: Axis.horizontal,
        //         itemBuilder: (context, index) =>
        //             InkWell(
        //               onTap: (){
        //                 Get.put(DetailController()).selected.toggle();
        //               },
        //               child: Obx(()=> Get.put(DetailController()).selected.isFalse? Image.asset('assets/icon/icon_staron.png') : Image.asset('assets/icon/icon_staroff.png'))),
        //       )),
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   children: [
        //     Image.asset('assets/icon/icon_staron.png'),
        //     Image.asset('assets/icon/icon_staron.png'),
        //     Image.asset('assets/icon/icon_staron.png'),
        //     Image.asset('assets/icon/icon_staroff.png'),
        //     Image.asset('assets/icon/icon_staroff.png'),
        //   ],
        // ),
        const SizedBox(
          height: 20,
        ),
        Align(alignment: Alignment.centerLeft, child: const Text('Deskripsi')),
        const SizedBox(
          height: 10,
        ),
        // Obx(() =>
        Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey!)),
            child: Text("deskripsiRating.value"))
        // ),
      ],
    );
  }
}
