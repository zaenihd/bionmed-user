import 'package:bionmed_app/screens/pesanan/controller_pesanan.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

// ignore: must_be_immutable
class Resep extends StatelessWidget {
  Resep({super.key});

  final myC = Get.put(ControllerResep());
  var url = Get.find<ControllerPesanan>().imageResep.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Resep",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        titleTextStyle: const TextStyle(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  color: Color(0xffF3F3F3)),
              child: CachedNetworkImage(
                imageUrl: url,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
              child: Text(
                Get.find<ControllerPesanan>().imageResep.value.substring(40),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
      bottomSheet: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
          child: Obx(
            () => ButtonGradient(
                label: myC.isloading.isTrue
                    ? "Loading.."
                    : myC.doneDonwload.isTrue
                        ? "Unduh Resep"
                        : "Kembali",
                onPressed: () async {
                  myC.doneDonwload.isFalse ? Get.back() : myC.downloadImage();

                  // pickerFilesImage(context);
                }),
          )),
    );
  }
}

class ControllerResep extends GetxController {
  RxBool isloading = false.obs;
  RxBool doneDonwload = true.obs;
  var url = Get.find<ControllerPesanan>().imageResep.value;

  void downloadImage() async {
    isloading(true);
    doneDonwload(true);
    await GallerySaver.saveImage(url.toString());
    Get.snackbar('Berhasil', "Berhasil Unduh Resep ke Gallery");
    Get.find<ControllerPesanan>().imageResep.value = "";
    isloading(false);
    doneDonwload(false);
  }
}
