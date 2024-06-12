import 'package:get/get.dart';

import '../controllers/tambahdata_controller.dart';

class TambahdataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahdataController>(
      () => TambahdataController(),
    );
  }
}
