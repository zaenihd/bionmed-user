import 'package:bionmed_app/screens/payment/controller_payment.dart';
import 'package:bionmed_app/screens/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController>(() => SplashScreenController());
    Get.lazyPut<ControllerPayment>(() => ControllerPayment());
  }
}
