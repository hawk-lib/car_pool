

import 'package:car_pool/utility/appPreferences.dart';
import 'package:car_pool/utility/rides.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SearchRideController extends GetxController {

  RxString source = RxString("");
  RxString destination = RxString("");
  RxString date = RxString("");
  RxBool noData = RxBool(false);
  bool isAbsorbed=false;


  RxList<Rides> list = RxList();

  aSyncData() async {
    EasyLoading.show(status: "please wait");
    isAbsorbed = true;
    String ride = "${source.value}-${destination.value}";

    DatabaseReference dbRef = FirebaseDatabase
        .instance
        .ref("user_data");
    QuerySnapshot querySnapshot = await FirebaseFirestore
        .instance
        .collection("rides")
        .doc(ride)
        .collection(date.value)
        .get();
    if (querySnapshot.docs.isEmpty) {
      noData.value = true;
      EasyLoading.dismiss();
      isAbsorbed = false;
    }else {
      noData.value=false;
      EasyLoading.dismiss();
      isAbsorbed = false;
      Stream<QuerySnapshot> streamSnapshot = FirebaseFirestore
          .instance
          .collection("rides")
          .doc(ride)
          .collection(date.value)
          .snapshots();
      streamSnapshot.listen((event) {
        list.clear();
        EasyLoading.dismiss();
        event.docs.forEach((doc) async {
          late String name;
          late String photoUrl;
          late String mobileNumber;


          DatabaseEvent event = await dbRef.child(
              doc.id)
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


          list.add(Rides(
            source.value,
            destination.value,
            date.value,
            doc.id,
            name,
            photoUrl,
            mobileNumber,
            doc["Total Passenger"],
            doc["Time"],
            doc["Route Name"],
            doc["Price"],
          )

          );
        });
      });
    }
  }
}