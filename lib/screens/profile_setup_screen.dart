import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:car_pool/utility/appPreferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'authentication_screen.dart';
import 'home_screen.dart';


class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _otp = TextEditingController();

  String email = AppPreferences.getEmail();
  String photoUrl = AppPreferences.getPhotoUrl();
  String displayName = AppPreferences.getDisplayName();
  late String mVerificationId;
  bool _isPhoneDisabled = false;
  bool _isVerifyDisabled = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.only(
                    bottomRight: const Radius.circular(50.0),

                  ),
                  // gradient: LinearGradient(
                  //  begin: Alignment.bottomLeft,
                  //  end: Alignment.topRight,
                  //  colors: [Color(0xFF00E676), Color(0xFFB3F6CA)]),
                  color: Colors.greenAccent.withOpacity(0.7),


                ),
                child: SafeArea(
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5,top: 5),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back,),
                          color: Colors.white,
                          iconSize: 30,
                          padding: EdgeInsets.all(5),
                          onPressed: () async {
                            try {
                              await FirebaseAuth.instance.currentUser?.delete();
                            }catch (error){
                              print(error);
                            }
                            await GoogleSignIn().signOut();
                            await FirebaseAuth.instance.signOut();
                            AppPreferences.clear();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthenticationScreen()));
                            },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15,top: 25,bottom: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(displayName,
                                      style: const TextStyle(color: Colors.black,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          wordSpacing: 3),),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text("($email)",style: const TextStyle(color: Colors.white,
                                          fontSize: 16,
                                          ),),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 50,
                              child: CircleAvatar(
                                backgroundImage: Image
                                    .network(photoUrl)
                                    .image,
                                radius: 48,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                )
            ),

            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AbsorbPointer(
                        absorbing: _isPhoneDisabled,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30,),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            controller: _phoneNumber,
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            style: TextStyle(color: Colors.white,
                              letterSpacing: 2,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,),

                            decoration: const InputDecoration(
                              labelStyle: TextStyle(color: Colors.green),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(15)),
                                borderSide: BorderSide(
                                    color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(15)),
                                borderSide: BorderSide(
                                    color: Colors.green),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(15)),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(15)),
                                borderSide: BorderSide(
                                    color: Colors.yellow),
                              ),
                              contentPadding:
                              EdgeInsets.only(left: 20,
                                  bottom: 11,
                                  top: 11,
                                  right: 15),
                              labelText: "Mobile Number",
                                hintText: "9988776655",
                                hintStyle: TextStyle(
                                  letterSpacing: 2,
                                  color: Colors.green,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                ),
                                prefixIcon: Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: 12.0),
                                  child: Icon(
                                    Icons.call,
                                    color: Color(0xFF00E676),
                                  ),),
                            ),
                            maxLength: 10,
                            textInputAction: TextInputAction.go,
                            onFieldSubmitted: (String s){
                              if (_phoneNumber.text.length < 10) {
                                snackBar("Enter Mobile Number correctly!", Colors.red);
                              } else {
                                sendOtp("+91${_phoneNumber.text}");
                              }
                            },
                          ),
                        ),
                      ),
                      AbsorbPointer(
                        absorbing: _isVerifyDisabled,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10,bottom: 15),
                                child: InkWell(child: Text("Wrong Number?",
                                  style: TextStyle(color: Colors.white,fontSize: 16),), onTap: (){
                                  _otp.clear();
                                  setState(() {
                                    _phoneNumber.text="";
                                    _isVerifyDisabled = true;
                                    _isPhoneDisabled = false;
                                  });
                                },
                                ),
                              )

                            ),
                            Container(
                                padding: EdgeInsets.all(10),
                                child: Pinput(
                                  pinputAutovalidateMode: PinputAutovalidateMode.disabled,
                                  controller: _otp,
                                  length: 6,
                                  showCursor: true,
                                  onCompleted:  (String pin) => phoneNumberVerify(PhoneAuthProvider.credential(
                                      verificationId: mVerificationId,
                                      smsCode: pin)),


                                )
                            ),
                          ],
                        ),
                      ),
                    ]

                ),

              ),
            ),

          ],


        ),
      ),
    );
  }

  sendOtp(String phoneNumber) async {
    setState(() {
      _isPhoneDisabled = true;
    });
    EasyLoading.show();
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            _otp.setText(credential.smsCode!);
            phoneNumberVerify(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            print(e);
          },
          codeSent: (String verificationId, int? resendToken) {
            setState(() {
              mVerificationId = verificationId;
              _isVerifyDisabled = false;
            });
            EasyLoading.dismiss();
            snackBar("Code Sent to $phoneNumber", Colors.green);
          },
          codeAutoRetrievalTimeout: (String verificationId) {}
      );
    }catch (e) {
      setState(() {
        _isPhoneDisabled = false;
        _isVerifyDisabled = true;
      });
      EasyLoading.dismiss();
      snackBar(e.toString(), Colors.green);
    }
  }

  void homeScreen() {
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(
        builder: (context) =>
            HomeScreen()), (
        Route<dynamic> route) => false);
  }
  void snackBar(String m, Color color){
    showTopSnackBar(
      context,
      CustomSnackBar.error(
        message: m, backgroundColor: color,
      ),
    );
  }

  phoneNumberVerify(PhoneAuthCredential credential) async {
    setState(() {
      _isVerifyDisabled = true;
    });
    EasyLoading.show(status: 'loading')
        .timeout(
        Duration(seconds: 100));
    try {
      await FirebaseAuth.instance.currentUser?.linkWithCredential(credential);

      AppPreferences.setMobileNumber("+91${_phoneNumber.text}");

      Map <String, dynamic> data = {
        "photoUrl": AppPreferences.getPhotoUrl(),
        "mobileNumber": AppPreferences.getMobileNumber(),
        "name": AppPreferences.getDisplayName(),
        "email": AppPreferences.getEmail(),
      };
      await FirebaseDatabase.instance.ref("user_data").child(AppPreferences.getUID()).set(data);

      EasyLoading.dismiss();
      homeScreen();
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isVerifyDisabled = false;
      });
      EasyLoading.dismiss();
      snackBar(e.code, Colors.red);
      switch (e.code) {
        case "provider-already-linked":
          snackBar("Already linked", Colors.green);

          break;
        case "invalid-credential":
          snackBar("Invalid Verification code.", Colors.red);

          break;
        case "credential-already-in-use":
          snackBar("Already linked to a Another account.", Colors.red);
          break;
      // See the API reference for the full list of error codes.
        default:
          snackBar("Unknown error.", Colors.red);
      }
    }
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


