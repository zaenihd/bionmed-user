import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/screens/login/controller_login.dart';
import 'package:bionmed_app/widgets/card/card_doctor_spesialis.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';

class DoctorSpesialisScreen extends StatefulWidget {
  const DoctorSpesialisScreen({Key? key}) : super(key: key);

  @override
  State<DoctorSpesialisScreen> createState() => _DoctorSpesialisScreenState();
}

class _DoctorSpesialisScreenState extends State<DoctorSpesialisScreen> {
  String title = "Dokter Spesialis";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyles.subtitle1,
        title: Text(title),
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColor.gradient1,
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: defaultPadding),
        itemCount: Get.find<ControllerLogin>().doctorBySpesialis.length,
        itemBuilder: (BuildContext context, int index) {
          return CardDoctorSpesialis(
            data: Get.find<ControllerLogin>().doctorBySpesialis[index],
          );
        },
      ),
    );
  }
}
