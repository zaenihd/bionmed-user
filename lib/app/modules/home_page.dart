import 'package:bionmed_app/app/modules/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeControllerDua>(
      builder: (controller) => Scaffold(
        // appBar: AppBar(
        //   title: const Text('Home'),
        //   elevation: 0,
        // ),
        body: ListView(
          children: [
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ElevatedButton(
            //       onPressed: () {
            //         Get.to(() => const SplashScreen());
            //       },
            //       child: const Text("Klik saya"),
            //     ),
            //   ],
            // ),
            Container(),
          ],
        ),
      ),
    );
  }
}
