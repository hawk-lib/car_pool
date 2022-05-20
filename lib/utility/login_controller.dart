import 'package:car_pool/screens/profile_setup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController{
  var _googleSignIn = GoogleSignIn();
  var googleAccount =Rx<GoogleSignInAccount?>(null);



  login() async{
    googleAccount.value= await _googleSignIn.signIn();

    if(googleAccount.value==null) {
      return true;
    }
    return false;
  }
}