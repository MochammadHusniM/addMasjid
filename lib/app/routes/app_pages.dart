import 'package:get/get.dart';

import '../modules/caridata/views/caridata_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/listmasjid/bindings/listmasjid_binding.dart';
import '../modules/listmasjid/views/listmasjid_view.dart';
import '../modules/report/bindings/report_binding.dart';
import '../modules/report/views/report_view.dart';
import '../modules/tambahdata/bindings/tambahdata_binding.dart';
import '../modules/tambahdata/views/tambahdata_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAHDATA,
      page: () => TambahdataView(),
      binding: TambahdataBinding(),
    ),
    GetPage(
      name: _Paths.LISTMASJID,
      page: () => ListmasjidView(),
      binding: ListmasjidBinding(),
    ),
    GetPage(
      name: _Paths.REPORT,
      page: () => ReportView(),
      binding: ReportBinding(),
    ),
  ];
}
