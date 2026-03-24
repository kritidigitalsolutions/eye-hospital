import 'package:eye_hospital/routes/app_pages.dart';
import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/hive_service/userdetail.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp();
  print("Firebase connected: ${Firebase.apps.isNotEmpty}");

  Hive.registerAdapter(UserDetailsAdapter());
  await Hive.openBox<UserDetails>('userBox');
  await Hive.openBox('addressBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}
