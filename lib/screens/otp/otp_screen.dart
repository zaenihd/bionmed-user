import 'package:bionmed_app/constant/colors.dart';
import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/widgets/appbar/appbar_back.dart';
import 'package:bionmed_app/widgets/button/button_primary.dart';
import 'package:bionmed_app/widgets/header/header_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../login/controller_login.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final loginC = Get.find<ControllerLogin>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      bottomSheet: Container(
        color: AppColor.whiteColor,
        padding: EdgeInsets.all(defaultPadding),
        child: ButtonPrimary(
          onPressed: () async{
            loginC.verifyOtp();
            // Get.to(() => const RegisterScreen());
          },
          label: "Verifikasi",
        ),
      ),
      appBar: appbarBack(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const SizedBox(height: 40),
          const HeaderAuth(
              imageUrl: "assets/images/img-otp.png",
              title: "Verifikasi Kode",
              subtitle:
                  // ignore: unnecessary_string_escapes
                  "Kode Verifikasi dikirim melalui Whatsapp \Anda (+62) 89** _ **** _ **"),
          // 
          const SizedBox(
            height: 10.0,
          ),
          Pinput(
            length: 5,
            onChanged: (value) {
              print(loginC.controllerOtp.text);
            },
            controller: loginC.controllerOtp,
            defaultPinTheme: PinTheme(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10))),

            // defaultPinTheme: defaultPinTheme,
            // focusedPinTheme: focusedPinTheme,
            // submittedPinTheme: submittedPinTheme,
            validator: (s) {
              return null;

              // return s == '2222' ? null : 'Pin is incorrect';
              // return null;
            },
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
            onCompleted: (pin) => print(pin),
          ),
          Container(
            margin: EdgeInsets.only(top: defaultPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.message_outlined,
                  color: AppColor.bodyColor[600],
                ),
                const SizedBox(width: 19),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Belum dapat sms kode verifikasinya ?",
                      style: TextStyle(color: AppColor.bodyColor[600]),
                    ),
                    const SizedBox(height: 3),
                    GestureDetector(
                      onTap: ()async {
                        loginC.sendOtp();
                        final snackBar = SnackBar(
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 2),
                          margin: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 24),
                          content: const Text('Kode OTP Berhasil dikirim'),
                          backgroundColor: (Colors.green),
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(Get.context!)
                            .showSnackBar(snackBar);
                      },
                      child: const Text(
                        "Kirim Lagi",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
