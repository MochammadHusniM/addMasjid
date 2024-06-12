import 'package:get/get.dart';

import '../controllers/listmasjid_controller.dart';

class ListmasjidBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListmasjidController>(
      () => ListmasjidController(),
    );
  }
}
