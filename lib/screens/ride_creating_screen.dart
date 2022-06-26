import 'dart:async';
import 'dart:ui';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  bool _isabsorbing=false;
  bool createrideDisabled = true;
  late SharedPreferences preferences;
  String name = "";
  String mobileNumber = "";
  String photoUrl = "https://lh3.googleusercontent.com/a/AATXAJx0D6NV1PCZ9r_U6yWNLWWVd2vALY2PfVKuuu8J=s96-c";
  final _formkey=GlobalKey<FormState>();
  @override
  void initState(){
    init();
    super.initState();
  }

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
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(

            body: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/background/road.jpg"),
                  fit: BoxFit.cover
                )
              ),
              child: SafeArea(
                  child: AbsorbPointer(
                    absorbing: _isabsorbing,
                    child: Stack(
                    children: [
                      Positioned(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Column(
                            children: [
                              Container(

                                decoration: const BoxDecoration(
                                  color: Colors.transparent,


                                ),

                                  child: Container(
                                    margin: EdgeInsets.only(  bottom:5),
                                    decoration:  BoxDecoration(
                                      borderRadius: new BorderRadius.only(
                                        bottomLeft: const Radius.circular(130.0),
                                        bottomRight: const Radius.circular(130.0),
                                        
                                      ),
                                     // gradient: LinearGradient(
                                      //    begin: Alignment.bottomLeft,
                                       //   end: Alignment.topRight,
                                         // colors: [Color(0xFF00E676), Color(0xFFB3F6CA)]
                                      // ),
                                      color: Colors.tealAccent.withOpacity(0.2)

                                    ),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 40,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 12,
                                                child: Icon(Icons.camera_alt,size: 15.0, color: Color(0xFF404040),
                                                ),
                                              ),
                                            ),
                                            radius: 38.0,
                                            backgroundImage: Image.network(photoUrl).image,

                                          ),

                                        ),
                                        SizedBox(height: 10,),
                                        Center(
                                          child: Container(
                                            padding: EdgeInsets.only(top: 10.0),
                                            child: Text(
                                              name.toUpperCase(),
                                              style: TextStyle(
                                                fontFamily: 'SF Pro',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 24.0,
                                                color: Colors.white
                                              ),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Container(
                                            padding: EdgeInsets.only(top: 10.0,bottom: 5),
                                            child: Text(
                                              mobileNumber,
                                              style: TextStyle(
                                                fontFamily: 'SF Pro',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 24.0,
                                                color: Colors.white
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                  ),




                              ),

                            ],

                          ),

                        ),
                      ),
                      Positioned(
                          top: 200,
                          left: 10,
                          right: 10,
                          bottom: 50,
                            child: Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: BlurryContainer(
                                blur: 5,
                                elevation: 1,
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.all(Radius.circular(25)),

                                child: SingleChildScrollView(
                                  child: Form(
                                    key: _formkey,
                                    child: Column(
                                      children: [


                                        Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.transparent,
                                            ),
                                            child: Container(
                                              margin: EdgeInsets.only(left: 20, top:5, right: 20, bottom:5),
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius: BorderRadius.all(Radius.circular(20)),



                                              ),
                                              child: TextFormField(
                                                enableInteractiveSelection: false,
                                                controller: strLoc,
                                                keyboardType: TextInputType.text,
                                                decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder: InputBorder.none,
                                                  disabledBorder: InputBorder.none,
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Color(0xFFF1F1F1)),
                                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                  ),

                                                  contentPadding:
                                                  EdgeInsets.only(left: 20, bottom: 11, top: 11, right: 15),
                                                  hintText: "Srinagar",
                                                  labelText: "startingPoint",
                                                  prefixIcon: Padding(padding: EdgeInsets.only(left: 2,right: 2),
                                                      child: Icon(
                                                        Icons.home,
                                                        color: Color(0xFF00E676),
                                                      )
                                                  ),
                                                ),
                                                validator: (value){
                                                  if(value==null || value.isEmpty){
                                                    return "Starting Location is not Empty";
                                                  }
                                                  return null;
                                                },

                                              ),


                                            )
                                        ),
                                        Container(

                                                color: Colors.transparent,


                                            child: Container(
                                              margin: EdgeInsets.only(left: 20, top:5, right: 20, bottom:5),

                                              decoration: BoxDecoration(

                                                color: Colors.transparent,
                                                borderRadius: BorderRadius.all(Radius.circular(20)),



                                              ),
                                              child: TextFormField(
                                                enableInteractiveSelection: false,
                                                controller: endLoc,
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
                                                  hintText: "Ex-Dehradun",labelText: "End Point",
                                                  prefixIcon: Padding(padding: EdgeInsets.only(left: 2,right: 2),
                                                      child: Icon(
                                                        Icons.location_city,
                                                        color: Color(0xFF00E676),
                                                      )
                                                  ),
                                                ),
                                                validator: (value){
                                                  if(value==null || value.isEmpty){
                                                    return "Desination is not null";
                                                  }
                                                  return null;
                                                },
                                              ),


                                            )
                                        ),
                                        Container(
                                           color: Colors.transparent,
                                            child: Container(
                                              margin: EdgeInsets.only(left: 20, top:5, right: 20, bottom:5),

                                              decoration: BoxDecoration(

                                                color: Colors.transparent,
                                                borderRadius: BorderRadius.all(Radius.circular(20)),



                                              ),
                                              child: TextFormField(
                                                controller: dateCtl,
                                                enableInteractiveSelection: false,
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
                                                  labelText: "JourneyDate",
                                                  prefixIcon: Padding(padding: EdgeInsets.only(left: 2,right: 2),
                                                      child: Icon(
                                                        Icons.date_range,
                                                        color: Color(0xFF00E676),
                                                      )
                                                  ),
                                                ),
                                                validator: (value){
                                                  if(value==null || value.isEmpty){
                                                    return "Date can't be null";
                                                  }
                                                  return null;
                                                },
                                                onTap: () async {
                                                  DateTime ? date = DateTime(1900);
                                                  FocusScope.of(context).requestFocus(FocusNode());
                                                  date = await showDatePicker(
                                                      context: context,
                                                      initialDate:DateTime.now(),
                                                      firstDate: DateTime.now(),
                                                      lastDate: DateTime(2100));

                                                  dateCtl.text = "${date?.year}-${date?.month}-${date?.day}";
                                                },
                                              ),


                                            )
                                        ),
                                        Container(
                                            color: Colors.transparent,
                                            child: Container(
                                              margin: EdgeInsets.only(left: 20, top:5, right: 20, bottom:5),

                                              decoration: BoxDecoration(

                                                color: Colors.transparent,
                                                borderRadius: BorderRadius.all(Radius.circular(20)),



                                              ),
                                              child: TextFormField(
                                                enableInteractiveSelection: false,
                                                controller: pathName,
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
                                                  hintText: "Ex-NH-56",labelText: "Route Name",
                                                  prefixIcon: Padding(padding: EdgeInsets.only(left: 2,right: 2),
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
                                              margin: EdgeInsets.only(left: 20, top:5, right: 20, bottom:5),

                                              decoration: BoxDecoration(

                                                color: Colors.transparent,
                                                borderRadius: BorderRadius.all(Radius.circular(20)),



                                              ),
                                              child: TextFormField(
                                                controller: presentSeats,
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
                                                  labelText: "Available Seats",
                                                  prefixIcon: Padding(padding: EdgeInsets.only(left: 2,right: 2),
                                                      child: Icon(
                                                        Icons.event_available,
                                                        color: Color(0xFF00E676),
                                                      )
                                                  ),
                                                ),
                                                validator: (value){
                                                  if(value==null || value.isEmpty){
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
                                              margin: EdgeInsets.only(left: 20, top:5, right: 20, bottom:5),

                                              decoration: BoxDecoration(

                                                color: Colors.transparent,
                                                borderRadius: BorderRadius.all(Radius.circular(20)),



                                              ),
                                              child: TextFormField(
                                                enableInteractiveSelection: false,
                                                controller: totalYatri,
                                                keyboardType: TextInputType.text,
                                                decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder: InputBorder.none,
                                                  disabledBorder: InputBorder.none,
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Color(0xFFF1F1F1)),
                                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                  ),
                                                  contentPadding:
                                                  EdgeInsets.only(left: 20, bottom: 11, top: 11, right: 15),
                                                  labelText: "Total Seats",
                                                  prefixIcon: Padding(padding: EdgeInsets.only(left: 2,right: 2),
                                                      child: Icon(
                                                        Icons.event_seat,
                                                        color: Color(0xFF00E676),
                                                      )
                                                  ),
                                                ),
                                              ),


                                            )
                                        ),
                                        Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.transparent,
                                            ),
                                            child: Container(
                                              margin: EdgeInsets.only(left: 20, top:5, right: 20, bottom:5),

                                              decoration: BoxDecoration(

                                                color: Colors.transparent,
                                                borderRadius: BorderRadius.all(Radius.circular(20)),



                                              ),
                                              child: TextFormField(
                                                enableInteractiveSelection: false,
                                                controller: totalPrice,
                                                keyboardType: TextInputType.text,
                                                decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder: InputBorder.none,
                                                  disabledBorder: InputBorder.none,
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Color(0xFFF1F1F1)),
                                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                  ),
                                                  contentPadding:
                                                  EdgeInsets.only(left: 20, bottom: 11, top: 11, right: 15),
                                                  labelText: "Price",
                                                  prefixIcon: Padding(padding: EdgeInsets.only(left: 2,right: 2),
                                                      child: Icon(
                                                        Icons.event_seat,
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
                                        margin: EdgeInsets.only(left: 20, top:5, right: 20, bottom:5),

                                        decoration: BoxDecoration(

                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.all(Radius.circular(20)),


                                        ),
                                        child: TextFormField(
                                          controller: time,
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
                                            labelText: "Journey Time",
                                            prefixIcon: Padding(padding: EdgeInsets.only(left: 2,right: 2),
                                                child: Icon(
                                                  Icons.timeline,
                                                  color: Color(0xFF00E676),
                                                )
                                            ),
                                          ),
                                          validator: (value){
                                            if(value==null || value.isEmpty){
                                              return "Time Can't be null ";
                                            }
                                            return null;
                                          },
                                          onTap: () async{
                                            final TimeOfDay? picked = await showTimePicker(
                                              context: context,
                                              initialTime: const TimeOfDay(hour: 00, minute: 00),
                                            );
                                            time.text = "${picked?.hour.toString()}:${picked?.minute.toString()} ${picked?.period.name}";
                                          },
                                        ),


                                      ),
                                      ),



                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),


                      ),
                      Positioned(
                        bottom: 10,
                          left: 30,
                          right: 30,

                            child: SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.indigoAccent),
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ))
                                ),
                                onPressed: ()async{
                                  int totalSeats = int.parse(totalYatri.text);
                                  int availableSeats = int.parse(presentSeats.text);



                                  if(totalSeats>availableSeats){

    _isabsorbing=true;
    if (_formkey.currentState !.validate()) {
    Map <String, dynamic> data = {
    "Starting Point": strLoc.text,
    "Ending Point": endLoc.text,
    "Route Name": pathName.text,
    "Available Seats": presentSeats.text,
    "Total Passenger": totalYatri.text,
    "Time": time.text,
    "Price": totalPrice.text,
    };
    String? uid = preferences.getString("uid");


    String sourceDestination = strLoc.text
          .toLowerCase() + endLoc.text.toLowerCase();
    var firestoreDB = await FirebaseFirestore
          .instance.collection("rides")
          .doc(sourceDestination)
          .collection(dateCtl.text)
          .doc(uid!);
    EasyLoading.show(status: 'loading').timeout(
    Duration(minutes: 100));
    firestoreDB.get().then((value) async {
    if (value.exists) {
    EasyLoading.dismiss();
    _isabsorbing = false;
    return dialogbox();
    } else {
    firestoreDB.set(data);

    await FirebaseFirestore.instance.collection(
    "user_data")
          .doc(preferences.getString("uid"))
          .collection("ride_created")
          .doc(dateCtl.text)
          .set({
    "Starting Point": strLoc.text,
    "Ending Point": endLoc.text,
    "Remaining Seats": presentSeats.text,
    "Timestamp": DateTime.now().toString(),
    }).then((value) {
    EasyLoading.dismiss();
    EasyLoading.showSuccess("successful");
    Timer(const Duration(seconds: 2),
    () => Navigator.pop(context)

    );
    });
    }
    });

    }
    }else{
               return snackBar("Total seats are less than Available Seats");
    }
                                    // FirebaseFirestore.instance.collection("user_data").add(data);


                                    //async


                                },child: Text("Create".toUpperCase(),style: TextStyle(fontSize: 20,
                                  color: Colors.white,
                              fontWeight: FontWeight.w300),),
                              ),
                            )

                            ),


                    ],

          ),
                  ),
              ),
            )

        ),
      ),
    );
      }

  void init () async {
    preferences = await SharedPreferences.getInstance();

    setState(() {
      photoUrl = preferences.getString("photoUrl")!;
      mobileNumber = preferences.getString("mobile_number")!;
      name = preferences.getString("displayName")!;
    });
  }
  void dialogbox() {
    showDialog(context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Already Exist'),
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
                Text(""
                    "Check your history",textAlign: TextAlign.center,style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold),),
              ],
            ),
            actionsPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            alignment: Alignment.center,

          );
        }
    );
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