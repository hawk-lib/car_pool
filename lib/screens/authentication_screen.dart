

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


  Scaffold buildProfileView() {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          CircleAvatar(
            backgroundImage: Image
                .network(controler.googleAccount.value?.photoUrl ?? '')
                .image,
            radius: 50,
          ),
          Text(controler.googleAccount.value?.displayName ?? '',
            style: const TextStyle(color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                wordSpacing: 3),),
          Text(controler.googleAccount.value?.email ?? ''),
          const SizedBox(height: 20),
          const Text("enter the mob number"),
          Container(
            width: 200,
            height: 200,
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                TextFormField(
                    controller: _phoneNumber,
                    decoration: const InputDecoration(
                        hintText: "phone number",
                        prefix: Padding(padding: EdgeInsets.all(5),
                          child: Text("+91"),)
                    ),
                    maxLength: 10,
                    keyboardType: TextInputType.number


                ),
                ElevatedButton(onPressed: () {
                  print("successful");
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ProfileSetupScreen()));
                }, child: Text("ok"))
              ],
            ),

          ),

        ],


      ),
    );
  }
}
