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


  @override
  void initState(){
    init();
    super.initState();
  }

  init() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
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
        await GoogleSignIn().signOut();
        preferences.clear();
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

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child:Image.asset("assets/icons/google.png",height: 100,width: 100,)
    );
  }
}