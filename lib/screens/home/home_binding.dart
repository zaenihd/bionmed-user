import 'package:get/get.dart';

class HomeScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeScreenBinding>(() => HomeScreenBinding());
  }
}
