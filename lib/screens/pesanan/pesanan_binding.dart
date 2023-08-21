import 'package:get/get.dart';

class PesananScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PesananScreenBinding>(() => PesananScreenBinding());
  }
}
