import 'package:bionmed_app/screens/disclamerSplash/disclamer_controller.dart';
import 'package:bionmed_app/screens/splash/splash_screen.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DisclamerSplash extends StatelessWidget {
  DisclamerSplash({super.key});

  final myC = Get.put(DisclamerController());
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          children: [
            Image.asset(
              'assets/images/disklaim1.png',
              height: 70,
              width: 70,
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14, height: 1.5),
                'Semua dokter, perawat, bidan dan pekerja lainnya yang terdaftar di aplikasi BionMed, telah melalui serangkaian proses verifikasi atas dokumen dan sertifikat yang dimiliki.\n \nSemua dokter, perawat, bidan, dan pekerja yang terdaftar di BionMed sudah memiliki Surat Keterangan Sehat dari dokter, dan Sertifikat vaksin covid-19.\n \nSemua hasil konsultasi yang dilakukan oleh dokter, laboratorium klinik, maupun resep obat atau obat yang didapat di aplikasi BionMed adalah menjadi tanggung jawab dari dokter, laboratorium Klinik dan apotek yang menyediakan obat tersebut.\n \nBilamana terjadi suatu kesalahan yang dilakukan oleh dokter, perawat, bidan, apotek dan pekerja lainnya dalam melakukan konsultasi Kesehatan, layanan laboratorium klinik, maupun dalam mengeluarkan resep obat atau dalam mengeluarkan obat adalah menjadi tanggung jawab dokter, laboratorium klinik dan apotek yang bersangkutan, pihak pengelola aplikasi BionMed akan membantu dengan memberikan database dari pekerja kepada pihak yang berwenang dalam menangani masalah tersebut.\n \nBilamana terjadi kesalahan dalam pemesanan termasuk Force majeure, maka akan dilakukan pengembalian sebesar 80% dari biaya jasa yang dipesan.\n \n \nHormat kami,\n \n \n \nPengelola BionMed'),

            // const SizedBox(
            // height: 200.0,
            // ),
            Container(
              height: 130,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => Checkbox(
                          value: myC.dontShowAgain.value,
                          onChanged: (value) {
                            myC.dontShowAgain.toggle();
                          },
                        ),
                      ),
                      const Text('Jangan Tampilkan Lagi')
                    ],
                  ),
                  ButtonGradient(
                      label: 'Lanjutkan',
                      onPressed: () {
                        if (myC.dontShowAgain.isTrue) {
                          box.write("dontShowAgain", true);
                        }
                        Get.to(() => const SplashScreen());
                        // Get.toNamed(Routes.SPLASH_SCREEN);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
