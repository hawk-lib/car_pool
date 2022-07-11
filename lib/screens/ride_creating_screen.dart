import 'dart:async';
import 'dart:ui';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:car_pool/utility/appPreferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RideCreateScreen extends StatefulWidget {
  const RideCreateScreen({Key? key}) : super(key: key);


  @override
  State<RideCreateScreen> createState() => _RideCreateScreenState();
}



class _RideCreateScreenState extends State<RideCreateScreen> {
  bool _isabsorbed=false;
  bool createrideDisabled = true;
  String uid = AppPreferences.getUID();
  String name = AppPreferences.getDisplayName();
  String mobileNumber = AppPreferences.getMobileNumber();
  String photoUrl = AppPreferences.getPhotoUrl();
  final _formkey=GlobalKey<FormState>();


  TextEditingController strLoc = TextEditingController();
  TextEditingController endLoc = TextEditingController();
  TextEditingController pathName = TextEditingController();
  TextEditingController dateCtl = TextEditingController();
  TextEditingController presentSeats = TextEditingController();
  TextEditingController totalYatri = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController totalPrice = TextEditingController();








  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                      backgroundImage: Image
                          .network(photoUrl)
                          .image,

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
                            name,
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
                          margin: EdgeInsets.only(
                              top: 5, bottom: 5, left: 5),
                          child: Text(
                            mobileNumber,
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


            AbsorbPointer(
              absorbing: _isabsorbed,
              child: Column(
                children: [
                  Container(
                    height: 300,
                    margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                    padding: EdgeInsets.symmetric(vertical: 25),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25)
                      ),
                      color: Colors.black54,
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            Container(
                                color: Colors.transparent,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 20, top: 5, right: 20, bottom: 5),

                                  decoration: BoxDecoration(

                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20)),


                                  ),
                                  child: TextFormField(
                                    controller: dateCtl,
                                    textInputAction: TextInputAction.next,
                                    enableInteractiveSelection: false,
                                    style: TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      labelStyle: TextStyle(color: Colors.green),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(
                                            color: Colors.white),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(
                                            color: Colors.green),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(color: Colors.red),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(
                                            color: Colors.yellow),
                                      ),
                                      contentPadding:
                                      EdgeInsets.only(left: 20,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                      labelText: "JourneyDate",
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.only(
                                              left: 2, right: 2),
                                          child: Icon(
                                            Icons.date_range,
                                            color: Color(0xFF00E676),
                                          )
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Date can't be null";
                                      }
                                      return null;
                                    },
                                    onTap: () async {
                                      DateTime ? date = DateTime(1900);
                                      FocusScope.of(context).requestFocus(
                                          FocusNode());
                                      date = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2100));

                                      dateCtl.text =
                                      "${date?.year}-${date?.month}-${date
                                          ?.day}";
                                    },
                                  ),


                                )
                            ),
                            Container(
                              color: Colors.transparent,
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 20, top: 5, right: 20, bottom: 5),

                                decoration: BoxDecoration(

                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20)),


                                ),
                                child: TextFormField(
                                  controller: time,
                                  textInputAction: TextInputAction.next,
                                  style: TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    labelStyle: TextStyle(color: Colors.green),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15)),
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15)),
                                      borderSide: BorderSide(color: Colors.green),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15)),
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15)),
                                      borderSide: BorderSide(
                                          color: Colors.yellow),
                                    ),
                                    contentPadding:
                                    EdgeInsets.only(left: 20,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                    labelText: "Journey Time",
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.only(
                                            left: 2, right: 2),
                                        child: Icon(
                                          Icons.timeline,
                                          color: Color(0xFF00E676),
                                        )
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Time Can't be null ";
                                    }
                                    return null;
                                  },
                                  onTap: () async {
                                    final TimeOfDay? picked = await showTimePicker(
                                      context: context,
                                      initialTime: const TimeOfDay(
                                          hour: 00, minute: 00),
                                    );
                                    time.text =
                                    "${picked?.hour.toString()}:${picked?.minute
                                        .toString()} ${picked?.period.name}";
                                  },
                                ),


                              ),
                            ),


                            Container(
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 20, top: 5, right: 20, bottom: 5),

                                  child: TextFormField(
                                    enableInteractiveSelection: false,
                                    controller: strLoc,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    style: TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      labelStyle: TextStyle(color: Colors.green),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(
                                            color: Colors.white),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(
                                            color: Colors.green),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(color: Colors.red),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(
                                            color: Colors.yellow),
                                      ),

                                      contentPadding:
                                      EdgeInsets.only(left: 20,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                      fillColor: Colors.green,
                                      labelText: "Starting Point",

                                      prefixIcon: Padding(
                                          padding: EdgeInsets.only(
                                              left: 2, right: 2),
                                          child: Icon(
                                            Icons.home,
                                            color: Color(0xFF00E676),
                                          )
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Starting Location can't be Empty";
                                      }
                                      return null;
                                    },

                                  ),


                                )
                            ),
                            Container(

                                color: Colors.transparent,


                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 20, top: 5, right: 20, bottom: 5),

                                  decoration: BoxDecoration(

                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20)),


                                  ),
                                  child: TextFormField(
                                    enableInteractiveSelection: false,
                                    controller: endLoc,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    style: TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      labelStyle: TextStyle(color: Colors.green),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(
                                            color: Colors.white),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(
                                            color: Colors.green),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(color: Colors.red),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(
                                            color: Colors.yellow),
                                      ),
                                      contentPadding:
                                      EdgeInsets.only(left: 20,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                      labelText: "End Point",
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.only(
                                              left: 2, right: 2),
                                          child: Icon(
                                            Icons.location_city,
                                            color: Color(0xFF00E676),
                                          )
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Desination can't be empty";
                                      }
                                      return null;
                                    },
                                  ),


                                )
                            ),


                            Container(
                                color: Colors.transparent,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 20, top: 5, right: 20, bottom: 5),


                                  child: TextFormField(
                                    enableInteractiveSelection: false,
                                    controller: pathName,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    style: TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      labelStyle: TextStyle(color: Colors.green),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(
                                            color: Colors.white),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(
                                            color: Colors.green),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(color: Colors.red),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(
                                            color: Colors.yellow),
                                      ),
                                      contentPadding:
                                      EdgeInsets.only(left: 20,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                      hintText: "Ex-NH-56",
                                      labelText: "Route Name",
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.only(
                                              left: 2, right: 2),
                                          child: Icon(
                                            Icons.route,
                                            color: Color(0xFF00E676),
                                          )
                                      ),
                                    ),

                                  ),


                                )
                            ),
                            Container(
                                color: Colors.transparent,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 20, top: 5, right: 20, bottom: 5),

                                  decoration: BoxDecoration(

                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20)),


                                  ),
                                  child: TextFormField(
                                    controller: presentSeats,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    textInputAction: TextInputAction.next,
                                    style: TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      labelStyle: TextStyle(color: Colors.green),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(
                                            color: Colors.white),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(
                                            color: Colors.green),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(color: Colors.red),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(
                                            color: Colors.yellow),
                                      ),
                                      contentPadding:
                                      EdgeInsets.only(left: 20,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                      labelText: "Available Seats",
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.only(
                                              left: 2, right: 2),
                                          child: Icon(
                                            Icons.event_available,
                                            color: Color(0xFF00E676),
                                          )
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Available Seats Can't be null";
                                      }
                                      return null;
                                    },
                                  ),


                                )
                            ),


                            Container(
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 20, top: 5, right: 20, bottom: 5),

                                  decoration: BoxDecoration(

                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20)),


                                  ),
                                  child: TextFormField(
                                    enableInteractiveSelection: false,
                                    controller: totalYatri,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    textInputAction: TextInputAction.next,
                                    style: TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      labelStyle: TextStyle(color: Colors.green),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(
                                            color: Colors.white),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(
                                            color: Colors.green),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(color: Colors.red),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(
                                            color: Colors.yellow),
                                      ),
                                      contentPadding:
                                      EdgeInsets.only(left: 20,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                      labelText: "Total Seats",
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.only(
                                              left: 2, right: 2),
                                          child: Icon(
                                            Icons.event_seat,
                                            color: Color(0xFF00E676),
                                          )
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Total Seats Can't be null";
                                      }
                                      return null;
                                    },
                                  ),


                                )
                            ),
                            Container(
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 20, top: 5, right: 20, bottom: 5),

                                  decoration: BoxDecoration(

                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20)),


                                  ),
                                  child: TextFormField(
                                    enableInteractiveSelection: false,
                                    controller: totalPrice,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    style: TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      labelStyle: TextStyle(color: Colors.green),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(
                                            color: Colors.white),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(
                                            color: Colors.green),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(color: Colors.red),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(
                                            color: Colors.yellow),
                                      ),
                                      contentPadding:
                                      EdgeInsets.only(left: 20,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                      labelText: "Price per Passenger",
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.only(
                                              left: 2, right: 2),
                                          child: Icon(
                                            Icons.money,
                                            color: Color(0xFF00E676),
                                          )
                                      ),
                                    ),

                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "price Can't be null";
                                      }
                                      return null;
                                    },
                                  ),


                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),


                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25)
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
                      onPressed: () async {
                        if (_formkey.currentState !.validate()) {
                          int totalSeats = int.parse(totalYatri.text);
                          int availableSeats = int.parse(presentSeats.text);
                          if (totalSeats > availableSeats && totalSeats <= 10) {
                            setState(() {
                              _isabsorbed = true;
                            });
                            EasyLoading.show(status: 'Saving');
                            String startLocation = strLoc.text.toLowerCase()
                                .trim();
                            String destination = endLoc.text.toLowerCase().trim();
                            String path = pathName.text.isNotEmpty ? pathName.text.trim(): "NA";

                            Map <String, dynamic> data = {
                              "Starting Point": startLocation,
                              "Ending Point": destination,
                              "Route Name": path,
                              "Passengers": "null",
                              "Available Seats": presentSeats.text,
                              "Total Passenger": totalYatri.text,
                              "Time": time.text.trim(),
                              "Price": totalPrice.text,
                            };


                            String sourceDestination = "$startLocation-$destination";
                            var firestoreDB = FirebaseFirestore
                                .instance.collection("rides")
                                .doc(sourceDestination)
                                .collection(dateCtl.text)
                                .doc(uid);
                            firestoreDB.get().then((value) async {
                              if (value.exists) {
                                EasyLoading.dismiss();
                                setState(() {
                                  _isabsorbed = false;
                                });
                                snackBar("Already Exist!", Colors.red);
                              } else {
                                firestoreDB.set(data);

                                await FirebaseFirestore.instance.collection(
                                    "user_data")
                                    .doc(uid)
                                    .collection("ride_created")
                                    .doc(dateCtl.text)
                                    .set({
                                  "Starting Point": startLocation,
                                  "Ending Point": destination,
                                  "Remaining Seats": presentSeats.text,
                                  "Timestamp": DateTime.now(),
                                }).then((value) {
                                  snackBar("Successful!", Colors.green);
                                  dateCtl.text = "";
                                  time.text = "";
                                  strLoc.text = "";
                                  endLoc.text = "";
                                  pathName.text = "";
                                  presentSeats.text = "";
                                  totalYatri.text = "";
                                  totalPrice.text = "";
                                  EasyLoading.dismiss();
                                  setState(() {
                                    _isabsorbed = false;
                                  });
                                });
                              }
                            });
                          } else {
                            return snackBar(
                                "Total seats are less than Available Seats OR greater than 10",
                                Colors.black);
                          }
                        }
                        // FirebaseFirestore.instance.collection("user_data").add(data);


                        //async


                      },
                      child: Text(
                        "Create".toUpperCase(), style: TextStyle(fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),),
                    ),
                  ),

                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
  void snackBar(String m, Color color){
    showTopSnackBar(
      context,
      CustomSnackBar.error(
        message: m, backgroundColor: color,
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