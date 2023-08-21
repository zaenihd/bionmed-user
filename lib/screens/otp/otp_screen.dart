import 'package:bionmed_app/constant/colors.dart';
import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/screens/register/register_screen.dart';
import 'package:bionmed_app/widgets/appbar/appbar_back.dart';
import 'package:bionmed_app/widgets/button/button_primary.dart';
import 'package:bionmed_app/widgets/header/header_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController controllerOtp1 = TextEditingController();
  final TextEditingController controllerOtp2 = TextEditingController();
  final TextEditingController controllerOtp3 = TextEditingController();
  final TextEditingController controllerOtp4 = TextEditingController();
  final TextEditingController controllerOtp5 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      bottomSheet: Container(
        color: AppColor.whiteColor,
        padding: EdgeInsets.all(defaultPadding),
        child: ButtonPrimary(
          onPressed: () {
            Get.to(() => const RegisterScreen());
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
                  "Kode Verifikasi dikirim melalui Whatsapp \Anda (+62) 89** _ **** _ **"),
          Container(
            margin: const EdgeInsets.only(top: 36),
            child: Form(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xffF9F9F9),
                    ),
                    child: TextField(
                      controller: controllerOtp1,
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  Container(
                    height: 55,
                    width: 55,
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xffF9F9F9),
                    ),
                    child: TextField(
                      controller: controllerOtp2,
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  Container(
                    height: 55,
                    width: 55,
                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xffF9F9F9),
                    ),
                    child: TextField(
                      controller: controllerOtp3,
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  Container(
                    height: 55,
                    width: 55,
                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xffF9F9F9),
                    ),
                    child: TextField(
                      controller: controllerOtp4,
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  Container(
                    height: 55,
                    width: 55,
                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xffF9F9F9),
                    ),
                    child: TextField(
                      controller: controllerOtp5,
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                      onTap: () {},
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
