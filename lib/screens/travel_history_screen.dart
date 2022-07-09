


import 'package:car_pool/screens/book_ride_history.dart';
import 'package:car_pool/utility/appPreferences.dart';
import 'package:car_pool/utility/rides.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'create_ride_history.dart';

class TravelHistoryScreen extends StatelessWidget {
  const TravelHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(tag:"myName",
                    child: Text(AppPreferences.getDisplayName(),
                      style: TextStyle(fontSize: 20.0),)),
                Text("History",style: TextStyle(fontSize: 16.0,color: Colors.yellow),),

              ],
            ),
            leading:  Container(
              padding: EdgeInsets.only(top: 5,bottom: 5,left: 10),
              child: Hero(
                  tag: "myPhoto",
                  child: CircleAvatar(
                    radius: 23,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 21,
                        backgroundImage: Image.network(AppPreferences.getPhotoUrl()).image,))),
            ),
            bottom: TabBar(
              tabs: [
                Tab(text: "Created",),
                Tab(text: "Booked",)


              ],

            ),
          ),

            body: TabBarView(children: [
              Center(
                child: FutureBuilder<QuerySnapshot> (
                future: FirebaseFirestore.instance.collection("user_data")
                .doc(AppPreferences.getUID())
                .collection("ride_created")
                .get(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){

                  if(snapshot.connectionState==ConnectionState.done){
                    if(snapshot.hasData) {
                      List<RidesHistory> list = [];
                      if (snapshot.data?.size == 0) {
                        return Text("No Data Found!",
                            style: TextStyle(fontWeight: FontWeight.w600,
                                fontSize: 20));
                      } else {
                        snapshot.data?.docs.forEach((element) async {
                          String strt = element['Starting Point'];
                          String ending = element['Ending Point'];
                          String date = element.id;
                          String remain = element['Remaining Seats'];


                          list.add(RidesHistory(
                            strt,
                            ending,
                            date,
                            remain,
                          ));
                        });
                        return ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20.0)),
                                  title: Hero(tag: "titleA",
                                      child: Text(list[index].source + " - " +
                                          list[index].destination,
                                        style: TextStyle(color: Colors.blue,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20),)),
                                  subtitle: Text(list[index].date,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400),),
                                  trailing: StreamBuilder<
                                      DocumentSnapshot<Map<String, dynamic>>>(
                                    stream: FirebaseFirestore.instance
                                        .collection("user_data")
                                        .doc(AppPreferences.getUID())
                                        .collection("ride_created")
                                        .doc(list[index].date)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Text("Loading...");
                                      } else if (!snapshot.hasData) {
                                        return const Text("NA");
                                      } else {
                                        return Text(
                                          "Seats left : ${snapshot.data
                                              ?.data()!['Remaining Seats']}",
                                          style: TextStyle(color: Colors.red,
                                              fontSize: 16),);
                                      }
                                    },
                                  ),


                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            CreateRideHistory(list[index])));
                                  },
                                ),
                              );
                            });
                      }
                    }else {
                      return Text("No Data Found!", style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20));
                    }

                  }
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Text("Loading...", style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 20));
                  }
                  return Text("Not Available!", style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 20));
                },
              ),
              ),

              Center(
                child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance.collection("user_data")
                .doc(AppPreferences.getUID())
                .collection("ride_booked")
                .get(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot)
                {
                  if(snapshot.connectionState==ConnectionState.active){
                    return Text("Failed to load",style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 20));
                  }
                  if(snapshot.connectionState==ConnectionState.done){
                    if(snapshot.hasData) {
                      List<BookedHistory> list = [];
                      if (snapshot.data?.size == 0) {
                        return Text("No Data Found!",
                            style: TextStyle(fontWeight: FontWeight.w600,
                                fontSize: 20));
                      } else {
                        snapshot.data?.docs.forEach((element) async {
                          String strt = element["Starting Point"];
                          String ending = element["Ending Point"];
                          String date = element.id;
                          String booked = element["Seats"];
                          String user = element['User'];


                          list.add(BookedHistory(
                              strt,
                              ending,
                              date,
                              booked,
                              user
                          ));
                        });
                        return ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20.0)),
                                  title: Hero(tag: "titleB",
                                      child: Text(list[index].source + " - " +
                                          list[index].destination,
                                        style: TextStyle(color: Colors.blue,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20),)),
                                  subtitle: Text(list[index].date,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400),),
                                  trailing: Text(
                                    "Seats booked: ${list[index].bookedseats}",
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 16),),


                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            BookRideHistory(list[index])));
                                  },
                                ),
                              );
                            });
                      }
                    }else {
                      return Text("No Data Found!",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20));
                    }
                  }

                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Text("Loding...",style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 20));
                  }

                  return Text("Not Available!",style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 20));


                }
                )

                ,)
            ])

        ),
    );
  }
}