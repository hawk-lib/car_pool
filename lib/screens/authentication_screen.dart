
import 'package:car_pool/screens/profile_setup_screen.dart';
import 'package:car_pool/utility/appPreferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'home_screen.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.only(bottom: 100),
          decoration: const BoxDecoration(
            color: Colors.lightBlue,
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: "icon",
                      child: Container(
                          height: 200,
                          width: 200,
                          child: Image.asset("assets/icons/ic_launcher.png")
                      ),
                    ),
                  ],
                ),

                FloatingActionButton.extended(onPressed: () {
                  login();
                },
                    icon: Image.asset("assets/icons/google.png",
                      height: 32,
                      width: 32,
                    ),
                    label: const Text("google sign in"),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black),
              ],
            ),
          ),
        ),
    );
  }

  login() async{
    GoogleSignInAccount result;
    GoogleSignIn googleSignIn = GoogleSignIn();
    EasyLoading.show(status: 'loading');

    try{
      result = (await googleSignIn.signIn())!;
      final userData = await result.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: userData.accessToken, idToken: userData.idToken
      );
      FirebaseAuth mAuth = FirebaseAuth.instance;
      await mAuth.signInWithCredential(credential);
      String? phoneNumber = mAuth.currentUser!.phoneNumber;

      /*FirebaseDatabase db = FirebaseDatabase.instance;
      DatabaseReference ref = db.ref("users").child(userId);*/
      AppPreferences.setEmail(result.email);
      AppPreferences.setPhotoUrl(result.photoUrl!);
      AppPreferences.setDisplayName(result.displayName!);
      AppPreferences.setUID(mAuth.currentUser!.uid);


      if(phoneNumber != null){
        AppPreferences.setMobileNumber(phoneNumber);
        EasyLoading.dismiss();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      }else{
        EasyLoading.dismiss();
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileSetupScreen()));

      }
    }catch (error){
      snackBar(error.toString(), Colors.black);
    }
  }

  void snackBar(String m, Color color){
    showTopSnackBar(
      context,
      CustomSnackBar.error(
        message: m, backgroundColor: color,
      ),
    );
  }


  @override
  void dispose() {
    // TODO: implement dispose
    if(EasyLoading.isShow){
      EasyLoading.dismiss();
    }
    super.dispose();
  }

}
