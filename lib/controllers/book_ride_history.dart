

import 'package:car_pool/utility/appPreferences.dart';
import 'package:car_pool/utility/rides.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BookRideController extends GetxController {
  RxString source = RxString("");
  RxString destination = RxString("");
  RxString time = RxString("");
  RxString date = RxString("");
  RxString route = RxString("");
  RxString totalSeats = RxString("");
  RxString seatsRemaining = RxString("");
  RxString ownerName = RxString("");
  RxString ownerPhotoUrl = RxString("");
  RxString ownerMobileNumber = RxString("");

  RxBool passenger = RxBool(true);


  RxString price = RxString("");
  RxList<PassengerModel> list = RxList();

  aSyncData(BookedHistory data) async {
    source.value = data.source;
    destination.value = data.destination;
    date.value = data.date;
    String s = "$source-$destination";
    Stream<DocumentSnapshot> snap2 = FirebaseFirestore.instance
        .collection("user_data")
        .doc(data.user)
        .collection("ride_created")
        .doc(date.value)
        .snapshots();
    snap2.listen((event) {
      seatsRemaining.value = event.get('Remaining Seats');
    });
    DatabaseReference dbRef = FirebaseDatabase.instance.ref("user_data");
    DatabaseEvent event = await dbRef.child(data.user)
        .once();
    ownerName.value = event.snapshot
        .child("name")
        .value
        .toString();
    ownerPhotoUrl.value = event.snapshot
        .child("photoUrl")
        .value
        .toString();
    ownerMobileNumber.value = event.snapshot
        .child("mobileNumber")
        .value
        .toString();
    Stream<DocumentSnapshot> snap = FirebaseFirestore.instance
        .collection("rides")
        .doc(s)
        .collection(date.value)
        .doc(data.user)
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
        passengers.forEach((key, value) async {
          String passengerID = key;
          String seatBooked = value;
          late String name;
          late String photoUrl;
          late String mobileNumber;

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

  Future<void> getListData(String owner) async {

    DatabaseReference dbRef = FirebaseDatabase.instance.ref("user_data");


  }

}