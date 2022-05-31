import 'package:car_pool/screens/authentication_screen.dart';
import 'package:car_pool/screens/drawer.dart';
import 'package:car_pool/screens/ride_booking_screen.dart';
import 'package:car_pool/screens/ride_creating_screen.dart';
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
        appBar: AppBar(
          title: Text("Car Pool"),
        ),
        drawer: NavigationDrawerWidget(),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>RideCreateScreen()));}, child: Text("Create a Ride")),
              SizedBox(height: 20),
              ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>RideBookScreen()));}, child: Text("Book A Ride"))
            ],
          ),
        ),
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