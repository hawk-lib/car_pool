

import 'package:car_pool/utility/appPreferences.dart';
import 'package:car_pool/utility/rides.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateRideController extends GetxController {
  RxString source = RxString("");
  RxString destination = RxString("");
  RxString time = RxString("");
  RxString date = RxString("");
  RxString route = RxString("");
  RxString totalSeats = RxString("");
  RxString seatsRemaining = RxString("");
  RxBool passenger = RxBool(true);


  RxString price = RxString("");
  RxList<PassengerModel> list = RxList();

  aSyncData(RidesHistory data) {
    source.value = data.source;
    destination.value = data.destination;
    date.value = data.date;
    String s = "$source-$destination";
    Stream<DocumentSnapshot> snap2 = FirebaseFirestore.instance
        .collection("user_data")
        .doc(AppPreferences.getUID())
        .collection("ride_created")
        .doc(data.date)
        .snapshots();
    snap2.listen((event) {
      seatsRemaining.value = event.get('Remaining Seats');
    });
    Stream<DocumentSnapshot> snap = FirebaseFirestore.instance
        .collection("rides")
        .doc(s)
        .collection(data.date)
        .doc(AppPreferences.getUID())
        .snapshots();
    snap.listen((event) {
      price.value = '${event.get("Price")}';
      route.value = '${event.get("Route Name")}';
      totalSeats.value = '${event.get("Total Passenger")}';
      time.value = '${event.get("Time")}';
      price.value = '${event.get("Price")}';


      if(event.get('Passengers')== "null"){
        passenger.value = false;
      }else {
        Map<String, dynamic> passengers = event.get('Passengers');
        DatabaseReference dbRef = FirebaseDatabase.instance.ref("user_data");
        passengers.forEach((key, value) async {
          late String name;
          late String photoUrl;
          late String mobileNumber;
          String passengerID = key;
          String seatBooked = value;


          DatabaseEvent event = await dbRef.child(passengerID)
              .once();
          name = event.snapshot
              .child("name")
              .value
              .toString();
          mobileNumber = event.snapshot
              .child("mobileNumber")
              .value
              .toString();
          photoUrl = event.snapshot
              .child("photoUrl")
              .value
              .toString();

          //list.value = PassengerModel(passengerID, seatBooked, name, photoUrl, mobileNumber) as List<PassengerModel>;
          list.add(PassengerModel(
              passengerID, seatBooked, name, photoUrl, mobileNumber));
        });
      }
    });
  }

}