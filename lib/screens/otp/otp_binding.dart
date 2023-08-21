import 'package:get/get.dart';

class OtpScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpScreenBinding>(() => OtpScreenBinding());
  }
}