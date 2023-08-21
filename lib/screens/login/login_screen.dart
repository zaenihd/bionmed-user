import 'package:bionmed_app/constant/colors.dart';
import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/screens/login/controller_login.dart';
import 'package:bionmed_app/screens/login/syarat_ketentuan.dart';
import 'package:bionmed_app/widgets/other/loading_indicator.dart';
import 'package:bionmed_app/widgets/txt/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:platform_device_id/platform_device_id.dart';

import '../../widgets/header/header_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = "/login_screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController controllerPhone = TextEditingController();
  bool isButtonActive = false;

  @override
  void initState() {
    initPlatformState();
    // controllerPhone.clear();
    controllerPhone.addListener(() {
      final isButtonActive = controllerPhone.text.isNotEmpty;
      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controllerPhone.dispose();
    super.dispose();
  }

  Future<void> initPlatformState() async {
    String? deviceId;
    final box = GetStorage();

    try {
      deviceId = await PlatformDeviceId.getDeviceId;
      box.write('deviceId', deviceId);
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final cLogin = Get.put(ControllerLogin());
    PhoneNumber number = PhoneNumber(isoCode: 'ID');

    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      // ignore: avoid_unnecessary_containers
      backgroundColor: AppColor.whiteColor,
      // appBar: appbarBack(),
      body: Obx(
        (() => LoadingOverlay(
              isLoading: cLogin.isloading.value,
              progressIndicator: loadingIndicator(),
              color: Colors.transparent,
              opacity: 0.2,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const SizedBox(height: 80),
                  const HeaderAuth(
                    title: "Selamat Datang di BIONMED",
                    subtitle:
                        "Masukkan nomor telepon untuk mulai \nmenggunakan BIONMED",
                    imageUrl: "assets/images/img-login.png",
                  ),
                  const SizedBox(height: 32),
                   Txt(text: 'Nomer Handphone', weight: FontWeight.bold,size: 16,),
                    const SizedBox(
                    height: 15,
                    ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F9F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      children: [
                        InternationalPhoneNumberInput(
                          searchBoxDecoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.only(bottom: 15, left: 15, top: 30),
                                label: Text('Cari kode telepon negara Anda'),
                                
                            // border: InputBorder.none,
                            // hintText: 'Cari kode telepon negara Anda',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 81, 80, 80), fontSize: 16),
                          ),
                          onInputChanged: (PhoneNumber code) {
                            // ignore: avoid_print
                            print("cek${code.phoneNumber
                                    .toString()
                                    .replaceFirst('+', '')}");
                          },
                          onInputValidated: (bool value) {
                            // ignore: avoid_print
                            print(value);
                          },
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          ),
                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.disabled,
                          selectorTextStyle:
                              const TextStyle(color: Colors.black),
                          textFieldController: controllerPhone,
                          formatInput: false,
                          maxLength: 15,
                          initialValue: number,
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          cursorColor: Colors.black,
                          inputDecoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.only(bottom: 15, left: 0),
                            border: InputBorder.none,
                            hintText: '8971234567',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 101, 101, 101), fontSize: 16),
                          ),
                          onSaved: (PhoneNumber number) {
                            // ignore: avoid_print
                            print('On Saved: $number');
                          },
                        ),
                        Positioned(
                          left: 90,
                          top: 8,
                          bottom: 8,
                          child: Container(
                            height: 40,
                            width: 1,
                            color: Colors.black.withOpacity(0.13),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
      bottomSheet: Visibility(
        visible: !keyboardIsOpen,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          height: 150,
          width: Get.width,
          color: AppColor.whiteColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              InkWell(
                onTap: (){
              // Get.find<ControllerProfile>().ketentuanPengguna();
              Get.to(()=> SyaratDanKetentuan());

                },
                child: skPengguna()),
              SizedBox(height: defaultPadding),
              Container(
                  margin: EdgeInsets.zero,
                  height: 55,
                  width: double.infinity,
                  decoration: isButtonActive == true
                      ? BoxDecoration(
                          gradient: AppColor.gradient1,
                          borderRadius: BorderRadius.circular(6.0),
                        )
                      : null,
                  child: ElevatedButton(
                      onPressed: isButtonActive
                          ? () {
                              setState(() {
                                Get.find<ControllerLogin>()
                                    .loginApps(controllerPhone.text);
                                isButtonActive = false;
                                controllerPhone.clear();
                              });
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                          // ignore: deprecated_member_use
                          onSurface: AppColor.bluePrimary),
                      child: const Text(
                        "Lanjutkan",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ))),
            ],
          ),
        ),
      ),
    );
  }

  RichText skPengguna() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        text: 'Dengan masuk atau mendaftar saya menyetujui \n',
        style: TextStyle(
            color: AppColor.bodyColor,
            fontWeight: FontWeight.w400,
            fontFamily: 'Ubuntu'),
        children: <TextSpan>[
          TextSpan(
            text: 'Syarat ',
            style: TextStyle(
                color: AppColor.bluePrimary, fontWeight: FontWeight.w700, fontSize: 16),
          ),
          TextSpan(
            text: 'dan ',
          ),
          TextSpan(
            text: 'Ketentuan Pengguna Bionmed',
            style: TextStyle(
              color: AppColor.bluePrimary,
              fontWeight: FontWeight.w700,
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
