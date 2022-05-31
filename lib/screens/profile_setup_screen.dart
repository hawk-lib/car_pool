import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';


class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _otp = TextEditingController();

  String email = "";
  String photoUrl = "https://lh3.googleusercontent.com/a/AATXAJx0D6NV1PCZ9r_U6yWNLWWVd2vALY2PfVKuuu8J=s96-c";
  String displayName = "";
  late String mVerificationId;




  Future<SharedPreferences> getData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  @override
  void initState() {
    getData().then((prefs) {
      setState(() {
        email = prefs.getString("email")!;
        photoUrl = prefs.getString("photoUrl")!;
        displayName = prefs.getString("displayName")!;
      });
    });

    super.initState();
  }


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
                  .network(photoUrl)
                  .image,
              radius: 50,
            ),
            Text(displayName,
              style: const TextStyle(color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  wordSpacing: 3),),
            Text(email),
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
                    ElevatedButton (onPressed: () async {
                      String phoneNumber = "+91${_phoneNumber.text}";
                      await sendOtp(phoneNumber);


                    }, child: Text("Submit")),

                    TextFormField(
                      controller: _otp,
                        decoration: const InputDecoration(
                            hintText: "OTP",
                            prefix: Padding(padding: EdgeInsets.all(5),
                            )
                        ),
                        maxLength: 6,
                        keyboardType: TextInputType.number


                    ),
                    ElevatedButton(onPressed: () async{
                      
                      await FirebaseAuth.instance.currentUser?.linkWithCredential(PhoneAuthProvider.credential(verificationId: mVerificationId, smsCode: _otp.text));
                      SharedPreferences preferences = await SharedPreferences.getInstance();
                      preferences.setString("mobile_number", "+91${_phoneNumber.text}");
                      print("successful");
                      Map <String, dynamic> data={
                        "Mobile Number": preferences.getString("mobile_number"),
                        "Name": preferences.getString("displayName"),
                        "Email": preferences.getString("email"),
                      };
                      FirebaseFirestore.instance.collection("User_Data").doc(preferences.getString("uid")).set(data);
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => HomeScreen()));

                    }, child: Text("Verify")),
                  ]
              ),

            ),

          ],


        ),
      ),
    );
  }

  Future<void> sendOtp(String phoneNumber) async{
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          setState(() {
            _otp.text = credential.smsCode!;
          });
          await FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
        },
    verificationFailed: (FirebaseAuthException e) {},
    codeSent: (String verificationId, int? resendToken) {
          setState(() {
            mVerificationId = verificationId;
          });
          print("sent");
    },
    codeAutoRetrievalTimeout: (String verificationId) {}
    );
  }
}


