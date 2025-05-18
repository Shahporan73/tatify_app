// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tatify_app/data/local_database/local_data_base.dart';
import 'package:tatify_app/data/utils/const_value.dart';
import 'package:tatify_app/view/splash/view/splash_screen.dart';
import 'package:tatify_app/view/user/user_home/view/home_dashboard.dart';
import 'package:tatify_app/view/vendor/vendor_home/views/vendor_home_dashboard.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();


  // token
  if (kDebugMode) {
    print('accessToken main 2 ${await LocalStorage.getData(key: accessToken)}');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Set the status bar style here
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return GetMaterialApp(
      title: 'Testy point restaurant app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LocalStorage.getData(key: accessToken) != null? (
      LocalStorage.getData(key: userType) == 'vendor' ? VendorHomeDashboard() : HomeDashboard()
      ) : SplashScreen(),

      // home: VendorHomeDashboard(),
    );
  }
}
