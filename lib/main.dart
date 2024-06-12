import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tugas/firebase_options.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
            bodyMedium: TextStyle(color: Colors.grey[700], fontSize: 17)),
        appBarTheme: AppBarTheme(
            foregroundColor: Colors.lightGreen[200],
            backgroundColor: Colors.lightGreen[700],
            centerTitle: true,
            titleTextStyle: TextStyle(
                color: Colors.grey[200],
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        iconTheme: IconThemeData(
          color: Colors.white, // Set the back button color to white
        ),
        primaryColor: Colors.grey[300],
      ),
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
