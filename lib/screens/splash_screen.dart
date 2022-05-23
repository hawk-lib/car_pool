import 'dart:async';
import 'package:car_pool/screens/profile_setup_screen.dart';
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

  late SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    init();
    if(FirebaseAuth.instance.currentUser!=null){
      if(preferences.containsKey("mobile_number")){
        Timer(const Duration(seconds: 2),
                ()=>Navigator.pushReplacement(context,
                MaterialPageRoute(builder:
                    (context) => const HomeScreen()
                )
            )
        );
      } else {
        Timer(const Duration(seconds: 2),
                ()=>Navigator.pushReplacement(context,
                MaterialPageRoute(builder:
                    (context) => const ProfileSetupScreen()
                )
            )
        );
      }
    }else{
      if(preferences.containsKey("email")) {
        logout();
      }
      Timer(const Duration(seconds: 2),
              ()=>Navigator.pushReplacement(context,
              MaterialPageRoute(builder:
                  (context) => const AuthenticationScreen()
              )
          )
      );
    }
  }

  init() async {
    preferences = await SharedPreferences.getInstance();
  }

  logout() async {
    await GoogleSignIn().signOut();
    preferences.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.yellow,
        child:FlutterLogo(size:MediaQuery.of(context).size.height)
    );
  }
}