import 'package:blurrycontainer/blurrycontainer.dart';
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
    return Scaffold(
                backgroundColor: Colors.transparent,
                //backgroundColor: Colors.red,
          appBar: AppBar(
            title: Text("Car Pool"),
            backgroundColor: Colors.black.withOpacity(0.4),

          ),
          drawer: NavigationDrawerWidget(),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/image/register.png"),
                    fit: BoxFit.cover
                )
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 40,
                height: 260.0,
                left: 10.0,
                right: 10.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(image: AssetImage("assets/image/carImage.png"),
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
                      color: Colors.transparent,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.all(20),

                         

                          child: SizedBox(
                            width: 200,
                            height: 50,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.indigoAccent),
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ))
                                ),

                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RideCreateScreen()));
                                }, child: Text("Create Ride")),
                          )



                        ),
                        Container(

                          decoration: const BoxDecoration(
                              color: Colors.transparent,


                          ),
                          child:SizedBox(
                            width: 200,
                            height: 50,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ))
                                ),

                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchRide()));
                                }, child: Text("Book Ride")),
                          )


                        ),

                      ],
                    ),
                  ),
                )
              ],
            ),
          )
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