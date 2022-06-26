


import 'package:car_pool/screens/ride_booking_screen.dart';
import 'package:car_pool/utility/appPreferences.dart';
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
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Travel History"),
            bottom: TabBar(
              tabs: [
                Tab(text: "CreateHistory",),
                Tab(text: "SearchHistory",)


              ],

            ),
          ),

            body: TabBarView(children: [
              Center(child: FutureBuilder<QuerySnapshot> (
                future: FirebaseFirestore.instance.collection("user_data")
                .doc(AppPreferences.getUID())
                .collection("ride_created")
                .get(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){

                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Text("Loading...");
                  }else if(snapshot.hasData){
                    List<RidesHistory> list = [];
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
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                              title: Text(list[index].source+" TO " + list[index].destination),
                              subtitle: Text(list[index].date),
                              trailing: Text(list[index].remainingSeats),


                              onTap: (){
                              },
                            ),
                          );

                    });
                  }else{
                    return Text("failed to load");
                  }

                },
              ),),
              Center(child: Text("hii"),)
            ])

        ),
      )
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


  /*Future<RidesHistory>> getHistoryData() async {
    late List<RidesHistory> list = [];

    SharedPreferences pref = await SharedPreferences.getInstance();
    QuerySnapshot querySnapshot =
    querySnapshot.docs.forEach((element) {
      print(element.id);
      return RidesHistory(
          element['Starting Point'],
          element['Ending Point'],
          element.id,
          element['Remaining Seats'],
          pref.getString("uid")!,
          element['Timestamp'],
          element['Price'],
          element['Route'],
          element['Time'],
          element['Total Passenger']
      );
      list.add();
    });
    return list;


  }*/
}