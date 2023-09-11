import 'dart:developer';

import 'package:bionmed_app/constant/colors.dart';
import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/screens/home/home_controller.dart';
import 'package:bionmed_app/screens/home/home_screen.dart';
import 'package:bionmed_app/screens/layanan_hospital%20order/list_hospital.dart/list_hospital.dart';
import 'package:bionmed_app/screens/layanan_nurse_home/controller/input_layanan_controller.dart';
import 'package:bionmed_app/screens/payment/controller_payment.dart';
import 'package:bionmed_app/screens/pesanan/controller_pesanan.dart';
import 'package:bionmed_app/screens/pesanan/maps.dart';
import 'package:bionmed_app/screens/pesanan/pesanan_doctor_on_call.dart';
import 'package:bionmed_app/screens/pilih_jadwal/controllers/pilih_jadwal_controller.dart';
import 'package:bionmed_app/screens/services/service_on_call.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:bionmed_app/widgets/container/container.dart';
import 'package:bionmed_app/widgets/input/input_primary.dart';
import 'package:bionmed_app/widgets/other/show_dialog.dart';
import 'package:bionmed_app/widgets/txt/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class InputLayananNurse extends StatefulWidget {
  const InputLayananNurse({super.key});

  @override
  State<InputLayananNurse> createState() => _InputLayananNurseState();
}

class _InputLayananNurseState extends State<InputLayananNurse> {
  final jenisKelamin = ['Laki - laki', "Perempuan"];

  final controller = Get.put(InputLayananController());

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
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101));
                    // initialDate: DateTime.now(),
                    // firstDate: DateTime(1800),
                    // lastDate: DateTime(2101));
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
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Jam',
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              // ignore: avoid_unnecessary_containers
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      isDismissible: false,
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            controller.buildTimePickerMulai(),
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text('Pilih Jam'),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                          ],
                        );
                      });
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
                        Icons.access_time,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Obx(() => Txt(
                            text: controller.jamTerpilih.isEmpty
                                ? 'hh : mm'
                                : controller.jamTerpilih.value,
                            color: controller.jamTerpilih.isEmpty
                                ? Colors.grey
                                : Colors.black,
                          ))
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                "Pilih Kriteria Perawat",
                style: TextStyles.subtitle2,
              ),
              Text(
                "Atur kriteria perawat anda",
                style: TextStyles.body2,
              ),
              const SizedBox(
                height: 20.0,
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Gender',
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: BorderStyles.borderGrey),
                // dropdown below..
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      fillColor: AppColor.bgForm,
                      filled: true,
                      hintText: "Pilih Jenis kelamin",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                  validator: (jKelamin) => jKelamin == null
                      ? "Jenis kelamin tidak boleh kosong"
                      : null,
                  items: jenisKelamin
                      .map((e) => DropdownMenuItem(
                          onTap: () {
                            controller.selectedGenderPerawat.value =
                                e.toString();
                          },
                          value: e,
                          child: Text(e.toString())))
                      .toList(),
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(
                height: 20.0,
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
                  controller: controller.umurPerawatC,
                  onTap: () async {},
                  hintText: "Masukkan Umur",
                  onChange: (val) {},
                  // validate: (value) {
                  //   if (value.toString().isNotEmpty) {
                  //     return null;
                  //   }
                  //   return "Umur Tidak Boleh Kosong";
                  // },
                ),
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Kebutuhan Pasien',
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              // ignore: avoid_unnecessary_containers
              InkWell(
                onTap: () async {
                  if (controller.dataActive.isEmpty) {
                    await controller.getNurseWorkScope();
                  }
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(builder:
                            (BuildContext context, StateSetter mystate) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Cntr(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        height: 10,
                                        width: 200,
                                        color: Colors.grey[300],
                                        radius: BorderRadius.circular(20),
                                      ),
                                      Txt(
                                        text: 'Kebutuhan Pasien',
                                        weight: FontWeight.bold,
                                      ),
                                      SizedBox(
                                        height: 300.0,
                                        child: ListView.builder(
                                          padding: const EdgeInsets.all(10),
                                          itemCount:
                                              controller.dataActive.length,
                                          itemBuilder: (context, index) =>
                                              ListTile(
                                            onTap: () {
                                              mystate(() {
                                                controller.dataActive[index]
                                                        ['value'] =
                                                    !controller
                                                            .dataActive[index]
                                                        ['value'];
                                              });
                                              if (controller.dataActive[index]
                                                      ['value'] ==
                                                  false) {
                                                if (controller.tampunganNurseId
                                                        .length ==
                                                    1) {
                                                  controller.tampunganNurseId
                                                      .clear();
                                                } else {
                                                  // controller.tampunganNurseId
                                                  //     .removeWhere(
                                                  //   (element) =>
                                                  //       element ==
                                                  //       controller
                                                  //               .tampunganNurseId[
                                                  //           index],
                                                  // );
                                                  controller.tampunganNurseId
                                                      .removeWhere((element) =>
                                                          element[
                                                              'work_scope_id'] ==
                                                          controller
                                                                  .nurseScopeData[
                                                              index]['id']);
                                                }

                                                // controller.tampunganNurseId
                                                //     .removeWhere(
                                                //   (element) =>
                                                //       element ==
                                                //       controller
                                                //               .tampunganNurseId[
                                                //           index],
                                                // );
                                                // if (controller.tampunganNurseId
                                                //         .length ==
                                                //     1) {
                                                //   controller.tampunganNurseId
                                                //       .clear();
                                                // }
                                              } else {
                                                controller.tampunganNurseId
                                                    .add({
                                                  "work_scope_id": controller
                                                          .nurseScopeData[index]
                                                      ['id']
                                                });
                                              }
                                            },
                                            leading: Cntr(
                                              radius: BorderRadius.circular(10),
                                              height: 50,
                                              width: 50,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      '${controller.nurseScopeData[index]['icon']}'),
                                                  fit: BoxFit.cover),
                                            ),
                                            title: Text(controller
                                                .nurseScopeData[index]['name']),
                                            trailing: Obx(
                                              () => controller.dataActive[index]
                                                          ['value'] ==
                                                      true
                                                  ? Cntr(
                                                      height: 15,
                                                      width: 15,
                                                      radius:
                                                          BorderRadius.circular(
                                                              100),
                                                      border: Border.all(),
                                                      color: Colors.blue,
                                                    )
                                                  : Cntr(
                                                      height: 15,
                                                      width: 15,
                                                      radius:
                                                          BorderRadius.circular(
                                                              100),
                                                      border: Border.all(),
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ButtonGradient(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    label: "Simpan"),
                                const SizedBox(
                                  height: 10.0,
                                ),
                              ],
                            ),
                          );
                        });
                      });
                },
                child: Cntr(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: Get.width,
                    height: 45,
                    color: AppColor.bgForm,
                    radius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[300]!),
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Txt(
                            text: controller.tampunganNurseId.isEmpty
                                ? 'Pilih Kebutuhan'
                                : "${controller.tampunganNurseId.length} Dipilih",
                            color: controller.tampunganNurseId.isEmpty
                                ? Colors.grey
                                : Colors.black,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_sharp,
                            size: 15,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    )),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                Get.find<ControllerPayment>().sequenceId.value == 5
                    ? "Data Ibu Hamil"
                    : Get.find<ControllerPayment>().sequenceId.value == 6
                        ? 'Data Anak'
                        : "Data Pasien",
                style: TextStyles.subtitle2,
              ),
              Text(
                Get.find<ControllerPayment>().sequenceId.value == 5
                    ? "Keluhan Ibu Hamil"
                    : Get.find<ControllerPayment>().sequenceId.value == 6
                        ? 'Keluhan Anak'
                        : "Keluhan Pasien",
                style: TextStyles.body2,
              ),
              const SizedBox(
                height: 20.0,
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
                  controller: controller.namePasienC,
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
              Get.find<ControllerPayment>().serviceId.value == 5
                  ? const SizedBox(
                      height: 1.0,
                    )
                  : Column(
                      children: [
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Jenis Kelamin',
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          width: Get.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: BorderStyles.borderGrey),
                          // dropdown below..
                          child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                fillColor: AppColor.bgForm,
                                filled: true,
                                hintText: "Pilih Jenis kelamin",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none)),
                            validator: (jKelamin) => jKelamin == null
                                ? "Jenis kelamin tidak boleh kosong"
                                : null,
                            items: jenisKelamin
                                .map((e) => DropdownMenuItem(
                                    onTap: () {
                                      controller.selectedGenderPasien.value =
                                          e.toString();
                                    },
                                    value: e,
                                    child: Text(e.toString())))
                                .toList(),
                            onChanged: (value) {},
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                      ],
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
                    if (Get.find<ControllerPayment>().serviceId.value == 5) {
                      log('message');
                      controller.selectedGenderPasien.value = jenisKelamin[1];
                    }
                    DateTime now = DateTime.now();
                    if (int.parse(Get.put(PilihJadwalController())
                            .startDate
                            .value
                            .substring(8, 10)) ==
                        int.parse(DateFormat('yyyy-MM-dd')
                            .format(now)
                            .substring(8, 10))) {
                      if (int.parse(Get.find<InputLayananController>()
                              .jamTerpilihForSend
                              .value
                              .substring(0, 2)) <
                          Get.find<InputLayananController>()
                                  .jamSekarangPlus4JamFix
                                  .value +
                              4) {
                        Get.put(PilihJadwalController())
                            .jadwalTerlewat3Jam("Atur ulang jam");
                      } else if (Get.find<ControllerPayment>()
                              .serviceId
                              .value ==
                          5) {
                        log('message');
                        // controller.selectedGenderPasien.value = jenisKelamin[1];
                        // actionNurse();
                      } else {
                        log('message 1');

                        actionNurse();
                      }
                    } else {
                      log('message 2');

                      actionNurse();
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

  actionNurse() async {
    log(controller.dataFilter.toString());
    controller.selectedGenderPasien.value = jenisKelamin[1];

    if (controller.tanggalC.text == "" ||
        controller.jamTerpilih.isEmpty ||
        // controller.selectedGenderPerawat.isEmpty ||
        // controller.umurPerawatC.text == "" ||
        // controller.tampunganNurseId.isEmpty ||
        controller.namePasienC.text == "" ||
        controller.selectedGenderPasien.isEmpty ||
        controller.umurPasienC.text == "" ||
        mapC.city.isEmpty ||
        controller.keluhanC.text == "" ||
        controller.imageUrl.isEmpty) {
      showPopUp(
          onTap: () {
            Get.back();
          },
          imageAction: "assets/json/eror.json",
          description: "Mohon Lengkapi\nSemua Data!");
    } else {
      // if (controller.tampunganNurseId == [] ||
      //     controller.umurPerawatC.text == "" ||
      //     controller.selectedGenderPerawat.value == "") {
      //   await controller.getListNurse();
      //   Get.to(() => ServiceOnCall(
      //       title:
      //           Get.find<ControllerPayment>().nameService.value,
      //     ));
      // }else{

      //GENDER
      if (controller.selectedGenderPerawat.isNotEmpty) {
        if (controller.selectedGenderPerawat.isNotEmpty &&
            controller.tampunganNurseId.isNotEmpty &&
            controller.umurPerawatC.text != "") {
          controller.dataFilter.add({
            "filter": [
              {
                "gender": controller.selectedGenderPerawat.value,
                "old": controller.umurPerawatC.text,
                "lat": Get.find<MapsController>().lat.value,
                "long": Get.find<MapsController>().long.value
              },
            ],
            "sop": controller.tampunganNurseId
          });
        } else {
          if (controller.tampunganNurseId.isNotEmpty &&
              controller.selectedGenderPerawat.isNotEmpty) {
            controller.dataFilter.add({
              "filter": [
                {
                  "gender": controller.selectedGenderPerawat.value,
                  "lat": Get.find<MapsController>().lat.value,
                  "long": Get.find<MapsController>().long.value
                },
              ],
              "sop": controller.tampunganNurseId
            });
          } else {
            if (controller.selectedGenderPerawat.isNotEmpty &&
                controller.umurPerawatC.text != "") {
              controller.dataFilter.add({
                "filter": [
                  {
                    "gender": controller.selectedGenderPerawat.value,
                    "old": controller.umurPerawatC.text,
                    "lat": Get.find<MapsController>().lat.value,
                    "long": Get.find<MapsController>().long.value
                  },
                ],
              });
            } else {
              controller.dataFilter.add({
                "filter": [
                  {
                    "gender": controller.selectedGenderPerawat.value,
                    "lat": Get.find<MapsController>().lat.value,
                    "long": Get.find<MapsController>().long.value
                  }
                ],
              });
            }
          }
        }
      }
      //UMUR
      else if (controller.umurPerawatC.text != "") {
        if (controller.tampunganNurseId.isNotEmpty &&
            controller.umurPerawatC.text != "") {
          controller.dataFilter.add({
            "filter": [
              {
                "old": controller.umurPerawatC.text,
                "lat": Get.find<MapsController>().lat.value,
                "long": Get.find<MapsController>().long.value
              },
            ],
            "sop": controller.tampunganNurseId
          });
        } else {
          if (controller.selectedGenderPerawat.isNotEmpty &&
              controller.umurPerawatC.text != "") {
            controller.dataFilter.add({
              "filter": [
                {
                  "gender": controller.selectedGenderPerawat.value,
                  "old": controller.umurPerawatC.text,
                  "lat": Get.find<MapsController>().lat.value,
                  "long": Get.find<MapsController>().long.value
                },
              ],
            });
          } else {
            if (controller.selectedGenderPerawat.isNotEmpty &&
                controller.tampunganNurseId.isNotEmpty &&
                controller.umurPerawatC.text != "") {
              controller.dataFilter.add({
                "filter": [
                  {
                    "gender": controller.selectedGenderPerawat.value,
                    "old": controller.umurPerawatC.text,
                    "lat": Get.find<MapsController>().lat.value,
                    "long": Get.find<MapsController>().long.value
                  },
                ],
                "sop": controller.tampunganNurseId
              });
            } else {
              controller.dataFilter.add({
                "filter": [
                  {
                    "old": controller.umurPerawatC.text,
                  }
                ],
              });
            }
          }
        }
      }
      //TAMPUNGAN SOP
      else if (controller.tampunganNurseId.isNotEmpty) {
        if (controller.tampunganNurseId.isNotEmpty &&
            controller.umurPerawatC.text != "") {
          controller.dataFilter.add({
            "filter": [
              {
                "old": controller.umurPerawatC.text,
                "lat": Get.find<MapsController>().lat.value,
                "long": Get.find<MapsController>().long.value
              },
            ],
            "sop": controller.tampunganNurseId
          });
        } else {
          if (controller.selectedGenderPerawat.isNotEmpty &&
              controller.tampunganNurseId.isNotEmpty) {
            controller.dataFilter.add({
              "filter": [
                {
                  "gender": controller.selectedGenderPerawat.value,
                  "lat": Get.find<MapsController>().lat.value,
                  "long": Get.find<MapsController>().long.value
                },
              ],
              "sop": controller.tampunganNurseId
            });
          } else {
            if (controller.selectedGenderPerawat.isNotEmpty &&
                controller.tampunganNurseId.isNotEmpty &&
                controller.umurPerawatC.text != "") {
              controller.dataFilter.add({
                "filter": [
                  {
                    "gender": controller.selectedGenderPerawat.value,
                    "old": controller.umurPerawatC.text,
                    "lat": Get.find<MapsController>().lat.value,
                    "long": Get.find<MapsController>().long.value
                  },
                ],
                "sop": controller.tampunganNurseId
              });
            } else {
              controller.dataFilter.add({
                "filter": [
                  {
                    "lat": Get.find<MapsController>().lat.value,
                    "long": Get.find<MapsController>().long.value
                  },
                ],
                "sop": controller.tampunganNurseId
              });
            }
          }
        }
      } else {
        log('NO FILTER');
        controller.dataFilter.add({
          "filter": [
            {
              "lat": Get.find<MapsController>().lat.value,
              "long": Get.find<MapsController>().long.value
            }
          ]
        });
        if (Get.find<ControllerPayment>().serviceId.value == 5 ||
          Get.find<ControllerPayment>().serviceId.value == 6) {
        log('NO FILTER one shot');

                        log('message home');
        await controller.getNurseFilter();


        Get.to(() => ListHospital());
        Get.put(InputLayananController()).listDataNurse.value =
            Get.put(InputLayananController())
                .listDataNurse
                .where(
                  (p0) => p0['hospital'] != null,
                )
                .toList();
      } else {
        await controller.getNurseFilter();
        Get.to(() => ServiceOnCall(
              title: Get.find<ControllerPayment>().nameService.value == 2
                  ? "Personal Doctor"
                  : Get.find<ControllerPayment>().nameService.value == 4
                      ? "Nursing Home"
                      : Get.find<ControllerPayment>().nameService.value == 5
                          ? "Mother Care"
                          : Get.find<ControllerPayment>().nameService.value == 6
                              ? "Baby Care"
                              : "Telemedicine",
            ));
      }}

      if (Get.find<ControllerPayment>().serviceId.value == 5 ||
          Get.find<ControllerPayment>().serviceId.value == 6) {
        log('NO FILTER one shot');

                        log('message home');
        await controller.getNurseFilter();


        Get.to(() => ListHospital());
        Get.put(InputLayananController()).listDataNurse.value =
            Get.put(InputLayananController())
                .listDataNurse
                .where(
                  (p0) => p0['hospital'] != null,
                )
                .toList();
      } else {
        log('NO FILTER one');

        log(controller.dataFilter.toString());
        await controller.getNurseFilter();
        Get.to(() => ServiceOnCall(
              title: Get.find<ControllerPayment>().nameService.value == 2
                  ? "Personal Doctor"
                  : Get.find<ControllerPayment>().nameService.value == 4
                      ? "Nursing Home"
                      : Get.find<ControllerPayment>().nameService.value == 5
                          ? "Mother Care"
                          : Get.find<ControllerPayment>().nameService.value == 6
                              ? "Baby Care"
                              : "Telemedicine",
            ));
      }
    }
  }
}
