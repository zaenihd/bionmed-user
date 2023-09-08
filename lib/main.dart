import 'dart:developer';
import 'dart:io';

import 'package:bionmed_app/app/modules/home_binding.dart';
import 'package:bionmed_app/app/routes/app_pages.dart';
import 'package:bionmed_app/constant/utils.dart';
import 'package:bionmed_app/screens/disclamerSplash/disclamer.dart';
import 'package:bionmed_app/screens/splash/splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:awesome_notifications/awesome_notifications.dart';

import 'certificate_api.dart';


void main() async {
  // ignore: unnecessary_new
  HttpOverrides.global = new MyHttpOverrides();

  await ScreenUtil.ensureScreenSize();
  await GetStorage.init();
  await Firebase.initializeApp();
  await initializeDateFormatting('id_ID', null);
  tz.initializeTimeZones();
  var detroit = tz.getLocation('Asia/Makassar');

  var now = tz.TZDateTime.now(detroit);
  log(now.toString());
    AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests'),
  ],
  
  debug: true);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  WidgetsFlutterBinding.ensureInitialized();
  ZIMKit().init(
    appID: 1119939175, // your appid
    appSign: Utils().getAppSign, // your appSign
  );
  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, ctx) {
        final box = GetStorage();
        // ignore: unused_local_variable
        var setuju = box.read('dontShowAgain');
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Bionmed',
          home: setuju == null ? DisclamerSplash() : const SplashScreen(),
          // home:  ListHospital(),
          theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Ubuntu'),
          initialBinding: RootBinding(),
          getPages: AppPages.pages,
        );
      },
    );
  }
}
