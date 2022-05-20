import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utility/login_controller.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final controler = Get.put(LoginController());
final TextEditingController _phoneNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                  children: [
                    TextFormField(
                        controller: _phoneNumber,
                        decoration: const InputDecoration(
                            hintText: "Phone Number",
                            prefix: Padding(padding: EdgeInsets.all(5),
                              child: Text("+91"),)
                        ),
                        maxLength: 10,
                        keyboardType: TextInputType.number


                    ),
                    ElevatedButton (onPressed: () {

                      sendOtp();


                    }, child: Text("Submit")),

                    TextFormField(
                        decoration: const InputDecoration(
                            hintText: "OTP",
                            prefix: Padding(padding: EdgeInsets.all(5),
                            )
                        ),
                        maxLength: 6,
                        keyboardType: TextInputType.number


                    ),
                    ElevatedButton(onPressed: () {
                      print("successful");
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ProfileSetupScreen()));
                    }, child: Text("Verify")),
                  ]
              ),

            ),

          ],


        ),
      ),
    );
  }

  void sendOtp() async{
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "$_phoneNumber",
        verificationCompleted: (PhoneAuthCredential credential) {},
    verificationFailed: (FirebaseAuthException e) {},
    codeSent: (String verificationId, int? resendToken) {
          print("sent");
    },
    codeAutoRetrievalTimeout: (String verificationId) {}
    );
  }
}


