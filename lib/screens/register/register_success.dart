import 'package:bionmed_app/constant/colors.dart';
import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/screens/login/login_screen.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterSuccess extends StatefulWidget {
  const RegisterSuccess({Key? key}) : super(key: key);

  @override
  State<RegisterSuccess> createState() => _RegisterSuccessState();
}

class _RegisterSuccessState extends State<RegisterSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        padding: EdgeInsets.all(defaultPadding),
        child: ButtonGradient(
          onPressed: () {
            // ignore: prefer_const_constructors
            Get.to(LoginScreen());
            // Get.to(() => Home(
            //       indexPage: 2,
            //     ));
          },
          label: "Mulai",
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/img-success-register.png",
              height: 150,
            ),
            const SizedBox(height: 14),
            const Text(
              "Berhasil",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              "anda telah berhasil melakukan registrasi akun \nuntuk menggunakan BIONMED.\n Sehat selalu bersama layanan kami.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.bodyColor[700],
                height: 1.25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
