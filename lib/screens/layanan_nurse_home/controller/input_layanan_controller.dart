import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bionmed_app/constant/string.dart';
import 'package:bionmed_app/constant/url.dart';
import 'package:bionmed_app/screens/layanan_nurse_home/controller/waiting_respon_nurse_controller.dart';
import 'package:bionmed_app/screens/login/controller_login.dart';
import 'package:bionmed_app/screens/payment/controller_payment.dart';
import 'package:bionmed_app/screens/pesanan/maps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../../pilih_jadwal/controllers/pilih_jadwal_controller.dart';

class InputLayananController extends GetxController {
  final mapC = Get.put(MapsController());
  final waitingC = Get.put(WaitingResponNurseController());

  RxString jamTerpilih = "".obs;
  RxString jamTerpilihForSend = "".obs;
  RxString jamSekarangPlus3Jam = "".obs;
  RxInt jamSekarangPlus4JamFix = 0.obs;
  RxString dateTerpilih = "".obs;
  RxString selectedGenderPerawat = "".obs;
  RxString selectedGenderPasien = "".obs;
  RxString imageUrl = "".obs;
  RxString totalPrice = ''.obs;
  RxString priceBeforeDiskon = ''.obs;
  RxString serviceNurseId = ''.obs;
  RxDouble totalPriceDouble = 0.0.obs;
  RxInt totalPriceFix = 0.obs;
  RxInt diskonPesananNurse = 0.obs;
  DateTime? startTime;
  RxBool isloading = false.obs;
  final ImagePicker _picker = ImagePicker();
  // ignore: prefer_typing_uninitialized_variables
  var files;
  TextEditingController tanggalC = TextEditingController();
  TextEditingController namePasienC = TextEditingController();
  TextEditingController jamC = TextEditingController();
  TextEditingController umurPerawatC = TextEditingController();
  TextEditingController umurPasienC = TextEditingController();
  TextEditingController keluhanC = TextEditingController();

  RxList dataFilter = [].obs;
  RxList listDataNurse = [].obs;
  RxList listPaketDataNurse = [].obs;
  RxMap detailNurse = {}.obs;
  RxMap detailScope = {}.obs;
  RxInt idNurse = 0.obs;
  RxList educationNurse = [].obs;
  Map<String, dynamic> filterNurse = {};
  var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  var now = DateTime.now();

  Widget buildTimePickerMulai() {
    return SizedBox(
      height: Get.height / 3,
      child: CupertinoDatePicker(
        initialDateTime: DateTime.now(),
        onDateTimeChanged: (DateTime newdate) {
          String dates = DateFormat("HH:mm", "en_US").format(newdate);
          String datesToSendApi =
              DateFormat("HH:mm:ss", "en_US").format(newdate);
          jamSekarangPlus3Jam.value = DateTime.now().toString();
          startTime = newdate;
          jamTerpilih.value = dates;
          jamTerpilihForSend.value = datesToSendApi;
          jamSekarangPlus4JamFix.value = int.parse(jamSekarangPlus3Jam.value.substring(10, 13));
          log(jamSekarangPlus4JamFix.value.toString());
        },
        use24hFormat: true,
        mode: CupertinoDatePickerMode.time,
      ),
    );
  }

  Future<File?> takePhoto(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final File? file = File(image!.path);
    files == file;
    files = File(image.path);
    imageUrl.value = files.toString();
    return file;
  }

  Future<dynamic> getNurseFilter() async {
    final params = <String, dynamic>{
      "filter" : [{
          "lat": Get.find<MapsController>().lat.value,
          "long": Get.find<MapsController>().long.value}]
      // "sop": tampunganNurseId
    };
    isloading(true);
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}filter-nurse/${Get.find<ControllerPayment>()
                              .serviceId
                              .value}',
          Method.POST,
          dataFilter.isEmpty ? params : dataFilter[0] as Map<String, dynamic>);
      // ignore: unused_local_variable
      final listNurseFromFilter = json.decode(result.toString());
      listDataNurse.value = listNurseFromFilter['data'];
      dataFilter.clear();

      // jadwalDokter = jadwal['data']['doctor_schedules'];
      // }

      isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print, prefer_interpolation_to_compose_strings
      print('ZAZAZA ' + e.toString());
    }
  }

  Future<dynamic> getListNurse() async {
    final params = <String, dynamic>{};
    isloading(true);
    try {
      final result = await RestClient()
          .request('${MainUrl.urlApi}filter-nurse', Method.POST, params);
      // ignore: unused_local_variable
      final listNurseFromFilter = json.decode(result.toString());
      listDataNurse.value = listNurseFromFilter['data'];

      // jadwalDokter = jadwal['data']['doctor_schedules'];
      // }

      isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print, prefer_interpolation_to_compose_strings
      print('ZAZAZA ' + e.toString());
    }
  }

  Future<dynamic> getPaketbyNurseFilter() async {
    final params = <String, dynamic>{
      "serviceId": Get.find<ControllerPayment>().serviceId.value,
      "sop": tampunganNurseId
    };
    isloading(true);
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}nurse/package/${detailNurse['id']}',
          Method.POST,
          params);
      // ignore: unused_local_variable
      final listNursePaketFromFilter = json.decode(result.toString());
      listPaketDataNurse.value = listNursePaketFromFilter['data'];

      // jadwalDokter = jadwal['data']['doctor_schedules'];
      // }

      isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print('ZAZAZA $e');
    }
  }

  Future<dynamic> getDetailNurse() async {
    final params = <String, dynamic>{};
    isloading(true);
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}nurse/detail/$idNurse', Method.GET, params);
      // ignore: unused_local_variable
      final detailNurseProfile = json.decode(result.toString());
      detailNurse.value = detailNurseProfile['data'];
      educationNurse.value = detailNurse['nurse_educations'];

      // jadwalDokter = jadwal['data']['doctor_schedules'];
      // }

      isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  RxBool value = false.obs;
  RxList tampunganNurseId = [].obs;
  RxBool selected = false.obs;
  RxList nurseScopeData = [].obs;
  RxList dataActive = [].obs;
  RxList packageNurseSops = [].obs;

  Future<dynamic> getNurseWorkScope() async {
    isloading(true);
    final params = <String, dynamic>{};
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}nurse-work-scope/${Get.find<ControllerPayment>().serviceId.value}',
          Method.GET,
          params);
      var nurseWorkScope = json.decode(result.toString());
      nurseScopeData.value = nurseWorkScope['data'];
      // ignore: unused_local_variable
      for (var i in nurseScopeData) {
        dataActive.add({"value": false});
      }

      isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print("Cek error pesan$e");
    }
  }

  Future<dynamic> getNurseWorkScopeDetail(String id) async {
    isloading(true);
    final params = <String, dynamic>{};
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}package-nurse/edit/$id', Method.GET, params);
      var detaulNurseWorkScope = json.decode(result.toString());
      detailScope.value = detaulNurseWorkScope["data"];
      // ignore: unused_local_variable

      isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print("haha Cek error pesan$e");
    }
  }

  Future<bool> addOrderNurse({
    required String diskon,
    required String nurseId,
    required String serviceNurseId,
  }) async {
    isloading(true);
    // Map<String, String> headers = { "authorization": "Bearer ${Get.find<LoginMitraController>().token}"};
    // ignore: unused_local_variable
    // String idDocter = Get.find<LoginController>().doctorIdImage.value;
    const String url = "${MainUrl.urlApi}nurse/order";
    var request = http.MultipartRequest('POST', Uri.parse(url));
    // request.headers.addAll(headers);
    request.fields['customerPatientId'] =
        Get.find<ControllerLogin>().costumerId.value.toString();
    request.fields['nurseId'] = nurseId;
    request.fields['serviceId'] =
        Get.find<ControllerPayment>().serviceId.value.toString();
    request.fields['servicePriceNurseId'] = serviceNurseId;
    request.fields['name'] = namePasienC.text;
    request.fields['gender'] = selectedGenderPasien.value;
    request.fields['old'] = umurPasienC.text;
    request.fields['phoneNumber'] =
        Get.find<ControllerLogin>().noHp.value.toString();
    request.fields['districts'] = mapC.kecamatan.value;
    request.fields['city'] = mapC.city.value;
    request.fields['province'] = mapC.kabupaten.value;
    request.fields['country'] = mapC.negara.value;
    request.fields['lat'] = mapC.lat.value.toString();
    request.fields['long'] = mapC.long.value.toString();
    request.fields['address'] = mapC.alamatLengkap.value;
    request.fields['description'] = keluhanC.text;
    request.fields['status'] = '0';
    request.fields['discount'] = diskon;
    request.fields['total_price'] = totalPriceFix.value.toString();
    request.fields['postal_code'] = mapC.kodePos.value;
    request.fields['startDate'] =
        Get.find<PilihJadwalController>().startDateCustomerHomeVisit.value;
    request.fields['date'] = formatter.format(now.toLocal()).toString();
    request.files.add(await http.MultipartFile.fromPath('file', files.path));

    // if(postingan['status'] == 'failed'){
    //   print('error');
    // }

    // request.files
    //     .add(await http.MultipartFile.fromPath('file', imageFile.path));
    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    final orderNurse = json.decode(respStr.toString());
    log('UYEEEE$res');
    log('UYEEEE$respStr');
    log('UYEEEE OrderData${orderNurse['code']}');

    if (res.statusCode == 200) {
      log('COK COK COK');
      if (orderNurse['code'] != 200) {
        Get.defaultDialog(
            title: orderNurse['code'].toString(),
            middleText: orderNurse['message']);
      }
      isloading(false);
      log('UYEEEE custumerId ID = ${Get.find<ControllerLogin>().costumerId.value}');
      log('UYEEEE Nurse ID = $nurseId');
      log('UYEEEE ServiceId ID = ${Get.find<ControllerPayment>().serviceId.value}');
      log('UYEEEE SserviceNurse ID = $serviceNurseId');
      log('UYEEEE Nama Pasien = ${namePasienC.text}');
      log('UYEEEE Nama Gender Pasien = ${selectedGenderPasien.value}');
      log('UYEEEE Nama StartDate  = ${Get.find<PilihJadwalController>().startDateCustomerHomeVisit.value}');
      log('UYEEEE Nama Date  = ${formatter.format(now.toLocal())}');
      log('UYEEEE status ${res.statusCode}');
      log('UYEEEE code $respStr');
      log(' Masuukk  ${res.statusCode}');
      Get.find<ControllerPayment>().dataOrder.value = orderNurse['data'];
      Get.find<ControllerPayment>().codeOrder.value =
          Get.find<ControllerPayment>().dataOrder['code'];
      waitingC.orderId.value = Get.find<ControllerPayment>().dataOrder['id'];
      // ignore: invalid_use_of_protected_member
      log('UYEEEE OrderData${Get.find<ControllerPayment>().dataOrder.value}');
      log('UYEEEE codeOrder${Get.find<ControllerPayment>().codeOrder.value}');
      log('MASUK COK ${Get.find<ControllerPayment>().dataOrder['id']}');

      // setCurrentUser(respStr);
      // currentUser = authModelFromJson(respStr);
      return true;
    } else {
      return false;
    }
  }

  void pickerFilesImage(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("Photo"),
                onTap: () async {
                  // if (await Permission.storage.request().isGranted) {
                  // }
                  takePhoto(ImageSource.gallery);
                  Get.back();
                  // takePhoto(ImageSource.gallery);
                  // Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text("Camera"),
                onTap: () {
                  takePhoto(ImageSource.camera);
                  Get.back();
                },
              )
            ],
          );
        });
  }
}
