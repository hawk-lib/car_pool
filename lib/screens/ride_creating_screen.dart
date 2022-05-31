

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
return Material(
  color: Colors.white,
  child: SingleChildScrollView(
    child: Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formkey,
      child: Column(
        children: [
          const SizedBox(
            height: 50.0,
          ),
          const Text("Create A Happy Ride",
            style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
           Text(name,
            style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
          Text(mobileNumber,
            style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:16.0, horizontal: 32.0),
            child: Column(children: [
              TextFormField(
                controller: strLoc,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: "Ex-Srinagar",labelText: "Starting Point",

                ),
                validator: (value){
                  if(value==null || value.isEmpty){
                    return "Starting is not empty";
                  }
                  return null;
                },



              ),
              TextFormField(
                controller: endLoc,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: "Ex-Dehradun",labelText: "Ending Point",

                ),
                validator: (value){
                  if(value==null || value.isEmpty){
                    return "EndingPoint is not empty";
                  }
                  return null;
                },



              ),
              TextFormField(
                controller: pathName,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: "Ex-NH-xy",labelText: "Route Name",

                ),
                validator: (value){
                  if(value==null || value.isEmpty){
                    return "Routes cant be empty";
                  }
                  return null;
                },



              ),
              TextFormField(
                controller: dateCtl,
                decoration: const InputDecoration(
                  labelText: "Journey Date",
                  ),
                onTap: () async{
                  DateTime ? date = DateTime(1900);
                  FocusScope.of(context).requestFocus(FocusNode());
                  date = await showDatePicker(
                      context: context,
                      initialDate:DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100));

                  dateCtl.text = "${date?.year}-${date?.month}-${date?.day}";
                },



                validator: (value){
                  if(value==null || value.isEmpty){
                    return "DateCant be empty is not empty";
                  }
                  return null;
                },


              ),
              TextFormField(
                controller: time,
                decoration: const InputDecoration(
                  labelText: "Journey Time",
                ),
                onTap: () async{
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: const TimeOfDay(hour: 00, minute: 00),
                  );
                  time.text = "${picked?.hour.toString()}:${picked?.minute.toString()} ${picked?.period.name}";
                },



                validator: (value){
                  if(value==null || value.isEmpty){
                    return "DateCant be empty is not empty";
                  }
                  return null;
                },


              ),

              TextFormField(
                controller: presentSeats,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Available Seats",

                ),
                validator: (value){
                  if(value==null || value.isEmpty){
                    return "User name is not empty";
                  }
                  return null;
                },


              ),
              TextFormField(
                controller: totalYatri,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Total Passenger",

                ),
                validator: (value){
                  if(value==null || value.isEmpty){
                    return "User name is not empty";
                  }
                  return null;
                },



              ),

              const SizedBox(
                height: 50.0,
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: Material(

                  child: InkWell(
                    splashColor: Colors.greenAccent,
                    onTap: () async {
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


                      String sourceDestination = strLoc.text.toUpperCase() + endLoc.text.toUpperCase();
                      FirebaseFirestore.instance.collection("rides").doc(sourceDestination).collection(dateCtl.text).doc(uid!).set(data);
                      // FirebaseFirestore.instance.collection("user_data").add(data);

                    },
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 10),
                      width: 150,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Colors.red
                      ),
                      child: changeButton
                          ?const Icon(
                          Icons.done
                      )
                          : const Text("Create-Ride",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),

                    ),
                  ),
                ),

                // child: ElevatedButton(onPressed: () {
                //
                //   Navigator.pushNamed(context, MyRoutes.loginRoute);},
                // style: ButtonStyle(
                //   shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),
                //   side: const BorderSide(color: Colors.red))),
                //   backgroundColor: MaterialStateProperty.all(Colors.teal)
                // ),
                //     child: const Text("login")),
              )
            ],),
          )


        ],
      ),
    ),
  ),

          ) ;
      }

  void init () async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      mobileNumber = preferences.getString("mobile_number")!;
      name = preferences.getString("displayName")!;
    });
  }
}