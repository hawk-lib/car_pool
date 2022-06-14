

import 'package:car_pool/screens/profile_setup_screen.dart';
import 'package:car_pool/screens/travel_history_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child:  buildLoginButton()
        )
        ,


      ),
    );
  }

  FloatingActionButton buildLoginButton() {
    return FloatingActionButton.extended(onPressed: () {
      login();
    },
        icon: Image.asset("assets/icons/google.png",
          height: 32,
          width: 32,
        ),
        label: const Text("google sign in"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black);

  }
  login() async{
    GoogleSignInAccount result;
    GoogleSignIn googleSignIn = GoogleSignIn();
    try{
      result = (await googleSignIn.signIn())!;
      final userData = await result.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: userData.accessToken, idToken: userData.idToken
      );
      FirebaseAuth mAuth = FirebaseAuth.instance;
      await mAuth.signInWithCredential(credential);
      String userId = mAuth.currentUser!.uid;
      String? phoneNumber = mAuth.currentUser!.phoneNumber;

      /*FirebaseDatabase db = FirebaseDatabase.instance;
      DatabaseReference ref = db.ref("users").child(userId);*/

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', result.email);
      prefs.setString('photoUrl', result.photoUrl!);
      prefs.setString('displayName', result.displayName!);
      prefs.setString('uid', userId);
      if(phoneNumber != null){
        prefs.setString('mobile_number', phoneNumber);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileSetupScreen()));
      }


/*
      final snapshot = await ref.child('users/$userId').get();
      if (snapshot.exists) {
        print(snapshot.value);
        return 3;
      } else {
        print('No data available.');
        return 2;
      }*/

    }catch (error){
      print(error);
    }
  }
}
