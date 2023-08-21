import 'package:bionmed_app/constant/colors.dart';
import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/screens/payment/controller_payment.dart';
import 'package:bionmed_app/screens/pesanan/controller_pesanan.dart';
import 'package:bionmed_app/screens/pesanan/maps.dart';
import 'package:bionmed_app/screens/pesanan/pesanan_doctor_on_call.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:bionmed_app/widgets/input/input_primary.dart';
import 'package:bionmed_app/widgets/other/show_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PesananBabyCare extends StatefulWidget {
  const PesananBabyCare({super.key});

  @override
  State<PesananBabyCare> createState() =>
      _PesananBabyCareState();
}

class _PesananBabyCareState extends State<PesananBabyCare> {
  String title = "Biodata Anak";
  String dates = "";
  String times = "";
  String gender = "";

  TextEditingController namaAnak = TextEditingController();
  TextEditingController usiaAnak = TextEditingController();
  TextEditingController noTelOrtu = TextEditingController();
  TextEditingController alamatPasien = TextEditingController();
  TextEditingController keluhan = TextEditingController();

  datePicker() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      // ignore: avoid_print
      print(pickedDate);
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      // ignore: avoid_print
      print(formattedDate);
      setState(() {
        Get.find<ControllerPayment>().datesDoctorCall.value = formattedDate;
      });
    } else {
      // ignore: avoid_print
      print("Date is not selected");
    }
  }

  Widget buildTimePicker() {
    return SizedBox(
      height: MediaQuery.of(context).copyWith().size.height / 3,
      child: CupertinoDatePicker(
        initialDateTime: DateTime.now(),
        onDateTimeChanged: (DateTime newdate) {
          String dates = DateFormat("HH:mm:ss", "id_ID").format(newdate);
          setState(() {
            Get.find<ControllerPayment>().timesDoctorCall.value =
                dates.toString();
          });
        },
        use24hFormat: false,
        // maximumDate: new DateTime(2050, 12, 30),
        // minimumYear: 2010,
        // maximumYear: 2018,
        // minuteInterval: 1,
        mode: CupertinoDatePickerMode.time,
      ),
    );
  }

  timePicker() async {
    TimeOfDay? timeRecord = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (timeRecord != null) {
      setState(() {
        var df = DateFormat("h:mm a");
        var dt = df.parse(timeRecord.format(context));
        var finaltime = DateFormat('HH:mm').format(dt);
        setState(() {
          times = finaltime.toString();
        });
        // this will return 13:30 only
      });
    }
  }

  final myC = Get.put(MapsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        titleTextStyle: TextStyles.subtitle1,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColor.gradient1,
          ),
        ),
      ),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Data Persona",
                style: TextStyles.subtitle2,
              ),
              Text(
                "Masukkan biodata anak anda",
                style: TextStyles.body2,
              ),
              InputPrimary(
                onChange: ((p0) {}),
                controller: namaAnak,
                onTap: () {},
                hintText: "Nama Anak",
              ),
              InputPrimary(
                onChange: ((p0) {}),
                controller: usiaAnak,
                onTap: () {},
                keyboardType: TextInputType.number,
                hintText: "Usia Anak",
              ),
              InputPrimary(
                onChange: ((p0) {}),
                controller: noTelOrtu,
                onTap: () {},
                keyboardType: TextInputType.number,
                hintText: "No Telepon Orang Tua",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Get.find<ControllerPesanan>().gender.value = false;
                      setState(() {
                        gender = "Laki laki";
                      });
                    },
                    child: Obx(
                      () => Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                width: 1,
                                color: Get.find<ControllerPesanan>()
                                            .gender
                                            .value ==
                                        false
                                    ? AppColor.bluePrimary2
                                    : AppColor.bodyColor.shade300)),
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Row(
                            children: [
                              Get.find<ControllerPesanan>().gender.value ==
                                      false
                                  ? const Icon(
                                      Icons.circle,
                                      color: AppColor.bluePrimary2,
                                    )
                                  : Icon(
                                      Icons.circle_outlined,
                                      color: AppColor.bodyColor.shade300,
                                    ),
                              horizontalSpace(10),
                              Text(
                                "Pria",
                                style: TextStyle(
                                    color: Get.find<ControllerPesanan>()
                                                .gender
                                                .value ==
                                            false
                                        ? AppColor.bluePrimary2
                                        : AppColor.bodyColor.shade300),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  horizontalSpace(20),
                  InkWell(
                    onTap: () {
                      Get.find<ControllerPesanan>().gender.value = true;
                      setState(() {
                        gender = "Perempuan";
                      });
                    },
                    child: Obx(
                      () => Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                width: 1,
                                color: Get.find<ControllerPesanan>()
                                            .gender
                                            .value ==
                                        true
                                    ? AppColor.bluePrimary2
                                    : AppColor.bodyColor.shade300)),
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Row(
                            children: [
                              Get.find<ControllerPesanan>().gender.value == true
                                  ? const Icon(
                                      Icons.circle,
                                      color: AppColor.bluePrimary2,
                                    )
                                  : Icon(
                                      Icons.circle_outlined,
                                      color: AppColor.bodyColor.shade300,
                                    ),
                              horizontalSpace(10),
                              Text(
                                "Wanita",
                                style: TextStyle(
                                    color: Get.find<ControllerPesanan>()
                                                .gender
                                                .value ==
                                            true
                                        ? AppColor.bluePrimary2
                                        : AppColor.bodyColor.shade300),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Obx(
                () => InkWell(
                  onTap: () async {
                    Get.to(TambahAlamat());
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    alignment: Alignment.centerLeft,
                    width: Get.width,
                    height: myC.city.isEmpty ? 50 : null,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: InkWell(
                      onTap: () async {
                        Get.to(TambahAlamat());
                      },
                      child: Obx(() => myC.city.isNotEmpty
                          ? Text(myC.alamatLengkap.value)
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tambah Alamat',
                                  style: TextStyle(color: Colors.grey[500]!),
                                ),
                                const Icon(Icons.arrow_forward_ios)
                              ],
                            )),
                    ),
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 20),
                    // padding: EdgeInsets.only(left: 15, right: 15),
                    alignment: Alignment.centerLeft,
                    width: Get.width,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: TextFormField(
                      maxLines: 5,
                      controller: keluhan,
                      decoration: const InputDecoration(
                          hintText: "Keluhan",
                          hintStyle: TextStyle(color: Colors.grey,),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    )
                    // ),
                    )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ButtonGradient(
          label: "Pesan Sekarang",
          onPressed: ()async {
          //  await Get.find<PilihJadwalController>().registerSlot(
          //                                                 date: Get.find<PilihJadwalController>()
          //                                                     .startDate
          //                                                     .value);
          //  await Get.find<ControllerPayment>().addOrder();
            Get.find<ControllerPayment>().dates.value = "";
            Get.find<ControllerPayment>().times.value = "";
           myC.alamatLengkap.value = "";
            myC.city.value = "";
            myC.nama.clear();
            myC.alamat.clear();
            myC.noHp.clear();
            showPopUp(onTap: () {
                            Get.back();
                          },
                        imageAction: "assets/json/eror.json",
                        description: "Under Development");

            // Get.find<ControllerPayment>().updateOrder(
            //     name: nama.text,
            //     age: usia.text,
            //     gender: gender,
            //     phoneNumber: noTel.text,
            //     address: Get.find<MapsController>().alamatLengkapSendAPI.value,
            //     description: desc.text);
          },
        ),
      ),
    );
  }
}



