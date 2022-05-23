

import 'package:car_pool/screens/authentication_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: buildLoginButton(context),
        ),
      ),
    );
  }
  FloatingActionButton buildLoginButton(BuildContext context) {

    return FloatingActionButton.extended(onPressed: (){
      logout();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthenticationScreen()));

    },
        label: const Text("Book Ride"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black);
  }

  Future<void> logout() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(preferences.getString("email"));
    print(preferences.getString("uid"));
    print(preferences.getString("photoUrl"));
    print(preferences.getString("displayName"));
    print(preferences.getString("mobile_number"));

    preferences.clear();
    print(preferences.getString("email"));
    print(preferences.getString("uid"));
    print(preferences.getString("photoUrl"));
    print(preferences.getString("displayName"));
    print(preferences.getString("mobile_number"));
  }

}