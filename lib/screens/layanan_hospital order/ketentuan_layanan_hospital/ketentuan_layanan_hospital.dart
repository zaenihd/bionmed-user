import 'package:bionmed_app/constant/colors.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:bionmed_app/widgets/container/container.dart';
import 'package:bionmed_app/widgets/txt/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KetentuanLayananHospital extends StatelessWidget {
  const KetentuanLayananHospital({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 24.0,
              ),
              Image.asset('assets/icons/dokter1.png'),
              const SizedBox(
                height: 10.0,
              ),
              Txt(
                text: 'Ketentuan Layanan Hospital',
                size: 16,
                weight: FontWeight.bold,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Txt(
                text:
                    ' diharuskan melakukan pesanan Home Visit Dokter\nsesuai kebutuhan layanan Hospital',
                size: 10,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10.0,
              ),
              // const SizedBox(
              // height: 115.0,
              // ),
              // Image.asset('assets/icons/pesan.png'),
              // const SizedBox(
              // height: 10.0,
              // ),
              //  Txt(
              //   text:
              //       'Tidak ada riwayat pesanan Home Visit Dokter,\nSilahkan pesan terlebih dulu',
              //   size: 10,
              //   textAlign: TextAlign.center,
              // ),
              dataDiriPasien(),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                  Txt(
                    text:
                        'Pesanan terverifikasi, anda bisa melanjutkan layanan\nhospital, berlaku 24 jam ketika layanan home visit selesai',
                    size: 10,
                  )
                ],
              )
            ],
          ),
        ),
      ),
      bottomSheet: ButtonGradient(
          margin: const EdgeInsets.all(20),
          onPressed: () {},
          label: 'Pesan layanan Home Visit Dokter'),
    );
  }

  Cntr dataDiriPasien() {
    return Cntr(
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.only(top: 44),
      alignment: Alignment.centerLeft,
      width: Get.width,
      // color: Colors.grey[200],
      gradient: AppColor.gradient1,
      radius: BorderRadius.circular(10),
      child: ExpansionTile(
          title: Row(
            children: [
              Cntr(
                margin: const EdgeInsets.only(right: 10),
                radius: BorderRadius.circular(100),
                height: 50,
                width: 50,
                image: const DecorationImage(
                    image: NetworkImage(
                        'https://picsum.photos/seed/picsum/200/300'),
                    fit: BoxFit.cover),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Txt(
                    text: 'Dr. test 123',
                    color: Colors.white,
                    weight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Txt(
                    text: 'Spesialis Paru - paru',
                    color: Colors.white,
                    size: 12,
                  )
                ],
              ),
            ],
          ),
          children: [
            Cntr(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 26),
                radius: BorderRadius.circular(10),
                width: Get.width,
                gradient: AppColor.gradient1,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Txt(
                          text: 'Layanan',
                          weight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        Txt(
                          text: 'Home Visit Dokter',
                          color: Colors.white,
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
                          text: 'Pesanan dibuat',
                          weight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        Txt(
                          text: 'Senin, 14 Januari 2022',
                          color: Colors.white,
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
                          text: 'Pesanan selesai',
                          weight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        Txt(
                          text: 'Senin, 14 Januari 2022',
                          color: Colors.white,
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
                          text: 'Id Order',
                          weight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Txt(
                            text: 'HVD/001/023',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Cntr(
                      alignment: Alignment.center,
                      radius: BorderRadius.circular(10),
                      color: Colors.transparent,
                      width: Get.width,
                      height: 50,
                      border: Border.all(color: Colors.white),
                      child: Txt(
                        text: 'Lihat pesanan',
                        color: Colors.white,
                      ),
                    )
                  ],
                )),
          ]),
    );
  }
}
