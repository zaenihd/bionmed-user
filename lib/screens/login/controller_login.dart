// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'dart:developer';

import 'package:bionmed_app/screens/home/api_home.dart';
import 'package:bionmed_app/screens/home/home.dart';
import 'package:bionmed_app/screens/home/home_controller.dart';
import 'package:bionmed_app/screens/login/api_login.dart';
import 'package:bionmed_app/screens/login/disclaimer.dart';
import 'package:bionmed_app/screens/pesanan/controller_pesanan.dart';
import 'package:bionmed_app/screens/register/register_controller.dart';
import 'package:bionmed_app/screens/register/register_screen.dart';
import 'package:bionmed_app/screens/articel/controller_articel.dart';
import 'package:bionmed_app/widgets/other/show_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ControllerLogin extends GetxController {
  RxBool isloading = false.obs;
  RxBool rememberme = false.obs;
  RxString name = "".obs;
  RxString lat = "".obs;
  RxString long = "".obs;
  RxString noHp = "".obs;
  RxString alamat = "".obs;
  RxString imagePhoto = "".obs;
  RxString locality = "".obs;
  RxString tanggalLahir = "".obs;
  RxList dataService = [].obs;
  RxList dataSplash = [].obs;
  RxList dataArticel = [].obs;
  RxList dataSpecialist = [].obs;
  RxList dataHospital = [].obs;
  RxList dataDoctor = [].obs;
  RxList priceService = [].obs;
  RxList doctorByService = [].obs;
  RxList doctorBySpesialis = [].obs;
  RxList doctorSchedul = [].obs;
  RxList doctorExperience = [].obs;
  RxList doctorEducation = [].obs;
  RxList doctorHospital = [].obs;
  RxList dataNotif = [].obs;
  RxInt activeNotif = 0.obs;
  RxInt currentIndex = 0.obs;
  RxInt costumerId = 0.obs;
  RxList dataBanner = [].obs;
  RxInt statusOrder = 0.obs;

  // ignore: prefer_typing_uninitialized_variables
  var dataUser;
  var dataDoctorDetail = {}.obs;
  RxInt doctorIdDetail = 0.obs;
  final cHome = Get.put(HomeController());
  final cTransaksi = Get.put(ControllerArticel());
  final cPesanan = Get.put(ControllerPesanan());
  final cHomes = Get.put(HomeController());

  Future<dynamic> loginApps(String phoneNumber) async {
    isloading(true);
    final box = GetStorage();
    if (phoneNumber.isNotEmpty) {
      var value = await ApiLogin().loginApps(phoneNumber: phoneNumber);
      isloading(false);
      if (value['code'] == 200) {
        cHome.dataUser = value['data'];
        dataUser = value['data'];
        costumerId.value = value['data']['customer']['id'];
        name.value = value['data']['customer']['name'];
        noHp.value = phoneNumber;
        alamat.value = value['data']['customer']['address'];
        tanggalLahir.value = value['data']['customer']['brithdayDate'];
        log(value.toString());

        // ignore: prefer_if_null_operators
        imagePhoto.value = value['data']['customer']['image'] != null
            ? value['data']['customer']['image']
            : "";

        String? tokens = await FirebaseMessaging.instance.getToken();
        ApiLogin()
            .registerTokenFirebase(tokens!, value['data']['id'].toString());

        box.write('phone', phoneNumber);
        // box.write('remem', phoneNumber);

        box.write('id', value['data']['customer']['id'].toString());
        box.write('userId', value['data']['customer']['userId'].toString());
        box.write('token', value['accessToken']);
        cPesanan.getOrder(status: 0);
        getNotif();
        getSpecialist();
        // ignore: prefer_const_constructors
        var setuju = await box.read('rememberme');
        if (setuju == true) {
          // ignore: prefer_const_constructors
          Get.offAll(() => Home(
              indexPage: 0,
            ));
          // Get.toNamed(Routes.BOTTOM_NAVIGATION);
        } else {
          print('zen ' + setuju.toString());
          Get.to(() => Disclamer());
        }
        
      } else {
        showPopUp(
            onTap: () {
              Get.back();
            },
            imageAction: 'assets/json/eror.json',
            description: "Nomer tidak ditemukan\n Daftarkan nomer anda!",
            onPress: () {
              Get.back();
              Get.find<RegisterController>().phoneNumber.value = phoneNumber;
              Get.to(() => const RegisterScreen());
            });
      }
    } else {
      isloading(false);
      Get.offAllNamed('/login_screen');
    }
  }

  Future<dynamic> getNotif() async {
    isloading(true);
    var value = await ApiHome().getNotif();
    if (value['code'] == 200) {
      dataNotif.value = value['data'];
      activeNotif.value =
          dataNotif.where((d) => d['status'] == 1).toList().length;
    }
    isloading(false);
  }

  Future<dynamic> getService() async {
    var value = await ApiHome().getService();
    if (value['code'] == 200) {
      dataService.value = value['data'];
    }
  }

  Future<dynamic> getSplash() async {
    var value = await ApiHome().getSplash();
    if (value['code'] == 200) {
      dataSplash.value = value['data'];
    }
  }

  Future<dynamic> getArticel() async {
    var value = await ApiHome().getArticel();
    if (value['code'] == 200) {
      dataArticel.value = value['data'];
    }
  }

  Future<dynamic> getSpecialist() async {
    var value = await ApiHome().getSpecialist();
    if (value['code'] == 200) {
      dataSpecialist.value = value['data'];
    }
  }

  Future<dynamic> getHospital() async {
    var value = await ApiHome().getHospital();
    if (value['code'] == 200) {
      dataHospital.value = value['data'];
    }
  }

  Future<dynamic> getDoctor() async {
    var value = await ApiHome().getDoctor();
    print("cek getDoctor: " + value.toString());
    if (value['code'] == 200) {
      dataDoctor.value = value['data'];
    }
  }

  Future<dynamic> getDoctorDetail({required String id}) async {
    print("masuk " + id.toString());
    isloading(true);
    var value = await ApiHome().getDoctorDetail(id: id);
    print("cek getDoctordetail : " + value.toString());
    if (value['code'] == 200) {
      dataDoctorDetail.value = value['data'];
      doctorIdDetail.value = value['data']['id'];
      doctorSchedul.value = value['data']['doctor_schedules'];
      doctorEducation.value = value['data']['doctor_educations'];
      doctorExperience.value = value['data']['doctor_experiences'];
      // doctorHospital.value = value['data']['hospital_doctors'] ?? "";
    }
    isloading(false);
  }

  Future<dynamic> getPriceByServiceId(
      {required String id, required String idDoctor}) async {
    print("masuk getPriceByServiceId ");
    var value = await ApiHome().getPriceByServiceId(id: id, idDoctor: idDoctor);
    print("cek getPriceByServiceId : " + value.toString());
    if (value['code'] == 200) {
      priceService.value = value['data'];
    }
  }

  Future<dynamic> getDoctorByServiceId(
      {required String id,
      String? day,
      String? jam,
      String? spesialist}) async {
    isloading(true);
    var value =
        await ApiHome().getDoctorByServiceId(id: id, day: day!, jam: jam!);
    isloading(false);

    if (value['code'] == 200) {
      doctorByService.value = value['data'];
    }
  }

  Future<dynamic> getDoctorBySpesialisId({required String id}) async {
    print("masuk ");
    var value = await ApiHome().getDoctorBySpesialisId(id: id);
    if (value['code'] == 200) {
      doctorBySpesialis.value = value['data'];
    }
  }

  Future<dynamic> getBanner() async {
    var value = await ApiHome().getBanner();
    print("cek getBanner: " + value.toString());
    if (value['code'] == 200) {
      dataBanner.value = value['data'];
      // ignore: invalid_use_of_protected_member
      print('hihi = ' + dataBanner.value.toString() );
    }
  }
}
