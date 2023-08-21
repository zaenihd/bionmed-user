import 'package:get/get.dart';

class RegisterScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterScreenBinding>(() => RegisterScreenBinding());
  }
  
}