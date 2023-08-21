import 'package:get/get.dart';

class HistoryScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryScreenBinding>(() => HistoryScreenBinding());
  }
}