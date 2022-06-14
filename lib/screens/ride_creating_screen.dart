import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RideCreateScreen extends StatefulWidget {
  const RideCreateScreen({Key? key}) : super(key: key);

  @override
  State<RideCreateScreen> createState() => _RideCreateScreenState();
}



class _RideCreateScreenState extends State<RideCreateScreen> {

  late SharedPreferences preferences;
  late String name;
  late String mobileNumber;
  String photoUrl = "https://lh3.googleusercontent.com/a/AATXAJx0D6NV1PCZ9r_U6yWNLWWVd2vALY2PfVKuuu8J=s96-c";


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







  final _formkey=GlobalKey<FormState>();
  bool changeButton=false;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xffeceff1),

        body: Stack(
          children: [
            Positioned(
              top: 20,
              left: 5.0,
              right: 5.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white12,
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, top:10, right: 20, bottom:0),

                      decoration: const BoxDecoration(
                        color: Color(0xffeceff1),


                      ),

                        child: Container(
                          margin: EdgeInsets.only(left: 20, top:10, right: 20, bottom:10),
                          decoration:  BoxDecoration(
                            border: Border.all(
                              color: Colors.black
                            ),
                              borderRadius: BorderRadius.all(Radius.circular(12)),

                              color: Colors.white70,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xfffbe9e7),
                                  spreadRadius: 2,
                                  blurRadius: 10,

                                )
                              ]
                          ),

                          child:Column(
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
                                  padding: EdgeInsets.only(top: 16.0),
                                  child: Text(
                                    name,
                                    style: TextStyle(
                                      fontFamily: 'SF Pro',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24.0,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  padding: EdgeInsets.only(top: 16.0),
                                  child: Text(
                                    mobileNumber,
                                    style: TextStyle(
                                      fontFamily: 'SF Pro',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ),




                    ),

                  ],

                ),

              ),
            ),
            Positioned(
                top:250,
                bottom: 150,
                left: 10,
                right: 10,
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                          decoration: const BoxDecoration(

                              color: Color(0xffeceff1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 2,
                                  blurRadius: 10,

                                ),
                              ]
                          ),
                          child: Container(
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
                              controller: strLoc,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding:
                                EdgeInsets.only(left: 20, bottom: 11, top: 11, right: 15),
                                hintText: "Ex-Srinagar",labelText: "Starting Point",
                            ),
                          ),


                        )
                        ),
                        SizedBox(height: 5,),
                        Container(
                            height: 80,
                            decoration: const BoxDecoration(

                                color: Color(0xffeceff1),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 2,
                                    blurRadius: 10,

                                  ),
                                ]
                            ),
                            child: Container(
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
                                controller: endLoc,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding:
                                  EdgeInsets.only(left: 20, bottom: 11, top: 11, right: 15),
                                  hintText: "Ex-Dehradun",labelText: "End Point",
                                ),
                              ),


                            )
                        ),
                        Container(
                            height: 80,
                            decoration: const BoxDecoration(

                                color: Color(0xffeceff1),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 2,
                                    blurRadius: 10,

                                  ),
                                ]
                            ),
                            child: Container(
                              margin: EdgeInsets.only(left: 20, top:12, right: 20, bottom:12),

                              decoration: BoxDecoration(

                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                    color: Colors.black
                                ),


                              ),
                              child: TextFormField(
                                controller: dateCtl,
                                enableInteractiveSelection: false,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding:
                                  EdgeInsets.only(left: 20, bottom: 11, top: 11, right: 15),
                                  labelText: "JourneyDate",
                                ),
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
                            height: 80,
                            decoration: const BoxDecoration(

                                color: Color(0xffeceff1),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 2,
                                    blurRadius: 10,

                                  ),
                                ]
                            ),
                            child: Container(
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
                                controller: pathName,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding:
                                  EdgeInsets.only(left: 20, bottom: 11, top: 11, right: 15),
                                  hintText: "Ex-NH-56",labelText: "Route Name",
                                ),
                              ),


                            )
                        ),
                        Container(
                            height: 80,
                            decoration: const BoxDecoration(

                                color: Color(0xffeceff1),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 2,
                                    blurRadius: 10,

                                  ),
                                ]
                            ),
                            child: Container(
                              margin: EdgeInsets.only(left: 20, top:12, right: 20, bottom:12),

                              decoration: BoxDecoration(

                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                    color: Colors.black
                                ),


                              ),
                              child: TextFormField(
                                controller: presentSeats,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding:
                                  EdgeInsets.only(left: 20, bottom: 11, top: 11, right: 15),
                                  labelText: "Available Seats",
                                ),
                              ),


                            )
                        ),
                        Container(
                            height: 80,
                            decoration: const BoxDecoration(

                                color: Color(0xffeceff1),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 2,
                                    blurRadius: 10,

                                  ),
                                ]
                            ),
                            child: Container(
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
                                controller: totalYatri,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding:
                                  EdgeInsets.only(left: 20, bottom: 11, top: 11, right: 15),
                                  labelText: "Total Seats",
                                ),
                              ),


                            )
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
                          controller: time,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding:
                            EdgeInsets.only(left: 20, bottom: 11, top: 11, right: 15),
                            labelText: "Journey Time",
                          ),
                          onTap: () async{
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: const TimeOfDay(hour: 00, minute: 00),
                            );
                            time.text = "${picked?.hour.toString()}:${picked?.minute.toString()} ${picked?.period.name}";
                          },
                        ),


                      )



                      ],
                    ),
                  ),

                ),

            ),
            Positioned(
              bottom: 20,
                left: 30,
                right: 30,
                child: Container(
                  padding: EdgeInsets.only(top: 20,bottom: 20,left: 10,right: 10),
              color: Color(0xffeceff1),
                  child: InkWell(
                    child: Container(
                      margin: EdgeInsets.only(left: 20, top:5, right: 20, bottom:0),
                      height: 40,
                      width: 60,
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Colors.lightBlueAccent,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff80deea),
                            spreadRadius: 2,
                            blurRadius: 5,
                          )
                        ]

                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Book Ride'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,

                          ),
                        ),
                      ),),
                    onTap: (){

                      Map <String, dynamic> data={
                        "Starting Point": strLoc.text,
                        "Ending Point": endLoc.text,
                        "Route Name": pathName.text,
                        "Registration Date": DateTime.now(),
                        "Available Seats": presentSeats.text,
                        "Total Passenger": totalYatri.text,
                        "Time": time.text,
                      };
                      String? uid = preferences.getString("uid");


                      String sourceDestination = strLoc.text.toLowerCase() + endLoc.text.toLowerCase();
                      FirebaseFirestore.instance.collection("rides").doc(sourceDestination).collection(dateCtl.text).doc(uid!).set(data);
                      // FirebaseFirestore.instance.collection("user_data").add(data);
                    },
                  ),

                  ),
            ),


          ],

        )

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
}