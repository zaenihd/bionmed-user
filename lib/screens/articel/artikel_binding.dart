import 'package:get/get.dart';

class ArtikelScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArtikelScreenBinding>(() => ArtikelScreenBinding());
  }
}
