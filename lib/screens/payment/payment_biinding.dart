import 'package:get/get.dart';

class PaymentScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentScreenBinding>(() => PaymentScreenBinding());
  }
}
