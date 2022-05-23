

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
  final TextEditingController _phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Obx(() {
              return buildLoginButton();
            })


        )
        ,


      ),
    );
  }

  FloatingActionButton buildLoginButton() {

    return FloatingActionButton.extended(onPressed: () {
      login();

    },
        label: const Text("google sign in"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black);
  }
  login() async{
    String displayName = "";
    String email="";
    String photoUrl="";
    GoogleSignInAccount result;
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try{
      result = (await _googleSignIn.signIn())!;
      if(result==null){
        return 1;
      }
      final userData = await result.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: userData.accessToken, idToken: userData.idToken
      );
      FirebaseAuth mAuth = FirebaseAuth.instance;
      await mAuth.signInWithCredential(credential);
      String userId = mAuth.currentUser!.uid;

      FirebaseDatabase db = FirebaseDatabase.instance;
      DatabaseReference ref = db.ref("users").child(userId);
      displayName = result.displayName!;
      email = result.email;
      photoUrl = result.photoUrl!;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email);
      prefs.setString('photoUrl', photoUrl);
      prefs.setString('displayName', displayName);
      prefs.setString('uid', userId);



      final snapshot = await ref.child('users/$userId').get();
      if (snapshot.exists) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        print(snapshot.value);
        return 3;
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileSetupScreen()));
        print('No data available.');
        return 2;
      }

    }catch (error){
      print(error);
    }

    return false;
  }
}
