

import 'package:car_pool/screens/profile_setup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utility/login_controller.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final controler = Get.put(LoginController());
  final TextEditingController _phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Obx(() {
              if (controler.googleAccount.value == null) {
                return buildLoginButton();
              } else {
                return buildProfileView();
              }
            })


        )
        ,


      ),
    );
  }

  FloatingActionButton buildLoginButton() {
    return FloatingActionButton.extended(onPressed: () {
      controler.login();
    },
        label: const Text("google sign in"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black);
  }


   buildProfileView() {
     Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileSetupScreen()));
  }
}
