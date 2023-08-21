// ignore_for_file: avoid_print, duplicate_ignore

import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bionmed_app/constant/colors.dart';
import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/screens/login/controller_login.dart';
import 'package:bionmed_app/screens/payment/controller_payment.dart';
import 'package:bionmed_app/screens/pesanan/controller_pesanan.dart';
import 'package:bionmed_app/screens/pesanan/pesanan_doctor_on_call.dart';
import 'package:bionmed_app/screens/pilih_jadwal/controllers/pilih_jadwal_controller.dart';
import 'package:bionmed_app/screens/services/service_on_call.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:bionmed_app/widgets/other/loading_indicator.dart';
import 'package:bionmed_app/widgets/other/show_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class PagePesananJawal extends StatefulWidget {
  const PagePesananJawal({super.key});

  @override
  State<PagePesananJawal> createState() => _PagePesananJawalState();
}

class _PagePesananJawalState extends State<PagePesananJawal> {
  int timer1 = 0;
  @override
  void initState() {
    starTime();
    // print('UWU HAHA');
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    paymentC.dates.value = "";
    Get.find<ControllerPesanan>().spesialist.value = "";
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
  }

  int serviceId = Get.put(ControllerPayment()).serviceId.value;
  String imageService = Get.put(ControllerPayment()).imageService.value;
  final box = GetStorage();

  void starTime() {
    var setuju = box.read('dontShowAgainPesanan');
    Timer.periodic(const Duration(seconds: 1), (timer) {
      timer1++;
      // ignore: prefer_interpolation_to_compose_strings
      print('UWU haha' + timer1.toString());
      if (timer1 == 1) {
        if (setuju == null) {
          Widget image = Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  color: Color(0xffF3F3F3)),
              child: CachedNetworkImage(
                width: 150,
                imageUrl: imageService,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ));
          showModalBottomSheet(
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            context: context,
            builder: (context) {
              return SizedBox(
                height: 400,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 18, top: 14),
                          width: Get.width / 1.9,
                          height: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        serviceId == 17
                            ? image
                            : serviceId == 1
                                ? image
                                : serviceId == 2
                                    ? image
                                    : serviceId == 9
                                        ? image
                                        : serviceId == 10
                                            ? image
                                            : serviceId == 11
                                                ? image
                                                : serviceId == 16
                                                    ? image
                                                    : serviceId == 13
                                                        ? image
                                                        : image,
                                                        const SizedBox(
                                                        height: 15.0,
                                                        ),
                        serviceId == 2
                            ? const Text(
                                'Home Visit Doctor',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              )
                            : serviceId == 1
                                ? const Text(
                                    'Telemedicine',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )
                                : serviceId == 7
                                    ? const Text(
                                        'Laboratorium Klinik',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )
                                    : serviceId == 9
                                        ? const Text(
                                            'Nursing Home',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          )
                                        : serviceId == 10
                                            ? const Text(
                                                'Mother Care',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              )
                                            : serviceId == 11
                                                ? const Text(
                                                    'Baby Care',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  )
                                                : serviceId == 16
                                                    ? const Text(
                                                        'Apotik Online',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                      )
                                                    : serviceId == 13
                                                        ? const Text(
                                                            'Ambulance Online',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16),
                                                          )
                                                        : const Text(
                                                            'Online Registration',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16),
                                                          ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        serviceId == 2
                            ? const Text(
                                'Fitur layanan kunjungan dokter ke rumah pasien, layanan iini kana membuat pasien yang sangat membutuhkan pertolongan segera akan tetapi pasien tidak memungkinkan di bawa ke rumah sakit, atau pasien menginginkan kenyamanan tanpa harus pergi ke rumah sakit.',
                                style: TextStyle(),
                                textAlign: TextAlign.center)
                            : serviceId == 1
                                ? const Text(
                                    'Konsultasi Medis dengan dokter spesialis melalui Chat, Voice call dan Video call',
                                    style: TextStyle(),
                                    textAlign: TextAlign.center)
                                : serviceId == 7
                                    ? const Text(
                                        'Pelayanan Laboratorium klinik tanpa harus meninggalkan rumah. Tenaga medis pengambilan sampel yang handal dan realisasi hasil segera',
                                        style: TextStyle(),
                                        textAlign: TextAlign.center)
                                    : serviceId == 9
                                        ? const Text(
                                            'Fitur pelayanan perawatan pasien di rumah pasien oleh perawat yang sudah berpengalaman dan sudah mempunyai sertifikat medis',
                                            style: TextStyle(),
                                            textAlign: TextAlign.center)
                                        : serviceId == 10
                                            ? const Text(
                                                'Pelayanan perawatan ibu hamil dan pasca persalinan atau pasca operasi oleh perawat berpengalaman dan bersertifikat medis',
                                                style: TextStyle(),
                                                textAlign: TextAlign.center)
                                            : serviceId == 11
                                                ? const Text(
                                                    'Fitur pelayanan perawatan perawat berpengalaman dan bersertifikat medis dan pemberian vaksin untuk Bayi anda di rumah sendiri oleh dokter Spesialis anak yang berpengalaman',
                                                    style: TextStyle(),
                                                    textAlign: TextAlign.center)
                                                : serviceId == 16
                                                    ? const Text(
                                                        'Pelayanan pembelian obat sesuai kebutuhan, dengan atau tanpa resep. Pilihan obat yang lengkap dengan harga yang terjangkau',
                                                        style: TextStyle(),
                                                        textAlign:
                                                            TextAlign.center)
                                                    : serviceId == 13
                                                        ? const Text(
                                                            'Pelayanan pemesanan Ambulance secara Online',
                                                            style: TextStyle(),
                                                            textAlign: TextAlign
                                                                .center)
                                                        : const Text(
                                                            'Pelayanan registration (pendaftaran pelayanan medis secara on line) sehingga sangat menghemat waktu pasien dan tidak membuat pasien menunggu.',
                                                            style: TextStyle(),
                                                            textAlign: TextAlign
                                                                .center),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => Checkbox(
                                value: Get.find<ControllerPesanan>()
                                    .dontShowAgainPesanan
                                    .value,
                                onChanged: (value) {
                                  Get.find<ControllerPesanan>()
                                      .dontShowAgainPesanan
                                      .toggle();
                                },
                              ),
                            ),
                            const Text('Jangan Tampilkan Lagi')
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: ButtonGradient(
                              label: "Oke",
                              onPressed: () async {
                                if (Get.find<ControllerPesanan>()
                                    .dontShowAgainPesanan
                                    .isTrue) {
                                  box.write("dontShowAgainPesanan", true);
                                }
                                Get.back();
                              }),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        timer.cancel();
        timer1 = 0;
      } else {
        timer.cancel();
      }
    });
  }

  String title = "Pesanan";
  String dates = "";
  String times = "";
  String gender = "";
  String dateTime = "";

  TextEditingController nama = TextEditingController();
  TextEditingController usia = TextEditingController();
  TextEditingController noTel = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController jadwal = TextEditingController();
  TextEditingController desc = TextEditingController();

  final paymentC = Get.find<ControllerPayment>();
  final pilihC = Get.put(PilihJadwalController());

  datePicker() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      // ignore: avoid_print
      print("CEEEKK $pickedDate");
      pilihC.day.value = DateFormat('EEEE', "id").format(pickedDate);
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      String starDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      Get.put(PilihJadwalController()).startDate.value = starDate;

      // ignore: avoid_print
      print("uwu${pilihC.day.value}");

      Get.find<ControllerPesanan>().dayHome =
          DateFormat("EEEE", "id_ID").format(pickedDate);
      print("CEEK StartDate${Get.find<ControllerPesanan>().dayHome}");
      Get.find<ControllerPayment>().dates.value = formattedDate;
    } else {
      // ignore: avoid_print
      print("Date is not selected");
    }
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
        var finaltime = DateFormat("HH:mm:ss", "id_ID").format(dt);
        times = finaltime.toString();
        // this will return 13:30 only
      });
    }
  }

  Widget buildTimePicker() {
    return SizedBox(
      height: MediaQuery.of(context).copyWith().size.height / 3,
      child: CupertinoDatePicker(
        initialDateTime: DateTime.now(),
        onDateTimeChanged: (DateTime newdate) {
          String dates = DateFormat("HH:mm:ss", "id_ID").format(newdate);
          print(dates);
          Get.find<ControllerPayment>().times.value = dates.toString();
        },
        use24hFormat: true,
        // maximumDate: new DateTime(2050, 12, 30),
        // minimumYear: 2010,
        // maximumYear: 2018,
        // minuteInterval: 1,
        mode: CupertinoDatePickerMode.time,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('ZEZEn${Get.find<ControllerPayment>().nameService.value}');
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
            onTap: () {
              print(
                  'ZZZ${Get.find<PilihJadwalController>().startDate.value.substring(8, 10)}');
            },
            child: Text(title)),
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
          () => Get.find<ControllerLogin>().isloading.value == true
              ? loadingIndicator(color: AppColor.primaryColor)
              : ButtonGradient(
                  label: "Lanjutkan",
                  onPressed: () async {
                    Get.find<ControllerPayment>().dateOrderHomeVisit.value =
                        "${Get.find<PilihJadwalController>().startDate.value} ${Get.find<ControllerPayment>().times.value}";
                    print(
                        "UWUW${Get.find<ControllerPayment>().dateOrderHomeVisit.value}");
                    if (Get.find<ControllerPayment>().nameService.value ==
                            "Home Visit Doctor" ||
                        Get.find<ControllerPayment>().nameService.value ==
                            "Nursing Home") {
                      if (Get.find<PilihJadwalController>().startDate.value ==
                          "") {
                        showPopUp(
                            onTap: () {
                              Get.back();
                            },
                            imageAction: 'assets/json/eror.json',
                            description:
                                "Mohon Isi Tanggal atau Jam \nTerlebih Dahulu",
                            onPress: () {
                              Get.back();
                            });
                      } else {
                        if (Get.find<ControllerPayment>().nameService.value ==
                                "Home Visit Doctor" ||
                            Get.find<ControllerPayment>().nameService.value ==
                                "Nursing Home") {
                          Get.to(() => const PagePesananDoctorOnCall());
                        } else {
                          print(Get.find<ControllerPesanan>().spesialist.value);
                          print(
                              'WHO${Get.find<ControllerPesanan>().idSpesialist}');
                          print('UWU${paymentC.dates}');
                          Get.find<ControllerLogin>().getDoctorBySpesialisId(
                              id: Get.find<ControllerPesanan>()
                                  .idSpesialist
                                  .value);
                          await Get.find<ControllerLogin>()
                              .getDoctorByServiceId(
                                  id: Get.find<ControllerPayment>()
                                      .serviceId
                                      .value
                                      .toString(),
                                  day: Get.find<ControllerPesanan>().dayHome,
                                  jam: paymentC.times.value,
                                  spesialist: Get.find<ControllerPesanan>()
                                      .idSpesialist
                                      .value);
                          Get.to(() => ServiceOnCall(
                                title: Get.find<ControllerPayment>()
                                    .nameService
                                    .value,
                              ));

                          print(
                              "CEK COK${Get.find<ControllerPesanan>().idSpesialist.value}");
                        }
                      }
                    } else {
                      if (Get.find<PilihJadwalController>().startDate.value ==
                          "") {
                        showPopUp(
                            onTap: () {
                              Get.back();
                            },
                            imageAction: 'assets/json/eror.json',
                            description: "Mohon Isi Tanggal\nTerlebih Dahulu",
                            onPress: () {
                              Get.back();
                            });
                      } else {
                        print(Get.find<ControllerPesanan>().spesialist.value);
                        print(
                            'WHO${Get.find<ControllerPesanan>().idSpesialist}');
                        print('UWU${paymentC.dates}');

                        Get.find<ControllerLogin>().getDoctorBySpesialisId(
                            id: Get.find<ControllerPesanan>()
                                .idSpesialist
                                .value);
                        await Get.find<ControllerLogin>().getDoctorByServiceId(
                            id: Get.find<ControllerPayment>()
                                .serviceId
                                .value
                                .toString(),
                            day: Get.find<ControllerPesanan>().dayHome,
                            jam: paymentC.times.value,
                            spesialist: Get.find<ControllerPesanan>()
                                .idSpesialist
                                .value);
                        Get.to(() => ServiceOnCall(
                              title: Get.find<ControllerPayment>()
                                  .nameService
                                  .value,
                            ));

                        print(
                            "CEK COK${Get.find<ControllerPesanan>().idSpesialist.value}");
                      }
                    }

                    //
                  },
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
                "Tentukan Jadwal Konsultasi",
                style: TextStyles.subtitle2,
              ),
              Text(
                "Atur jadwal konsultasi anda untuk menerima layanan",
                style: TextStyles.body2,
              ),
              verticalSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      datePicker();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              width: 1, color: AppColor.bodyColor.shade300)),
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Row(
                          children: [
                            Obx(() => Row(
                                  children: [
                                    Icon(
                                      Icons.date_range,
                                      color: AppColor.bodyColor.shade300,
                                    ),
                                    horizontalSpace(10),
                                    paymentC.dates.value != ""
                                        ? Text(
                                            paymentC.dates.value,
                                            style: const TextStyle(
                                                color: AppColor.bodyColor),
                                          )
                                        : Text(
                                            "Pilih Tanggal",
                                            style: TextStyle(
                                                color: AppColor
                                                    .bodyColor.shade300),
                                          )
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  horizontalSpace(20),
                ],
              ),
              verticalSpace(15),
              const Text("Pilih spesialis"),
              verticalSpace(10),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        // <-- SEE HERE
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        ),
                      ),
                      builder: (context) {
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              verticalSpace(10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 150,
                                    height: 5,
                                    decoration: BoxDecoration(
                                        color: AppColor.bodyColor.shade200,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ],
                              ),
                              // verticalSpace(30),
                              for (int i = 0;
                                  i <
                                      Get.find<ControllerLogin>()
                                          .dataSpecialist
                                          .length;
                                  i++)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: InkWell(
                                    onTap: () {
                                      print(
                                          'WHO${Get.find<ControllerLogin>().dataSpecialist[i]['id']}');
                                      Get.find<ControllerPesanan>()
                                              .spesialist
                                              .value =
                                          Get.find<ControllerLogin>()
                                              .dataSpecialist[i]['name'];
                                      Get.find<ControllerPesanan>()
                                              .idSpesialist
                                              .value =
                                          Get.find<ControllerLogin>()
                                              .dataSpecialist[i]['id']
                                              .toString();
                                      // Get.back();
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.network(
                                              Get.find<ControllerLogin>()
                                                  .dataSpecialist[i]['image'],
                                              width: 30.w,
                                            ),
                                            horizontalSpace(10),
                                            SizedBox(
                                              width: Get.width * 0.5,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  AutoSizeText(
                                                    Get.find<ControllerLogin>()
                                                            .dataSpecialist[i]
                                                        ['name'],
                                                    style: const TextStyle(
                                                        fontSize: 12),
                                                    maxLines: 3,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Obx((() => Get.find<ControllerLogin>()
                                                        .dataSpecialist[i]
                                                    ['name'] ==
                                                Get.find<ControllerPesanan>()
                                                    .spesialist
                                                    .value
                                            ? const Icon(
                                                Icons.circle,
                                                color: AppColor.primaryColor,
                                              )
                                            : const Icon(
                                                Icons.circle_outlined)))
                                      ],
                                    ),
                                  ),
                                ),
                              verticalSpace(20),
                            ],
                          ),
                        );
                      });
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: AppColor.bodyColor.shade300),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => Text(
                              Get.find<ControllerPesanan>().spesialist.value ==
                                      ""
                                  ? "Kategori Spesialis"
                                  : Get.find<ControllerPesanan>()
                                      .spesialist
                                      .value,
                              style: TextStyles.body2.copyWith(
                                  color: Get.find<ControllerPesanan>()
                                          .spesialist
                                          .value
                                          .isEmpty
                                      ? AppColor.bodyColor.shade300
                                      : AppColor.bodyColor)),
                        ),
                        Obx(() => Get.find<ControllerPesanan>()
                                .spesialist
                                .value
                                .isEmpty
                            ? Icon(
                                Icons.arrow_forward,
                                color: AppColor.bodyColor.shade300,
                              )
                            : IconButton(
                                onPressed: () {
                                  Get.find<ControllerPesanan>()
                                      .spesialist
                                      .value = "";
                                  Get.find<ControllerPesanan>()
                                      .idSpesialist
                                      .value = "";
                                },
                                icon: const Icon(
                                  Icons.highlight_remove_sharp,
                                  color: Colors.red,
                                )))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
