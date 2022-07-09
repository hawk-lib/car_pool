import 'dart:async';
import 'package:car_pool/screens/profile_setup_screen.dart';
import 'package:car_pool/utility/appPreferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'authentication_screen.dart';
import 'home_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}
class SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    if (FirebaseAuth.instance.currentUser != null) {
      if (AppPreferences.containsKey("mobile_number")) {
        Timer(const Duration(seconds: 2),
                () =>
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder:
                        (context) => const HomeScreen()
                    )
                )
        );
      } else {
        Timer(const Duration(seconds: 2),
                () =>
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder:
                        (context) => const ProfileSetupScreen()
                    )
                )
        );
      }
    } else {
      if (AppPreferences.containsKey("email")) {
        await GoogleSignIn().signOut();
        AppPreferences.clear();
      }
      Timer(const Duration(seconds: 2),
              () =>
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder:
                      (context) => const AuthenticationScreen()
                  )
              )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.lightBlue,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 150,
                  width: 150,
                  child: Image.asset("assets/icons/ic_launcher.png")
              ),
              Text(
                "Car Pool",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 3,
                  wordSpacing: 4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}