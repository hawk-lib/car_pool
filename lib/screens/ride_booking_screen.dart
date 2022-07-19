import 'dart:async';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:car_pool/utility/appPreferences.dart';
import 'package:car_pool/utility/dataControler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../utility/rides.dart';

class RideBookScreen extends StatefulWidget {

  final Rides rides;

  const RideBookScreen(this.rides, {Key? key}) : super(key: key);

  @override
  State<RideBookScreen> createState() => _RideBookScreenState(rides);
}

  class _RideBookScreenState extends State<RideBookScreen> {
    int availableSeats = 0;
    TextEditingController totalSeatBook = TextEditingController();
    Rides rides;
    _RideBookScreenState(this.rides);
    bool isAbsorbed = false;


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
          body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/background/road.jpg"),
                      fit: BoxFit.cover
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 110,
                        width: 20,
                        margin: EdgeInsets.only(bottom: 40),
                        decoration: const BoxDecoration(
                          color: Colors.lightBlue,
                          border: Border(
                              bottom: BorderSide(
                                color: Colors.white,
                                width: 2,
                              )
                          ),

                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(100.0),
                              bottomLeft: Radius.circular(100.0)),
                        ),
                        height: 150,
                        width: 100,
                        padding: EdgeInsets.only(top: 50),
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 48.0,
                            backgroundImage: Image.network(AppPreferences.getPhotoUrl()).image,

                          ),

                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 110,
                          margin: EdgeInsets.only(bottom: 40),
                          decoration: const BoxDecoration(
                            color: Colors.lightBlue,
                            border: Border(
                                bottom: BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                )
                            ),
                          ),


                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                alignment: Alignment.bottomLeft,
                                margin: EdgeInsets.only(left: 5),
                                child: Text(
                                  AppPreferences.getDisplayName(),
                                  style: TextStyle(
                                      fontFamily: 'SF Pro',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18.0,
                                      color: Colors.white
                                  ),
                                ),
                              ),

                              Container(
                                alignment: Alignment.bottomLeft,
                                margin: EdgeInsets.only(top: 5,bottom: 5,left: 5),
                                child: Text(
                                  AppPreferences.getMobileNumber(),
                                  style: TextStyle(
                                      fontFamily: 'SF Pro',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],

                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15,right: 15, top: 20),
                    padding: EdgeInsets.only(bottom: 20),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                      color: Colors.black54,

                    ),
                    child: Column(
                          children: [
                            BlurryContainer(
                              blur: 10,
                              elevation: 0.5,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25)
                                ),
                                color: Colors.lightGreen,

                              child: Column(
                                children: [
                                  Hero(
                                    tag:"profilePic",
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 23,
                                      child: CircleAvatar(
                                        radius: 21,
                                        backgroundImage: Image.network(rides.photoUrl).image,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Hero(
                                        tag: "profileName",
                                        child: Text(rides.name
                                          ,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("${rides.source} - ${rides.destination}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,

                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Date & Time : ${rides.date} ${rides.time}"
                                  ,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,

                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Route : ${rides.route}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.blue,

                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Total Seats : ${rides.totalSeats}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,

                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Align(
                                alignment: Alignment.center,
                                child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                                  stream: FirebaseFirestore.instance.collection(
                                      "user_data")
                                      .doc(rides.id)
                                      .collection("ride_created")
                                      .doc(rides.date)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return const Text("loading..");
                                    } else {
                                      availableSeats = int.parse(
                                          snapshot.data?.data()!['Remaining Seats']);
                                      return Text("Remaining Seats : ${availableSeats.toString()}", style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.red,

                                      ),);
                                    }
                                  },
                                ),
                              ),
                            ),
                            Container(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Price per Passenger : ${rides.price}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.green,

                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25)
                      ),
                    ),
                    child: AbsorbPointer(
                      absorbing: isAbsorbed,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(25)
                                ),
                                color: Colors.white,
                              ),
                              child:TextFormField(
                                enableInteractiveSelection: false,
                                controller: totalSeatBook,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                textInputAction: TextInputAction.done,
                                decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft:Radius.circular(25)),
                                      borderSide: BorderSide(
                                          color: Colors.white),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft:Radius.circular(25)),
                                      borderSide: BorderSide(
                                          color: Colors.green),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft:Radius.circular(25)),
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft:Radius.circular(25)),
                                      borderSide: BorderSide(
                                          color: Colors.yellow),
                                    ),
                                    contentPadding:
                                    EdgeInsets.only(left: 20,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                    hintText: "No. of Seats",
                                    prefixIcon: Icon(
                                      Icons.route,
                                      color: Color(0xFF00E676),
                                    )
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(25),
                              ),
                              color: Colors.blue,
                            ),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      )), elevation: MaterialStateProperty.all(0),
                                ),
                                onPressed: ()async {

                                  if(rides.id == AppPreferences.getUID()){
                                    snackBar("You can't book your own ride.");
                                  }else {
                                    int seats = int.parse(totalSeatBook.text);
                                    if (availableSeats > 0) {
                                      if (seats <= availableSeats) {
                                        setState(() {
                                          isAbsorbed=true;
                                        });
                                        EasyLoading.show();
                                        var firestoreDB = await FirebaseFirestore
                                            .instance.collection("rides")
                                            .doc(
                                            "${rides.source}-${rides.destination}")
                                            .collection(rides.date)
                                            .doc(rides.id);
                                        var firestoreUserData = await FirebaseFirestore
                                            .instance.collection(
                                            "user_data")
                                            .doc(AppPreferences.getUID())
                                            .collection(
                                            "ride_booked")
                                            .doc(rides.date);
                                        firestoreUserData.get().then((value) async {
                                          if (value.exists) {
                                            snackBar("Already Booked");
                                          } else {
                                            firestoreDB.set({

                                              "Passengers": {
                                                "${AppPreferences.getUID()}": "$seats"
                                              }
                                            }, SetOptions(merge: true)).then((
                                                value) async {
                                              int seat = availableSeats - seats;
                                              await FirebaseFirestore.instance
                                                  .collection(
                                                  "user_data")
                                                  .doc(rides.id).collection(
                                                  "ride_created").doc(
                                                  rides.date).update({
                                                "Remaining Seats": "$seat",
                                              });
                                            });
                                            await FirebaseFirestore.instance
                                                .collection(
                                                "user_data")
                                                .doc(AppPreferences.getUID())
                                                .collection(
                                                "ride_booked").doc(rides.date).set({
                                              "Starting Point": rides.source,
                                              "Ending Point": rides.destination,
                                              "User": rides.id,
                                              "Seats": seats.toString(),
                                              "Timestamp": DateTime.now()
                                            })
                                                .then((value) {
                                                  setState(() {
                                                    isAbsorbed=false;
                                                  });
                                              EasyLoading.dismiss();
                                              snackBar(
                                                  "Successfully Booked!");
                                            });
                                          }
                                        });
                                      } else {
                                        snackBar(
                                            "Sorry! only ${availableSeats} available!");
                                      }
                                    } else {
                                      snackBar("No seats are available!");
                                    }
                                  }

                                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>RideBookScreen()));
                                },
                                child: Text("Book Now",style: TextStyle(fontSize: 20),)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

      );
    }

    void dataRefrence() async {
      DatabaseReference dbRef = FirebaseDatabase.instance.ref("user_data");
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await FirebaseFirestore.instance
          .collection("rides")
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) async {
          late String mobileNumber;

          DatabaseEvent event = await dbRef.child(doc.id).once();

          mobileNumber = event.snapshot
              .child("mobileNumber")
              .value
              .toString();




        });
      });
    }
    void snackBar(String m){
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: m,
        ),
      );
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

