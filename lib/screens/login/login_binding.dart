import 'package:get/get.dart';

class LoginScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginScreenBinding>(() => LoginScreenBinding());
  }
  
}