import 'dart:async';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:car_pool/utility/dataControler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../utility/rides.dart';

class RideBookScreen extends StatefulWidget {

  final Rides rides;

  RideBookScreen(this.rides, {Key? key}) : super(key: key);

  @override
  State<RideBookScreen> createState() => _RideBookScreenState(rides);
}

  class _RideBookScreenState extends State<RideBookScreen> {
    int availableSeats = 0;
    TextEditingController totalSeatBook = TextEditingController();
    Rides rides;
    _RideBookScreenState(this.rides);

    void dialogbox() {
      showDialog(context: context,
          builder: (context) {
            return AlertDialog(
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Thanks for booking'),
                    CloseButton(
                        color: Color(0xFFD5D3D3),
                        onPressed: () {
                          Navigator.of(context).pop();
                        })
                  ]

              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(rides.mobileNumber,textAlign: TextAlign.center,style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold),),
                ],
              ),
              actions: [
                IconButton(onPressed: (){},
                    icon: Icon(Icons.call)),
                IconButton(onPressed: (){},
                    icon: Icon(Icons.whatsapp)),
                IconButton(onPressed: (){},
                    icon: Icon(Icons.add)),
                IconButton(onPressed: (){},
                    icon: Icon(Icons.message))
              ],
              actionsPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,

            );
          }
      );
    }

    Future<SharedPreferences> getData() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs;
    }
    @override



    @override
    Widget build(BuildContext context) {
      return MaterialApp(

        home: Scaffold(
          body: SafeArea(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/background/road.jpg"),
                      fit: BoxFit.cover
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15,right: 15),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),

                    ),
                    child: BlurryContainer(
                      blur: 10,
                      elevation: 0.5,
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      child: Container(
                        
                        padding: EdgeInsets.all(20),
   
                        child: Column(
                          children: [
                            Container(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Rider-${rides.name}"
                                  ,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 20),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Source - ${rides.source}"
                                  ,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,

                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 20),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  rides.destination.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,

                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 20),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Destination-${rides.date}"
                                  ,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,

                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 20),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Time-${ rides.time.toUpperCase()}"
                                 ,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,

                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 15),
                              child: Align(
                                alignment: Alignment.center,
                                child: StreamBuilder<
                                    DocumentSnapshot<Map<String, dynamic>>>(
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
                                      return Text("Remaining Seats-${availableSeats.toString()}", style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,

                                      ),);
                                    }
                                  },
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 10,left: 20,right: 20,bottom: 5),
                              child:TextFormField(
                                enableInteractiveSelection: false,
                                controller: totalSeatBook,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFFF1F1F1)),
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                  contentPadding:
                                  EdgeInsets.only(left: 20, bottom: 11, top: 11, right: 15),
                                  hintText: "Seats Book",
                                  prefixIcon: Padding(padding: EdgeInsets.only(left: 2,right: 2),
                                      child: Icon(
                                        Icons.route,
                                        color: Color(0xFF00E676),
                                      )
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: SizedBox(
                      width: 200,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ))
                          ),
                          onPressed: ()async {

                            int seats = int.parse(totalSeatBook.text);
                            if (availableSeats > 0) {
                              SharedPreferences preferences = await SharedPreferences
                                  .getInstance();
                              if (seats <= availableSeats) {
                                var firestoreDB = await FirebaseFirestore.instance.collection("rides")
                                    .doc("${rides.source}${rides.destination}")
                                    .collection(rides.date)
                                    .doc(rides.id);
                                var firestoreUserData = await FirebaseFirestore.instance.collection(
                                    "user_data")
                                    .doc(preferences.getString("uid")).collection(
                                    "ride_booked").doc(rides.date);
                                firestoreUserData.get().then((value) async {
                                  if(value.exists){
                                    snackBar("Already Booked");
                                  }else{
                                    firestoreDB.set({

                                      "Passengers": {
                                        "${preferences.getString("uid")}": "$seats"
                                      }
                                    }, SetOptions(merge: true)).then((value) async {
                                      int seat = availableSeats - seats;
                                      await FirebaseFirestore.instance.collection(
                                          "user_data")
                                          .doc(rides.id).collection("ride_created").doc(
                                          rides.date).update({
                                        "Remaining Seats": "$seat",
                                      });
                                    });
                                    await FirebaseFirestore.instance.collection(
                                        "user_data")
                                        .doc(preferences.getString("uid")).collection(
                                        "ride_booked").doc(rides.date).set({
                                      "Starting Point": rides.source,
                                      "Ending Point": rides.destination,
                                      "User": rides.id,
                                      "Seats": seats,
                                      "Timestamp": DateTime.now()
                                    }).then((value) => dialogbox());
                                  }
                                });

                              } else {
                                snackBar("Sorry! only ${availableSeats} available!");
                              }
                            } else {
                              snackBar("No seats are available!");
                            }

                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>RideBookScreen()));
                          }, child: Text("Book Now",style: TextStyle(fontSize: 20),)),
                    ),
                  )


                ],
              ),
            ),
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
  }

