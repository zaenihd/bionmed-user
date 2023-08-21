import 'package:get/get.dart';

class OnboardingScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingScreenBinding>(() => OnboardingScreenBinding());
  }
}
