import 'package:car_pool/screens/travel_history_screen.dart';
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
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.greenAccent,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Container(
                child: Column(
                  children: <Widget>[
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

                  ],

                ),
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Travel History'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TravelHistoryScreen()));
            },
          ),
          const ListTile(
            leading: Icon(Icons.account_box),
            title: Text('about'),
            onTap: null,
          ),
          const ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text('contact'),
            onTap: null,
          ),
          const ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
            onTap: null,
          ),
          const ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacy Policy'),
            onTap: null,
          ),
          const ListTile(
            leading: Icon(Icons.card_membership),
            title: Text('Support'),
            onTap: null,
          ),
          ListTile(
            leading: const Icon(Icons.arrow_back),
            title: const Text('Logout'),
            onTap: (){ logout();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthenticationScreen()));},
          ),
        ],
      ),
    );

  }
  Future<void> logout() async {
  await GoogleSignIn().signOut();
  await FirebaseAuth.instance.signOut();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  print(preferences.getString("email"));
  print(preferences.getString("uid"));
  print(preferences.getString("photoUrl"));
  print(preferences.getString("displayName"));
  print(preferences.getString("mobile_number"));

  preferences.clear();
  print(preferences.getString("email"));
  print(preferences.getString("uid"));
  print(preferences.getString("photoUrl"));
  print(preferences.getString("displayName"));
  print(preferences.getString("mobile_number"));
}

}
