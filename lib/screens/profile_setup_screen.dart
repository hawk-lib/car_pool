import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
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
  bool _isPhoneDisabled = false;
  bool _isVerifyDisabled = true;





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
      body:
         SafeArea(
           child: Container(
             height: double.infinity,
             decoration: BoxDecoration(
                 image: DecorationImage(
                     image: AssetImage("assets/background/ballon.jpeg"),
                     fit: BoxFit.cover
                 )
             ),
             child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                    decoration:  BoxDecoration(
                        borderRadius: new BorderRadius.only(
                          bottomLeft: const Radius.circular(120.0),
                          bottomRight: const Radius.circular(120.0),

                        ),
                     // gradient: LinearGradient(
                        //  begin: Alignment.bottomLeft,
                        //  end: Alignment.topRight,
                        //  colors: [Color(0xFF00E676), Color(0xFFB3F6CA)]),
                      color: Colors.greenAccent.withOpacity(0.3),


                    ),
                  child:Column(

                    children:[
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
                  ],
                  )
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                        children: [
                          AbsorbPointer(
                            absorbing: _isPhoneDisabled,
                            child: Card(
                              color: Colors.transparent,
                              margin: EdgeInsets.only(left: 10,right: 10),
                              elevation: 1,
                              shadowColor: Colors.tealAccent.withOpacity(0.2),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.transparent,
                                      blurRadius: 25.0, // soften the shadow
                                      spreadRadius: 5.0, //extend the shadow
                                      offset: Offset(
                                        15.0, // Move to right 10  horizontally
                                        15.0, // Move to bottom 10 Vertically
                                      ),
                                    )

                                  ]
                                ),
                                child:Column(
                        children: [
                               TextFormField(
                                  controller: _phoneNumber,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                      fillColor: Colors.transparent, filled: true,
                                      border: InputBorder.none,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xFFF1F1F1)),
                                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                      ),
                                      hintText: "Phone Number",hintStyle: TextStyle(
                                    color: Colors.blueAccent, // <-- Change this
                                    fontSize: null,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                  ),
                                      prefixIcon: Padding(padding: EdgeInsetsDirectional.only(start: 12.0),
                                      child: Icon(
                                        Icons.call,
                                        color: Color(0xFF00E676),
                                      ),),
                                      prefix: Padding(padding: EdgeInsets.all(5),
                                        child: Text("+91"),)
                                  ),
                                  maxLength: 10,
                                  keyboardType: TextInputType.number


                              ),

                              SizedBox(
                                width: 200,
                                child: ElevatedButton (

                                style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.indigoAccent),
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ))
                                ),
                                  onPressed: () async {
                                String phoneNumber = "+91${_phoneNumber.text}";
                                await sendOtp(phoneNumber);


                              }, child: Text("Submit".toUpperCase(),style: TextStyle(
                                  fontSize: 20,fontWeight:FontWeight.w400
                                ),)),
                              ),
                        ],
                                )
                              ),
                            ),
                          ),
                          AbsorbPointer(
                            absorbing: _isVerifyDisabled,
                            child: Container(
                              margin: EdgeInsets.only(left: 10,right: 10),
                              padding: EdgeInsets.only(top: 10),
                              child: BlurryContainer(
                                blur: 10,
                                elevation: 10,
                                color: Colors.black.withOpacity(0.2),

                                child: Column(

                                  children: [

                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),

                                child: Pinput(
                                  controller: _otp,
                                  length: 6,
                                  showCursor: true,
                                  androidSmsAutofillMethod:  AndroidSmsAutofillMethod.smsUserConsentApi,

                                )
                              ),
                              Container(
                                child: SizedBox(
                                  width: 200,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        foregroundColor: MaterialStateProperty.all<Color>(Colors.indigoAccent),
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ))
                                    ),

                                    onPressed: () async{
                                      EasyLoading.show(status: 'loading').timeout(Duration(seconds: 100));
                                      await FirebaseAuth.instance.currentUser?.linkWithCredential(PhoneAuthProvider.credential(verificationId: mVerificationId, smsCode: _otp.text));
                                  SharedPreferences preferences = await SharedPreferences.getInstance();
                                  preferences.setString("mobile_number", "+91${_phoneNumber.text}");


                                  Map <String, dynamic> data={
                                    "photoUrl": preferences.getString("photoUrl"),
                                    "mobileNumber": preferences.getString("mobile_number"),
                                    "name": preferences.getString("displayName"),
                                    "email": preferences.getString("email"),
                                  };
                                  String? uid = preferences.getString("uid");
                                  await FirebaseDatabase.instance.ref("user_data").child(uid!).set(data);
                                  //FirebaseFirestore.instance.collection("User_Data").doc(preferences.getString("uid")).set(data);
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                                  EasyLoading.dismiss();

                                }, child: Text("Verify".toUpperCase(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.indigoAccent),)
                                ),
                                ),
                              ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]

                    ),

                  ),
                ),

              ],


        ),
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
    verificationFailed: (FirebaseAuthException e) {

          print(e);
    },
    codeSent: (String verificationId, int? resendToken) {
          setState(() {
            mVerificationId = verificationId;
            _isVerifyDisabled = false;
            _isPhoneDisabled = true;
          });
          print("sent");
    },
    codeAutoRetrievalTimeout: (String verificationId) {}
    );

  }

}


