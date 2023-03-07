import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rs/src/global/controllers/app.dart';
import 'package:rs/src/global/controllers/courses.dart';
import 'package:rs/src/global/models/courses/course.dart';
import 'package:rs/src/global/themes/app_theme.dart';
import 'package:rs/src/modules/splash/splash_screen.dart';
import 'package:rs/src/modules/timer/controllers/timer_controller.dart';
import 'lang.dart';
import 'src/global/controllers/auth.dart';

Future<void> secureScreen() async {
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  secureScreen();
  await Hive.initFlutter();
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  AppBinding().dependencies();
  AuthBinding().dependencies();
  CourseBinding().dependencies();
  TimerBinding().dependencies();
  MobileAds.instance.initialize();
  Hive.registerAdapter(CourseAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Languages(),
      locale: const Locale('ar'),
      fallbackLocale: const Locale('ar', ''),
      title: 'RS',
      theme: appTheme(),
      home: Splash(),
    );
  }
}
