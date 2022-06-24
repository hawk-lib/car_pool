


import 'package:car_pool/utility/rides.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TravelHistoryScreen extends StatelessWidget {
  const TravelHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller =PageController(
      initialPage: 2
    );
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(body: SafeArea(child: viewPager()))
    );
  }
   viewPager(){
    return PageView(
      controller: PageController()  ,
      scrollDirection: Axis.horizontal,
      children: [
        Center(
          child: rideCreated(),
        ),
        Center(child: Text("good"),)
      ],
    );
  }

  rideCreated() {
    List<RidesCreated> list = [];
    list.add(RidesCreated("_source", "_destination", "_remainingSeats", "_id", "_timeStamp"));
    list.add(RidesCreated("_source", "_destination", "_remainingSeats", "_id", "_timeStam"));
    list.add(RidesCreated("_source", "_destination", "_remainingSeats", "_id", "_timeSta"));



    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context,index){


          return Text(list[index].timeStamp);
        });
  }

  Future<List<RidesCreated>> loadData() async {
    List<RidesCreated> list = [];
    SharedPreferences pref = await SharedPreferences.getInstance();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("user_data")
        .doc(pref.getString("uid"))
        .collection("ride_created")
        .get();
    querySnapshot.docs.forEach((element) {
      list.add(RidesCreated(
          element['Starting Point'],
          element['Ending Point'],
          element['Remaining Seats'],
          element.id,
          element['Timestamp']));
    });
    return list;
  }
}