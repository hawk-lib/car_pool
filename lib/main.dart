import 'package:car_pool/screens/authentication_screen.dart';
import 'package:car_pool/screens/home_screen.dart';
import 'package:car_pool/screens/profile_setup_screen.dart';
import 'package:car_pool/screens/ride_booking_screen.dart';
import 'package:car_pool/screens/ride_creating_screen.dart';
import 'package:car_pool/screens/splash_screen.dart';
import 'package:car_pool/screens/travel_history_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => const SplashScreen(),
        "/authenticationRoute": (context) => const AuthenticationScreen(),
        "/profileSetupRoute": (context) => const ProfileSetupScreen(),
        "/homeRoute": (context) => const HomeScreen(),
        "/rideBookingRoute": (context) => const RideBookScreen(),
        "/rideCreatingRoute": (context) => const RideCreateScreen(),
        "/travelHistoryRoute": (context) => const TravelHistoryScreen(),
      },
    );
  }
}
