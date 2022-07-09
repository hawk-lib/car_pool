import 'package:car_pool/screens/travel_history_screen.dart';
import 'package:car_pool/utility/appPreferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authentication_screen.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  String email = AppPreferences.getEmail();
  String photoUrl = AppPreferences.getPhotoUrl();
  String displayName = AppPreferences.getDisplayName();
  late String mVerificationId;


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.lightBlue,
            width: double.infinity,
            height: 150,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/icons/ic_launcher.png"),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("Car Pool",
                          style: const TextStyle(color: Colors.black,
                              fontSize: 20,
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold,
                              wordSpacing: 3),),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Hero(
                          tag: "myPhoto",
                          child: CircleAvatar(
                            radius: 23.0,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              backgroundImage: Image
                                  .network(photoUrl)
                                  .image,
                              radius: 21,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: "myName",
                            child: Text(displayName,
                              style: const TextStyle(color: Colors.white,
                                  fontSize: 20,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold,
                                  wordSpacing: 3),),
                          ),
                          Text(AppPreferences.getEmail(),
                            style: const TextStyle(color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                wordSpacing: 1),)

                        ],

                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.only(left: 10, right: 10, top: 1),
            child: ListTile(
              leading: const Icon(Icons.person),
              title: const Text('History'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => TravelHistoryScreen()));
              },
            ),
          ),


          Card(
            margin: EdgeInsets.only(left: 10, right: 10, top: 1),
            child: ListTile(
                leading: const Icon(Icons.arrow_back),
                title: const Text('Logout'),
                onTap: () {
                  logout();
                }
            ),
          ),
        ],
      ),
    );
  }

  logout() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    AppPreferences.clear();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthenticationScreen()));
  }
}
