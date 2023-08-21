import 'package:bionmed_app/screens/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashScreenController>(
        init: SplashScreenController(),
        builder: (controller) {
          // ignore: sized_box_for_whitespace
          return Container(
            width: Get.width,
            height: Get.height,
            child: Center(
              child: Image.asset(
                'assets/images/logo_bion.png',
                width: 250,
                height: 250,
              ),
            ),
          );
        },
      ),
    );
  }
}
