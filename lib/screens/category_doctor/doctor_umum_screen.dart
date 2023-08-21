import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/widgets/card/card_rec_doctor.dart';
import 'package:flutter/material.dart';

import '../../constant/colors.dart';

class DoctorUmumScreen extends StatefulWidget {
  const DoctorUmumScreen({Key? key}) : super(key: key);

  @override
  State<DoctorUmumScreen> createState() => _DoctorUmumScreenState();
}

class _DoctorUmumScreenState extends State<DoctorUmumScreen> {
  String title = "Dokter Umum";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
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
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return const CardRecDoctor();
        },
      ),
    );
  }
}