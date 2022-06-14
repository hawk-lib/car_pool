import 'package:car_pool/screens/authentication_screen.dart';
import 'package:car_pool/screens/drawer.dart';
import 'package:car_pool/screens/ride_booking_screen.dart';
import 'package:car_pool/screens/ride_creating_screen.dart';
import 'package:car_pool/screens/search_ride.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return  MaterialApp(
      home: Scaffold(
              backgroundColor: Colors.white,
              //backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text("Car Pool"),
        ),
        drawer: NavigationDrawerWidget(),
        body: Stack(
          children: [
            Positioned(
              top: 40,
            height: 260.0,
            left: 10.0,
            right: 10.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    border: Border.all(width: 5,color: Color(0xfffAFAFA)),
                    image: DecorationImage(image: AssetImage("assets/image/car.png"),
                      fit: BoxFit.fill,
                    ),
                  ) ,

            )
            ),
            Positioned(
              bottom: 60.0,
              height: 260.0,
              left: 10.0,
              right: 10.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, top:20, right: 20, bottom:20),
                      height: 80,
                      width: 300,

                      decoration: const BoxDecoration(
                          color: Colors.white70,

                      ),

                      child: InkWell(
                        child: Container(

                          margin: EdgeInsets.only(left: 20, top:12, right: 20, bottom:12),
                          height: 60,
                          width: 250,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),

                              color: Color(0xffffccbc),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xfffbe9e7),
                                  spreadRadius: 2,
                                  blurRadius: 10,

                                )
                              ]
                          ),


                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Create Ride'.toUpperCase(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.blueAccent,

                              ),
                            ),
                          ),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>RideCreateScreen()));
                        },
                      ),


                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, top:5, right: 20, bottom:40),
                      height: 80,
                      width: 300,
                      decoration: const BoxDecoration(
                          color: Colors.white70,


                      ),
                      child:InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 20, top:12, right: 20, bottom:12),
                          height: 60,
                          width: 250,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),

                              color: Color(0xffaed581),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xfffbe9e7),
                                  spreadRadius: 2,
                                  blurRadius: 10,

                                ),
                              ]
                          ),

                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Book Ride'.toUpperCase(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.red,

                              ),
                            ),
                          ),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchRide()));

                        }
                        ,
                      ),


                    ),

                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }





// FloatingActionButton buildLoginButton(BuildContext context) {
//
//   return FloatingActionButton.extended(onPressed: (){
//     logout();
//     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthenticationScreen()));
//
//   },
//       label: const Text("Book Ride"),
//       backgroundColor: Colors.white,
//       foregroundColor: Colors.black);
// }
//
// Future<void> logout() async {
//   await GoogleSignIn().signOut();
//   await FirebaseAuth.instance.signOut();
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   print(preferences.getString("email"));
//   print(preferences.getString("uid"));
//   print(preferences.getString("photoUrl"));
//   print(preferences.getString("displayName"));
//   print(preferences.getString("mobile_number"));
//
//   preferences.clear();
//   print(preferences.getString("email"));
//   print(preferences.getString("uid"));
//   print(preferences.getString("photoUrl"));
//   print(preferences.getString("displayName"));
//   print(preferences.getString("mobile_number"));
// }
}