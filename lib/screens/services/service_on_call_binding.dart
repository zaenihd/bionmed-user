import 'package:get/get.dart';

class ServiceOnCallBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceOnCallBinding>(() => ServiceOnCallBinding());
  }
}