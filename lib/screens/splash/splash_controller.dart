import 'package:bionmed_app/screens/login/controller_login.dart';
import 'package:bionmed_app/screens/onboarding/onboarding_screen.dart';
import 'package:bionmed_app/screens/payment/controller_payment.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// import 'package:geocoder/geocoder.dart';
// import 'package:flutter/services.dart';
// import 'package:location/location.dart';

class SplashScreenController extends GetxController {
  final box = GetStorage();
  final cLogin = Get.find<ControllerLogin>();
  @override
  void onInit() async {
    Get.put(ControllerPayment());
    var phone = await box.read('phone');
    // ignore: unused_local_variable
    var setuju = await box.read('dontShowAgain');

    await Get.find<ControllerLogin>().getService();
    // await Get.find<ControllerLogin>().getSplash();
    await Get.find<ControllerLogin>().getArticel();
    await Get.find<ControllerLogin>().getSpecialist();
    await Get.find<ControllerLogin>().getDoctor();
    await Get.find<ControllerLogin>().getHospital();
    await Get.find<ControllerLogin>().getBanner();
    // getLocation();
    
    if (phone == null) {
      Future.delayed(const Duration(milliseconds: 1500))
          .then((value) => Get.to(() => OnboardingScreen()));
    }
    if (phone != null) {
      cLogin.loginApps(phone);
    }
    
    super.onInit();
  }

  void getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Get.find<ControllerLogin>().locality.value = placemarks[0].locality!;
    Get.find<ControllerPayment>().lat.value = position.latitude;
    Get.find<ControllerPayment>().long.value = position.longitude;
    Get.find<ControllerPayment>().districts.value = placemarks[0].locality!;
    Get.find<ControllerPayment>().city.value = placemarks[0].subLocality!;
    Get.find<ControllerPayment>().country.value = placemarks[0].country!;
    Get.find<ControllerPayment>().province.value =
        placemarks[0].subAdministrativeArea!;
  }
}
