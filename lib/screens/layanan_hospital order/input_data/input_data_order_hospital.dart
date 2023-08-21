import 'package:bionmed_app/constant/colors.dart';
import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/screens/home/home_controller.dart';
import 'package:bionmed_app/screens/home/home_screen.dart';
import 'package:bionmed_app/screens/layanan_hospital%20order/input_data/input_data_order_hospital_controller.dart';
import 'package:bionmed_app/screens/layanan_nurse_home/controller/input_layanan_controller.dart';
import 'package:bionmed_app/screens/pesanan/controller_pesanan.dart';
import 'package:bionmed_app/screens/pesanan/maps.dart';
import 'package:bionmed_app/screens/pesanan/pesanan_doctor_on_call.dart';
import 'package:bionmed_app/screens/pilih_jadwal/controllers/pilih_jadwal_controller.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:bionmed_app/widgets/container/container.dart';
import 'package:bionmed_app/widgets/input/input_primary.dart';
import 'package:bionmed_app/widgets/other/show_dialog.dart';
import 'package:bionmed_app/widgets/txt/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class InputDataOrderHospital extends StatelessWidget {
  InputDataOrderHospital({super.key});

  final controller = Get.put(InputDataOrderHospitalController());
  final jenisKelamin = ['Laki - laki', "Perempuan"];

  final mapC = Get.put(MapsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: InkWell(
            onTap: () {},
            child: const Text(
              'Atur Jadwal',
              style: TextStyle(fontSize: 16),
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: AppColor.gradient1,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tentukan Jadwal",
                style: TextStyles.subtitle2,
              ),
              Text(
                "Atur jadwal pesanan anda",
                style: TextStyles.body2,
              ),
              const SizedBox(
                height: 20.0,
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                width: double.infinity,
                child: const Text(
                  'Tanggal',
                  textAlign: TextAlign.left,
                ),
              ),
              // ignore: avoid_unnecessary_containers
              Container(
                child: InputPrimary(
                  controller: controller.tanggalC,
                  onTap: () async {
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
                      Get.put(PilihJadwalController()).day.value =
                          DateFormat("EEEE", "id_ID").format(pickedDate);
                      Get.find<ControllerPesanan>().day.value =
                          DateFormat("EEEE", "id_ID").format(pickedDate);
                      String starDate =
                          DateFormat("yyyy-MM-dd HH:mm:ss").format(pickedDate);
                      Get.put(PilihJadwalController()).startDate.value =
                          starDate;

                      controller.tanggalC.text = formattedDate;
                    } else {
                      // ignore: avoid_print
                      print("Date is not selected");
                    }
                  },
                  hintText: "dd/mm/yy",
                  onChange: (val) {},
                  validate: (value) {
                    if (value.toString().isNotEmpty) {
                      return null;
                    }
                    return "Tanggal lahir tidak boleh kosong";
                  },
                  prefixIcon: const Icon(Icons.calendar_month),
                ),
              ),
              Txt(
                text: 'Data Diri',
                size: 16,
                weight: FontWeight.bold,
              ),
              const SizedBox(
                height: 5.0,
              ),
              Txt(
                text: 'Kebutuhan data diri pasien',
                color: Color(0xff7C7C7C),
              ),
              const SizedBox(
                height: 16.0,
              ),

              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Nama Pasien',
                  textAlign: TextAlign.left,
                ),
              ),
              // ignore: avoid_unnecessary_containers
              Container(
                child: InputPrimary(
                  controller: controller.namaPasienC,
                  onTap: () async {},
                  hintText: "Masukkan nama pasien",
                  onChange: (val) {},
                  validate: (value) {
                    if (value.toString().isNotEmpty) {
                      return null;
                    }
                    return "Nama Pasien tidak boleh kosong";
                  },
                ),
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Umur',
                  textAlign: TextAlign.left,
                ),
              ),
              // ignore: avoid_unnecessary_containers
              Container(
                child: InputPrimary(
                  keyboardType: TextInputType.number,
                  controller: controller.umurPasienC,
                  onTap: () async {},
                  hintText: "Masukkan Umur",
                  onChange: (val) {},
                  validate: (value) {
                    if (value.toString().isNotEmpty) {
                      return null;
                    }
                    return "Umur Tidak Boleh Kosong";
                  },
                ),
              ),
              SizedBox(
                  width: double.infinity,
                  child: Txt(
                    text: 'Upload Foto',
                  )),
              const SizedBox(
                height: 10.0,
              ),
              // ignore: avoid_unnecessary_containers
              InkWell(
                onTap: () async {
                  controller.pickerFilesImage(context);
                },
                child: Cntr(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: Get.width,
                  height: 45,
                  color: AppColor.bgForm,
                  radius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.upload,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Obx(() => SizedBox(
                            width: Get.width / 2,
                            child: Txt(
                              maxLines: 1,
                              textOverFlow: TextOverflow.ellipsis,
                              text: controller.imageUrl.value == ''
                                  ? 'Upload Foto Pasien'
                                  : controller.imageUrl.value.substring(42),
                              color: controller.imageUrl.isEmpty
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 2.0,
              ),
              Obx(
                () => Visibility(
                  visible: controller.imageUrl.isEmpty,
                  child: Txt(
                    text: 'max size 5 mb',
                    color: Colors.red,
                    size: 12,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Alamat Pasien',
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              // ignore: avoid_unnecessary_containers
              InkWell(
                onTap: () async {
                  bool isLocationEnabled =
                      await Get.find<HomeController>().checkGpsStatus();
                  if (isLocationEnabled) {
                    Get.to(() => TambahAlamat());
                  } else {
                    Get.to(() => TambahAlamat());
                    popUpGetLokasi();
                  }
                },
                child: Cntr(
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: Get.width,
                  color: AppColor.bgForm,
                  radius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!),
                  child: Obx(() => mapC.city.isNotEmpty
                      ? Text(mapC.alamatLengkap.value)
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
              const SizedBox(
                height: 20.0,
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Keluhan Pasien',
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              // ignore: avoid_unnecessary_containers
              Cntr(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  width: Get.width,
                  height: 130,
                  color: AppColor.bgForm,
                  radius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!),
                  child: TextFormField(
                    controller: controller.keluhanC,
                    maxLines: 10,
                    decoration: const InputDecoration(
                        hintText: 'Apa keluhan yang pasien alami',
                        hintStyle: TextStyle(color: Colors.grey),
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                  )),
              const SizedBox(
                height: 20.0,
              ),
              ButtonGradient(
                  onPressed: () {
                    if (controller.tanggalC.text.isEmpty ||
                        controller.namaPasienC.text.isEmpty ||
                        controller.umurPasienC.text.isEmpty ||
                        controller.keluhanC.text.isEmpty ||
                        mapC.city.isEmpty ||
                        controller.imageUrl.isEmpty) {
                      showPopUp(
                          onTap: () {
                            Get.back();
                          },
                          imageAction: "assets/json/eror.json",
                          description: "Mohon Lengkapi\nSemua Data!");
                    }
                  },
                  label: 'Lanjutkan'),

              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
