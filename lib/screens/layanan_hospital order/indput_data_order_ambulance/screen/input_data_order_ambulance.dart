import 'package:bionmed_app/constant/colors.dart';
import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/screens/layanan_nurse_home/controller/input_layanan_controller.dart';
import 'package:bionmed_app/screens/pesanan/maps.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:bionmed_app/widgets/container/container.dart';
import 'package:bionmed_app/widgets/input/input_primary.dart';
import 'package:bionmed_app/widgets/other/loading_indicator.dart';
import 'package:bionmed_app/widgets/txt/text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class InputDataOrderAmbulance extends StatefulWidget {
  const InputDataOrderAmbulance({Key? key}) : super(key: key);

  @override
  State<InputDataOrderAmbulance> createState() =>
      _InputDataOrderAmbulanceState();
}

class _InputDataOrderAmbulanceState extends State<InputDataOrderAmbulance> {
  final cLog = Get.put(InputLayananController());
  // final myC = Get.put(ProfileJadwalController());
  final myC = Get.put(MapsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: ListView(
        children: [
          Stack(
            children: [
              // Obx(
              //   () =>
              CachedNetworkImage(
                  imageUrl: cLog.detailNurse['image'] ?? "",
                  width: Get.width,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      loadingIndicator(color: AppColor.primaryColor),
                  errorWidget: (context, url, error) => Cntr(
                        height: 230,
                        width: Get.width,
                        image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/ambulance.png',
                            ),
                            fit: BoxFit.cover),
                      )
                  // Image.asset('assets/images/hospital.png'),
                  ),
              Padding(
                padding: const EdgeInsets.only(left: 45, top: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/ambulance1.png'),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Txt(
                      text: 'Layanan',
                      size: 20,
                      weight: FontWeight.w300,
                    ),
                    Txt(
                      text: 'Ambulance',
                      size: 20,
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
              )
              // ),
            ],
          ),
          Container(
            width: Get.width,
            height: Get.height,
            transform: Matrix4.translationValues(0.0, -25.0, 0.0),
            decoration: const BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(24),
              children: [
                Txt(
                  text: 'Data Pesanan',
                  size: 16,
                  weight: FontWeight.bold,
                ),
                const SizedBox(
                height: 10.0,
                ),
                Txt(
                  text: 'Lengkapi data pesanan anda disini',
                  color: const Color(0xff7C7C7C),
                  size: 11,
                  weight: FontWeight.normal,
                ),
                const SizedBox(
                height: 20.0,
                ),
                Txt(
                  text: 'Layanan Ambulance',
                  color: const Color(0xff7C7C7C),
                  weight: FontWeight.normal,
                ),
                const SizedBox(
                height: 10.0,
                ),
                 InkWell(
                onTap: () async {
                },
                child: Cntr(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  height: 45,
                  alignment: Alignment.centerLeft,
                  width: Get.width,
                  color: AppColor.bgForm,
                  radius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Obx(
                      //   () => controller.tampunganNurseId.isNotEmpty ||
                      //           controller.nursepaketData[index]['package_nurse_sops'] !=
                      //               []
                      //       ? Txt(
                      //           text: controller.tampunganNurseId.isEmpty ? "${controller.nursepaketData[index]['package_nurse_sops'].length} Dipilih" : '${controller.tampunganNurseId.length} Dipilih')
                      //       :
                      Txt(
                        text: 'Pilih tipe layanan',
                        color: AppColor.bodyColor.shade500,
                      ),
                      // ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColor.bodyColor.shade500,
                        size: 15,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
              height: 20.0,
              ),
              Txt(
                  text: 'Tentukan Jadwal Penjemputan',
                  color: const Color(0xff555555),
                  weight: FontWeight.normal,
                ),
              
              // ignore: avoid_unnecessary_containers
              Container(
                child: InputPrimary(
                  controller: TextEditingController(),
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
                      // Get.put(PilihJadwalController()).day.value =
                      //     DateFormat("EEEE", "id_ID").format(pickedDate);
                      // Get.find<ControllerPesanan>().day.value =
                      //     DateFormat("EEEE", "id_ID").format(pickedDate);
                      // String starDate =
                      //     DateFormat("yyyy-MM-dd HH:mm:ss").format(pickedDate);
                      // Get.put(PilihJadwalController()).startDate.value =
                      //     starDate;

                      // controller.tanggalC.text = formattedDate;
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
              Row(
                children: [
                  Checkbox(
                    shape: const CircleBorder(),
                    value: true
                  , onChanged: (value) {
                    
                  },),
                  Txt(text: 'Pesan Langsung ?')
                ],
              ),
              Txt(text: 'Alamat anda'),
              const SizedBox(
              height: 10.0,
              ),
              InkWell(
                onTap: () async {
                },
                child: Cntr(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  height: 45,
                  alignment: Alignment.centerLeft,
                  width: Get.width,
                  color: AppColor.bgForm,
                  radius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!),
                  child: Txt(
                    text: 'Masukkan posisi alamat anda',
                    color: AppColor.bodyColor.shade500,
                  ),
                ),
              ),
              const SizedBox(
              height: 20.0,
              ),
              Txt(text: 'Tujuan'),
              const SizedBox(
              height: 10.0,
              ),
              InkWell(
                onTap: () async {
                },
                child: Cntr(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  height: 45,
                  alignment: Alignment.centerLeft,
                  width: Get.width,
                  color: AppColor.bgForm,
                  radius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!),
                  child: Txt(
                    text: 'Masukkan tujuan alamat ',
                    color: AppColor.bodyColor.shade500,
                  ),
                ),
              ),

                 const SizedBox(
                height: 50.0,
                ),
                ButtonGradient(onPressed: () async{
                   await myC.getCurrentLocation().then((value) {
                          myC.lat.value = value.latitude;
                          myC.long.value = value.longitude;
                        });
                        await myC.getUserLocation();
                        Get.to(() => const Maaapp());

                }, label: "Pesan Sekarang"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TambahAlamatAmbulance extends StatelessWidget {
  TambahAlamatAmbulance({super.key});
  final myC = Get.put(MapsController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Scaffold(
        bottomSheet: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ButtonGradient(
              onPressed: () {
                
                // if (myC.alamatMaps.value == "") {
                //   showPopUp(
                //       onTap: () {
                //         Get.back();
                //       },
                //       imageAction: 'assets/json/eror.json',
                //       description: "Mohon isi Alamat Dari Maps!",
                //       onPress: () {
                //         Get.back();
                //       });
                // } else {
                //   final isValiForm = formKey.currentState!.validate();
                //   if (isValiForm) {
                //     myC.alamatLengkap.value =
                //         "${myC.alamatMaps.value}\n${myC.alamat.text}";
                //     myC.alamatLengkapSendAPI.value =
                //         "${myC.alamatMaps.value} ${myC.alamat.text}";
                //     // ignore: avoid_print
                //     print("UWUW${myC.alamatLengkap.value}");
                //   }
                // }
                    Get.back();
              },
              label: "Simpan"),
        ),
        appBar: AppBar(
          title: const Text("Kembali"),
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
                  "Detail Alamat",
                  style: TextStyles.subtitle2,
                ),
                const SizedBox(
                height: 20.0,
                ),
                 Container(
                    // padding: EdgeInsets.only(left: 15, right: 15),
                    alignment: Alignment.centerLeft,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: TextFormField(
                      // ignore: body_might_complete_normally_nullable
                      validator: (alamat) {
                        if (alamat.toString().isEmpty) {
                          return "Alamat Tidak Boleh Kosong";
                        }
                      },
                      onTap: () async {
                        if (myC.alamat.text.isEmpty) {
                          //  await myC.getCurrentLocation().then((value) {
                          //     myC.lat.value = value.latitude;
                          //     myC.long.value = value.longitude;
                          //   });
                          //   myC.getUserLocation();
                          //   Get.to(Maaapp());
                        } else {}
                      },
                      controller: myC.alamat,
                      decoration: InputDecoration(
                          hintText:
                              "Nama",
                          hintStyle:
                              TextStyle(color: Colors.grey[400], fontSize: 14),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none)),
                    )),
                const SizedBox(
                  height: 10.0,
                ),
                // InputPrimary(
                //   onChange: ((p0) {}),
                //   controller: myC.nama,
                //   onTap: () {},
                //   validate: (nama){
                //     if(nama.toString().isEmpty){
                //       return "Nama Tidak Boleh Kosong";
                //     }
                //   },
                //   hintText: "Masukkan Nama",
                // ),
                // InputPrimary(
                //    validate: (noHp){
                //     if(noHp.toString().isEmpty){
                //       return "Nomer Handphone Tidak Boleh Kosong";
                //     }
                //   },
                //   onChange: ((p0) {}),
                //   controller: myC.noHp,
                //   onTap: () {},
                //   keyboardType: TextInputType.number,
                //   hintText: "Masukan No Handphone",
                // ),
                Obx(
                  () => InkWell(
                      onTap: () async {
                        myC.isLoadingMaps(true);
                        await myC.getCurrentLocation().then((value) {
                          myC.lat.value = value.latitude;
                          myC.long.value = value.longitude;
                        });
                        await myC.getUserLocation();
                        Get.to(() => const Maaapp());
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        alignment: Alignment.topLeft,
                        width: Get.width,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Obx(
                          () => myC.alamatMaps.isNotEmpty
                              ? Text(myC.alamatMaps.value)
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Obx(() => Text(
                                          myC.isLoadingMaps.isTrue
                                              ? "Loading..."
                                              : 'Alamat lengkap',
                                          style: TextStyle(
                                              color: Colors.grey[500]!),
                                        )),
                                    const Icon(Icons.arrow_forward_ios)
                                  ],
                                ),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
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
                      // ignore: body_might_complete_normally_nullable
                      validator: (alamat) {
                        if (alamat.toString().isEmpty) {
                          return "Patokan Tidak Boleh Kosong";
                        }
                      },
                      onTap: () async {
                        if (myC.alamat.text.isEmpty) {
                          //  await myC.getCurrentLocation().then((value) {
                          //     myC.lat.value = value.latitude;
                          //     myC.long.value = value.longitude;
                          //   });
                          //   myC.getUserLocation();
                          //   Get.to(Maaapp());
                        } else {}
                      },
                      maxLines: 5,
                      controller: myC.alamat,
                      decoration: InputDecoration(
                          hintText:
                              "Patokan rumah",
                          hintStyle:
                              TextStyle(color: Colors.grey[400], fontSize: 14),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none)),
                    ))
                //    InkWell(
                //       onTap: () async {
                //         await myC.getCurrentLocation().then((value) {
                //             myC.lat.value = value.latitude;
                //             myC.long.value = value.longitude;
                //           });
                //           myC.getUserLocation();
                //         Get.to(Maaapp());
                //       },
                //       child: Obx(() => myC.city.isNotEmpty
                //               ? Text(
                //                   '${myC.desa.value} ${myC.kecamatan.value} ${myC.city.value}, ${myC.kabupaten.value}, ${myC.kodePos.value}, ${myC.negara.value}')
                //               : Row(
                //                 children: [
                //                   Text(
                //         'Masukan Lokasi',
                //         style: TextStyle(color: Colors.grey[500]!),
                //       ),
                //       const SizedBox(
                //       width: 10.0,
                //       ),
                //                   Text(
                //         'Buka Map',
                //         style: TextStyle(color: Colors.blue),
                //       ),
                //       const SizedBox(
                //       width: 4.0,
                //       ),
                //       Icon(Icons.open_in_new, size: 15,color: Colors.blue,)
                //                 ],
                //               )),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
