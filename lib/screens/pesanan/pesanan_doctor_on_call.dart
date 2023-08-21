import 'package:bionmed_app/constant/colors.dart';
import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/screens/home/home_controller.dart';
import 'package:bionmed_app/screens/home/home_screen.dart';
import 'package:bionmed_app/screens/payment/controller_payment.dart';
import 'package:bionmed_app/screens/pesanan/controller_pesanan.dart';
import 'package:bionmed_app/screens/pesanan/maps.dart';
import 'package:bionmed_app/screens/services/service_on_call.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:bionmed_app/widgets/input/input_primary.dart';
import 'package:bionmed_app/widgets/other/show_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PagePesananDoctorOnCall extends StatefulWidget {
  const PagePesananDoctorOnCall({super.key});

  @override
  State<PagePesananDoctorOnCall> createState() =>
      _PagePesananDoctorOnCallState();
}

class _PagePesananDoctorOnCallState extends State<PagePesananDoctorOnCall> {
  String title = "Data Pasien";
  String dates = "";
  String times = "";

  TextEditingController nama = TextEditingController();
  TextEditingController usia = TextEditingController();
  TextEditingController noTel = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController jadwal = TextEditingController();
  TextEditingController desc = TextEditingController();
  final paymentC = Get.find<ControllerPayment>();
  final formKey = GlobalKey<FormState>();

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
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Obx(
            () => ButtonGradient(
              label: Get.find<ControllerPesanan>().loading.isFalse
                  ? "Pesan Sekarang"
                  : "Loading...",
              onPressed: () async {
                if (myC.alamatLengkap.value == "") {
                  showPopUp(
                      onTap: () {
                        Get.back();
                      },
                      imageAction: 'assets/json/eror.json',
                      description: "Mohon isi Alamat Terlebih Dahulu!",
                      onPress: () {
                        Get.back();
                      });
                } else {
                  final isValiForm = formKey.currentState!.validate();
                  if (isValiForm) {
                    if (Get.find<ControllerPesanan>().loading.isFalse) {
                      // Get.find<ControllerLogin>().getDoctorBySpesialisId(
                      //     id: Get.find<ControllerPesanan>().idSpesialist.value);
                      await Get.find<ControllerPesanan>().getDoctorHomeVisit();
                      Get.to(() => ServiceOnCall(
                                title: Get.find<ControllerPayment>()
                                    .nameService
                                    .value,
                              )
                          // await Get.find<ControllerLogin>().getDoctorByServiceId(
                          //     id: Get.find<ControllerPayment>()
                          //         .serviceId
                          //         .value
                          //         .toString(),
                          //     day: Get.find<ControllerPesanan>().dayHome,
                          //     jam: paymentC.times.value,
                          //     spesialist:
                          //         Get.find<ControllerPesanan>().idSpesialist.value);
                          );
                    }

                    //  await Get.find<PilihJadwalController>().registerSlot(
                    //                                                 date: Get.find<PilihJadwalController>()
                    //                                                     .startDate
                    //                                                     .value);
                    // // Get.find<ControllerPayment>().addOrder(
                    // //     date: Get.find<ControllerPayment>()
                    // //         .datesDoctorCall
                    // //         .value
                    // //         .toString(),
                    // //     time: Get.find<ControllerPayment>()
                    // //         .timesDoctorCall
                    // //         .value
                    // //         .toString());
                    // ======================
                    // await Get.find<ControllerPayment>().addOrderHomeVisit();
                    // Get.find<ControllerPayment>().dates.value = "";
                    // Get.find<ControllerPayment>().times.value = "";
                    // Get.find<ControllerPayment>().updateOrder(
                    //     name: nama.text,
                    //     age: usia.text,
                    //     gender: gender,
                    //     phoneNumber: noTel.text,
                    //     address: Get.find<MapsController>().alamatLengkapSendAPI.value,
                    //     description: desc.text);
                  }
                }
              },
            ),
          )),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Input Pesanan",
                  style: TextStyles.subtitle2,
                ),
                Text(
                  "Masukkan data & alamat untuk menerima pelayanan",
                  style: TextStyles.body2,
                ),
                InputPrimary(
                  validate: (value) {
                    if (nama.text.isNotEmpty) {
                      return null;
                    }
                    return "Nama Tidak Boleh Kosong";
                  },
                  onChange: ((p0) {}),
                  controller: nama,
                  onTap: () {},
                  hintText: "Masukkan Nama",
                ),
                InputPrimary(
                  validate: (value) {
                    if (usia.text.isNotEmpty) {
                      return null;
                    }
                    return "Usia Tidak Boleh Kosong";
                  },
                  onChange: ((p0) {}),
                  controller: usia,
                  onTap: () {},
                  keyboardType: TextInputType.number,
                  hintText: "Masukkan Usia",
                ),
                InputPrimary(
                  validate: (value) {
                    if (noTel.text.isNotEmpty) {
                      return null;
                    }
                    return "No.Handphone Tidak Boleh Kosong";
                  },
                  onChange: ((p0) {}),
                  controller: noTel,
                  onTap: () {},
                  keyboardType: TextInputType.number,
                  hintText: "Masukkan No.Handphone",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.find<ControllerPesanan>().gender.value = false;
                        setState(() {
                          Get.find<ControllerPesanan>().genderHome =
                              "Laki laki";
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
                          Get.find<ControllerPesanan>().genderHome =
                              "Perempuan";
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
                                Get.find<ControllerPesanan>().gender.value ==
                                        true
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
                          bool isLocationEnabled =
                              await Get.find<HomeController>().checkGpsStatus();
                          if (isLocationEnabled) {
                            Get.to(TambahAlamat());
                          } else {
                            Get.to(TambahAlamat());
                            popUpGetLokasi();
                          }

                          // await myC.getCurrentLocation().then((value) {
                          //     myC.lat.value = value.latitude;
                          //     myC.long.value = value.longitude;
                          //   });
                          //   myC.getUserLocation();
                          // Get.to(Maaapp());
                        },
                        child: Obx(() => myC.city.isNotEmpty
                            ? Text(myC.alamatLengkap.value)
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                // InputPrimary(
                //   onChange: ((p0) {}),
                //   controller: alamat,
                //   onTap: () {},
                //   keyboardType: TextInputType.text,
                //   hintText: "Masukkan Alamat Anda",
                // ),
                // Text(
                //   "Jadwal",
                //   style: TextStyles.subtitle2,
                // ),
                // verticalSpace(10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     InkWell(
                //       onTap: () {
                //         datePicker();
                //       },
                //       child: Container(
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(8),
                //             border: Border.all(
                //                 width: 1, color: AppColor.bodyColor.shade300)),
                //         child: Padding(
                //           padding: const EdgeInsets.all(7.0),
                //           child: Row(
                //             children: [
                //               Obx(() => Row(
                //                     children: [
                //                       Icon(
                //                         Icons.date_range,
                //                         color: AppColor.bodyColor.shade300,
                //                       ),
                //                       horizontalSpace(10),
                //                       Get.find<ControllerPayment>()
                //                               .datesDoctorCall
                //                               .isNotEmpty
                //                           ? Text(
                //                               Get.find<ControllerPayment>()
                //                                   .datesDoctorCall
                //                                   .value
                //                                   .toString(),
                //                               style: const TextStyle(
                //                                   color: AppColor.bodyColor),
                //                             )
                //                           : Text(
                //                               "Pilih Tanggal",
                //                               style: TextStyle(
                //                                   color: AppColor
                //                                       .bodyColor.shade300),
                //                             )
                //                     ],
                //                   )),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //     horizontalSpace(20),
                //     InkWell(
                //       onTap: () {
                //         showModalBottomSheet(
                //             context: context,
                //             builder: (context) {
                //               return Column(
                //                 mainAxisSize: MainAxisSize.min,
                //                 children: <Widget>[
                //                   buildTimePicker(),
                //                   ElevatedButton(
                //                     onPressed: () {
                //                       Get.back();
                //                     },
                //                     child: Text('Ok'),
                //                   ),
                //                   const SizedBox(
                //                     height: 10.0,
                //                   ),
                //                 ],
                //               );
                //             });
                //         // timePicker();
                //         // datePicker();
                //       },
                //       child: Container(
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(8),
                //             border: Border.all(
                //                 width: 1, color: AppColor.bodyColor.shade300)),
                //         child: Padding(
                //           padding: const EdgeInsets.all(7.0),
                //           child: Row(
                //             children: [
                //               Obx(() => Row(
                //                     children: [
                //                       Icon(
                //                         Icons.timer,
                //                         color: AppColor.bodyColor.shade300,
                //                       ),
                //                       horizontalSpace(10),
                //                       Get.find<ControllerPayment>()
                //                               .timesDoctorCall
                //                               .value
                //                               .isNotEmpty
                //                           ? Text(
                //                               Get.find<ControllerPayment>()
                //                                   .timesDoctorCall
                //                                   .value
                //                                   .toString(),
                //                               style: const TextStyle(
                //                                   color: AppColor.bodyColor),
                //                             )
                //                           : Text(
                //                               "Pilih Jam",
                //                               style: TextStyle(
                //                                   color: AppColor
                //                                       .bodyColor.shade300),
                //                             )
                //                     ],
                //                   )),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // verticalSpace(10),
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
                      validator: (value) {
                        if (desc.text.isNotEmpty) {
                          return null;
                        }
                        return "Keluhan Tidak Boleh Kosong";
                      },
                      maxLines: 5,
                      controller: desc,
                      decoration: const InputDecoration(
                          hintText: "Keluhan",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    )
                    // ),
                    )
                // InputPrimary(
                //   onChange: ((p0) {}),
                //   controller: desc,
                //   onTap: () {},
                //   keyboardType: TextInputType.text,
                //   hintText: "Keluhan",
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TambahAlamat extends StatelessWidget {
  TambahAlamat({super.key});
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
                if (myC.alamatMaps.value == "") {
                  showPopUp(
                      onTap: () {
                        Get.back();
                      },
                      imageAction: 'assets/json/eror.json',
                      description: "Mohon isi Alamat Dari Maps!",
                      onPress: () {
                        Get.back();
                      });
                } else {
                  final isValiForm = formKey.currentState!.validate();
                  if (isValiForm) {
                    myC.alamatLengkap.value =
                        "${myC.alamatMaps.value}\n${myC.alamat.text}";
                    myC.alamatLengkapSendAPI.value =
                        "${myC.alamatMaps.value} ${myC.alamat.text}";
                    // ignore: avoid_print
                    print("UWUW${myC.alamatLengkap.value}");
                    Get.back();
                  }
                }
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
                  "Alamat Anda",
                  style: TextStyles.subtitle2,
                ),
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
                        alignment: Alignment.centerLeft,
                        width: Get.width,
                        height: myC.city.isEmpty ? 50 : null,
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
                                              : 'Buka Maps',
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
                      maxLines: 5,
                      controller: myC.alamat,
                      decoration: InputDecoration(
                          hintText:
                              "Masukkan Detail Lokasi *Contoh : Pinggir Apotik",
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
