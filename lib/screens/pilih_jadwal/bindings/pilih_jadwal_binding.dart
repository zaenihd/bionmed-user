import 'package:get/get.dart';

import '../controllers/pilih_jadwal_controller.dart';

class PilihJadwalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PilihJadwalController>(
      () => PilihJadwalController(),
    );
  }
}
