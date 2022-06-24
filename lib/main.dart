import 'dart:async';

import 'package:car_pool/screens/authentication_screen.dart';
import 'package:car_pool/screens/home_screen.dart';
import 'package:car_pool/screens/profile_setup_screen.dart';
import 'package:car_pool/screens/ride_booking_screen.dart';
import 'package:car_pool/screens/ride_creating_screen.dart';
import 'package:car_pool/screens/splash_screen.dart';
import 'package:car_pool/screens/travel_history_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

class MyApp extends StatefulWidget {
   MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   Timer? _timer;

  // This widget is the root of your application.


  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    EasyLoading.showSuccess('Use in initState');
    // EasyLoading.removeCallbacks();
  }



  Widget build(BuildContext context) {

    return MaterialApp(

      routes: {
        "/": (context) => const SplashScreen(),
        "/authenticationRoute": (context) => const AuthenticationScreen(),
        "/profileSetupRoute": (context) => const ProfileSetupScreen(),
        "/homeRoute": (context) => const HomeScreen(),
        //"/rideBookingRoute": (context) => const RideBookScreen(),
        "/rideCreatingRoute": (context) => const RideCreateScreen(),
        "/travelHistoryRoute": (context) => const TravelHistoryScreen(),
      },
      builder: EasyLoading.init(),
    );
  }
}
