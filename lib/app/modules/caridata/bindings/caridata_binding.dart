import 'package:get/get.dart';

import '../controllers/caridata_controller.dart';

class CaridataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CaridataController>(
      () => CaridataController(),
    );
  }
}
