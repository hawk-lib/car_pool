import 'package:car_pool/utility/dataControler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utility/rides.dart';

class RideBookScreen extends StatefulWidget {

  final Rides rides;

  RideBookScreen(this.rides, {Key? key}) : super(key: key);

  @override
  State<RideBookScreen> createState() => _RideBookScreenState(rides);
}

  class _RideBookScreenState extends State<RideBookScreen>{
    int availableSeats = 0;
    TextEditingController totalSeatBook = TextEditingController();
    Rides rides;

  _RideBookScreenState(this.rides);

    @override
    Widget build(BuildContext context) {
      return Material(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: 200,
                margin: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 10),
                color: Colors.red,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 300,
                      margin: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                      color: Colors.white,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          rides.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,

                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      margin: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                      color: Colors.white,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          rides.source,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,

                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      margin: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                      color: Colors.white,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          rides.destination,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,

                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      margin: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                      color: Colors.white,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          rides.date,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,

                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      margin: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                      color: Colors.white,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          rides.time,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,

                          ),
                        ),
                      ),
                    ),

                    Container(
                      height: 50,
                      width: 300,
                      margin: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                      color: Colors.white,
                      child: Align(
                        alignment: Alignment.center,
                        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance.collection("user_data")
                              .doc(rides.id)
                              .collection("ride_created")
                              .doc(rides.date)
                              .snapshots(),
                          builder: (context,snapshot){
                            if(!snapshot.hasData){
                              return const Text("loading..");
                            }else{
                              availableSeats = int.parse(snapshot.data?.data()!['Remaining Seats']);
                              return Text(availableSeats.toString());

                            }
                          },
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 20, top:12, right: 20, bottom:12),

                      decoration: BoxDecoration(

                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                            color: Colors.black
                        ),


                      ),
                      child: TextFormField(
                        enableInteractiveSelection: false,
                        controller: totalSeatBook,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding:
                          EdgeInsets.only(left: 20, bottom: 11, top: 11, right: 15),
                          hintText: "Number of Seats",
                        ),
                      ),


                    ),


                    InkWell(
                      child: Container(
                        margin: EdgeInsets.only(top: 40,bottom: 20),
                        height: 40,
                        width: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: Colors.blueAccent,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orangeAccent,
                                spreadRadius: 2,
                                blurRadius: 5,
                              )
                            ]

                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Book Now'.toUpperCase(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,

                            ),
                          ),
                        ),
                      ),
                      onTap: () async {
                        int seats=int.parse(totalSeatBook.text);
                        if(availableSeats>0){
                        SharedPreferences preferences = await SharedPreferences.getInstance();
                        if(seats<=availableSeats){
                          await FirebaseFirestore.instance.collection("rides")
                              .doc("${rides.source}${rides.destination}")
                              .collection(rides.date)
                              .doc(rides.id).set({

                            "Passengers": {
                              "${preferences.getString("uid")}":"$seats"
                            }

                          }, SetOptions(merge: true)).then((value) async {

                            int seat = availableSeats-seats;
                            await FirebaseFirestore.instance.collection("user_data")
                                .doc(rides.id).collection("ride_created").doc(rides.date).update({
                              "Remaining Seats": "$seat",
                            });
                          });
                          await FirebaseFirestore.instance.collection("user_data")
                          .doc(preferences.getString("uid")).collection("ride_booked").doc(rides.date).set({
                            "Starting Point": rides.source,
                            "Ending Point": rides.destination,
                            "User": rides.id,
                            "Seats": seats,
                            "Timestamp": DateTime.now()
                          }).then((value) => print("Successful"));

                        }else{
                          print("Sorry! only ${availableSeats} available!");
                        }
                      }else{
                          print("No seats are available!");
                        }

                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>RideBookScreen()));
                      },
                    ),
                  ],
                ),
              ),
            ),

          )
      );


    }



  }

