import 'package:get/get.dart';

class BishopScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BishopScreenBinding>(() => BishopScreenBinding());
  }
}