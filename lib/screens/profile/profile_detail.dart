import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/screens/login/controller_login.dart';
import 'package:bionmed_app/screens/profile/controller_profile.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:bionmed_app/widgets/input/input_primary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PageProfileDetail extends StatefulWidget {
  const PageProfileDetail({super.key});

  @override
  State<PageProfileDetail> createState() => _PageProfileDetailState();
}

class _PageProfileDetailState extends State<PageProfileDetail> {
  TextEditingController name =
      TextEditingController(text: Get.find<ControllerLogin>().name.value);
  TextEditingController noHp =
      TextEditingController(text: Get.find<ControllerLogin>().noHp.value);
  TextEditingController tanggal = TextEditingController();
  TextEditingController alamat =
      TextEditingController(text: Get.find<ControllerLogin>().alamat.value);
  TextEditingController tanggalLahir =
      TextEditingController(text: Get.find<ControllerLogin>().tanggalLahir.value);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  )),
              horizontalSpace(20),
              const Text(
                "Ubah Profile",
                style: TextStyle(fontSize: 17),
              )
            ],
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const Text(
                  "Isi profile anda sesuai dengan identitas asli anda agar kami mudah menginformasikan"),
              verticalSpace(30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Nama"),
                  InputPrimary(
                    onChange: (val) {},
                    controller: name,
                    onTap: () {},
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("No.Handphone"),
                  InputPrimary(
                    enable: false,
                    onChange: (val) {},
                    controller: noHp,
                    onTap: () {},
                  ),
                ],
              ),
              verticalSpace(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Alamat"),
                  InputPrimary(
                    onChange: (val) {},
                    controller: alamat,
                    onTap: () {},
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Tanggal Lahir"),
                  InputPrimary(
                    onChange: (val) {},
                    controller: tanggalLahir,
                    onTap: () async{
                      DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1800),
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          // ignore: avoid_print
                          print(pickedDate);
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          // ignore: avoid_print
                          print(formattedDate);

                          setState(() {
                            tanggalLahir.text = formattedDate;
                          });
                        } else {
                          // ignore: avoid_print
                          print("Date is not selected");
                        }
                       
                    },
                  ),
                ],
              ),
              verticalSpace(20),
             Obx(()=> ButtonGradient(
                  onPressed: () {
                    if(Get.find<ControllerProfile>().isLoading.isFalse){
                    Get.find<ControllerProfile>()
                        .updateProfile(name.text, alamat.text, tanggalLahir.text);
                    }
                  },
                  label: Get.find<ControllerProfile>().isLoading.isTrue ? "Loading.." : "Simpan"))
            ],
          ),
        ),
        Container()
      ]),
    ));
  }
}
