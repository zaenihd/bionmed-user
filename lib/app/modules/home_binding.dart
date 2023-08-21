import 'package:bionmed_app/app/modules/home_controller.dart';
import 'package:bionmed_app/screens/login/controller_login.dart';
import 'package:bionmed_app/screens/profile/controller_profile.dart';
import 'package:bionmed_app/screens/register/register_controller.dart';
import 'package:get/get.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeControllerDua>(HomeControllerDua());
    Get.put<ControllerLogin>(ControllerLogin());
    Get.put<RegisterController>(RegisterController());
    // Get.put<SplashScreenController>(SplashScreenController());
    Get.put<ControllerProfile>(ControllerProfile());

  }
}
