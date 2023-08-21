import 'package:get/get.dart';

class ProfileScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileScreenBinding>(() => ProfileScreenBinding());
  }
}