import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tugas/app/routes/app_pages.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          title: Text(
            'Halaman Utama',
            style: TextStyle(color: Colors.grey[300]),
          ),
        ),
        body: GridView.builder(
          padding: EdgeInsets.all(10),
          itemCount: 3,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
          itemBuilder: (context, index) {
            late String title = 'Default Title';
            late IconData icon;
            late VoidCallback onTap = () => Get.toNamed(Routes.HOME);

            switch (index) {
              case 0:
                title = 'Tambah Masjid';
                icon = FlutterIslamicIcons.mosque;
                onTap = () => Get.toNamed(Routes.TAMBAHDATA);

              case 1:
                title = 'List';
                icon = Icons.update;
                onTap = () => Get.toNamed(Routes.LISTMASJID);

              case 2:
                title = 'Report';
                icon = Icons.align_vertical_bottom;
                onTap = () => Get.toNamed(Routes.REPORT);
                break;
              default:
            }
            return Material(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: Icon(
                        icon,
                        size: 50,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                          color: Colors.grey[600], fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
