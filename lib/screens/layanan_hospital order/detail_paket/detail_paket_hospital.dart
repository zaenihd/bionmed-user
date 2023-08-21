import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:bionmed_app/widgets/container/container.dart';
import 'package:bionmed_app/widgets/txt/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class DetailPaketHospital extends StatelessWidget {
  const DetailPaketHospital({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        title: Txt(text: 'Detail Paket'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => Cntr(
          margin: const EdgeInsets.only(top: 16, left: 24, right: 24),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 50,
          radius: BorderRadius.circular(10),
          color: const Color(0xffF6F6F6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Txt(text: 'Pengecekan Kesehatan Berkala'),
              Image.asset('assets/images/icon_healt.png')
            ],
          ),
        ),
      ),
      bottomSheet: Cntr(
        boxShadow: [
          BoxShadow(color: Colors.grey[200]!, spreadRadius: 2, blurRadius: 20)
        ],
        height: 320,
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
            Cntr(
              height: 50,
              width: Get.width,
              color: const Color(0xffF5F6F8),
              radius: BorderRadius.circular(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Cntr(
                    radius: BorderRadius.circular(10),
                    height: 50,
                    width: 50,
                    color: Colors.red,
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  Txt(
                    text: "1 Hari",
                    weight: FontWeight.bold,
                  ),
                  Cntr(
                    radius: BorderRadius.circular(10),
                    height: 50,
                    width: 50,
                    color: Colors.green,
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            ButtonGradient(onPressed: () {}, label: "Setuju & Lanjutkan")
          ],
        ),
      ),
    );
  }
}
