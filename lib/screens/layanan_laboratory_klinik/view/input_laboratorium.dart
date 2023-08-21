import 'package:bionmed_app/constant/colors.dart';
import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/screens/layanan_laboratory_klinik/controller/input_labo_klinik_controller.dart';
import 'package:bionmed_app/screens/layanan_nurse_home/controller/input_layanan_controller.dart';
import 'package:bionmed_app/screens/pesanan/maps.dart';
import 'package:bionmed_app/screens/pesanan/pesanan_doctor_on_call.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:bionmed_app/widgets/container/container.dart';
import 'package:bionmed_app/widgets/input/input_primary.dart';
import 'package:bionmed_app/widgets/other/show_dialog.dart';
import 'package:bionmed_app/widgets/txt/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputLaboKlinik extends StatefulWidget {
  const InputLaboKlinik({super.key});

  @override
  State<InputLaboKlinik> createState() => _InputLaboKlinikState();
}

class _InputLaboKlinikState extends State<InputLaboKlinik> {
  final jenisKelamin = ['Laki - laki', "Perempuan"];

  final controller = Get.put(InputLayananController());
  final laboController = Get.put(InputLaboKlinikController());

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
                "Layanan Tes Lab",
                style: TextStyles.subtitle2,
              ),
              Text(
                "Pilih layanan tes laboratorium",
                style: TextStyles.body2,
              ),
              const SizedBox(
                height: 20.0,
              ),
              // ignore: prefer_const_constructors
              // ignore: avoid_unnecessary_containers
              const SizedBox(
                height: 10.0,
              ),
              Text(
                "Layanan",
                style: TextStyles.body2,
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
                                        text: 'Tes Laboratorium',
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
                                                  controller.tampunganNurseId
                                                      .removeWhere((element) =>
                                                          element[
                                                              'work_scope_id'] ==
                                                          controller
                                                                  .nurseScopeData[
                                                              index]['id']);
                                                }
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
                                ? 'Pilih'
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
                height: 10.0,
              ),
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        laboController.onCheck.value =
                            !laboController.onCheck.value;
                      },
                      child: Obx(() => Icon(
                            laboController.onCheck.isFalse
                                ? Icons.check_box_outline_blank
                                : Icons.check_box,
                            color: laboController.onCheck.isFalse
                                ? Colors.grey[500]
                                : Colors.blue,
                          ))),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Txt(
                    text: 'Direferensikan oleh dokter telemedicine?',
                    color: Colors.grey[500],
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                "Data Diri",
                style: TextStyles.subtitle2,
              ),
              Text(
                "Kebutuhan data tes laboratorium",
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
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
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
                onTap: () {
                  Get.to(() => TambahAlamat());
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
                  onPressed: () async {
                    // if (controller.tanggalC.text == "" ||
                    //     controller.jamTerpilih.isEmpty ||
                    //     // controller.selectedGenderPerawat.isEmpty ||
                    //     // controller.umurPerawatC.text == "" ||
                    //     // controller.tampunganNurseId.isEmpty ||
                    //     controller.namePasienC.text == "" ||
                    //     controller.selectedGenderPasien.isEmpty ||
                    //     controller.umurPasienC.text == "" ||
                    //     mapC.city.isEmpty ||
                    //     controller.keluhanC.text == "" ||
                    //     controller.imageUrl.isEmpty) {
                      showPopUp(
                          onTap: () {
                            Get.back();
                          },
                          imageAction: "assets/json/eror.json",
                          description: "Under Develovment");
                    // } 
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
