import 'package:car_pool/screens/ride_booking_screen.dart';
import 'package:car_pool/utility/rides.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchRide extends StatefulWidget {
  const SearchRide({Key? key}) : super(key: key);

  @override
  State<SearchRide> createState() => _SearchRideState();
}

class _SearchRideState extends State<SearchRide>  {
  List<Rides> list = [];
  TextEditingController sourceLoc = TextEditingController();
  TextEditingController destinationLoc = TextEditingController();
  TextEditingController dateCtl = TextEditingController();
  TextEditingController timeCtl = TextEditingController();

  bool changeButton=false;
  bool search = false;
  DatabaseReference db = FirebaseDatabase.instance.reference();



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
          Container(
          width: double.infinity,
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Color(0xFF00E676), Color(0xFFB3F6CA)]),

            ),

          child: Column(
            children: [

              Container(
                height: 40,
                width: 200,
                margin: EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Colors.white
                ),
                child: TextFormField(
                  controller: sourceLoc,
                  decoration: const InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      prefixIcon: Padding(padding: EdgeInsets.only(left: 2,right: 2),
                        child: Icon(
                          Icons.home,
                          color: Color(0xFF00E676),
                        )
                      ),
                      contentPadding:
                      EdgeInsets.only(left: 5, bottom: 11, top: 11, right: 5),
                      hintText: "source Location"
                  ),
                ),
              ),
              Container(
                height: 40,
                width: 200,
                margin: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Colors.white
                ),
                child: TextFormField(
                  controller: destinationLoc,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      prefixIcon: Padding(padding: EdgeInsets.only(left: 2,right: 2),
                          child: Icon(
                            Icons.location_city,
                            color: Color(0xFF00E676),
                          )
                      ),
                      contentPadding:
                      EdgeInsets.only(left: 20, bottom: 11, top: 11, right: 15),
                      hintText: "Destination Location"
                  ),

                ),
              ),


             Row(children: [
              Container(
                height: 40,
                width: 200,
                margin: EdgeInsets.only(top: 10,left: 80,right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Colors.white
                ),
                child: TextFormField(
                  controller: dateCtl,
                  enableInteractiveSelection: false,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    prefixIcon: Padding(padding: EdgeInsets.only(left: 2,right: 2),
                        child: Icon(
                          Icons.date_range,
                          color: Color(0xFF00E676),
                        )
                    ),
                      contentPadding:
                      EdgeInsets.only(left: 20, bottom: 11, top: 11, right: 15),
                      hintText: "JourneyDate",
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
              ),
               Container(
                 margin: EdgeInsets.only(top: 10),
                 child: ElevatedButton(
                     style: ButtonStyle(
                         foregroundColor: MaterialStateProperty.all<Color>(Colors.green),
                         backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                         shape: MaterialStateProperty.all(RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(20),
                         ))
                     ),
                            onPressed: ()
                            async {
                       EasyLoading.show(status: "please wait");
                              DatabaseReference dbRef = FirebaseDatabase.instance
                                  .ref("user_data");

                              QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                                  .collection("rides")
                                  .doc(
                                  "${sourceLoc.text.toLowerCase()}${destinationLoc
                                      .text.toLowerCase()}")
                                  .collection(dateCtl.text)
                                  .get();
                       querySnapshot.docs.forEach((doc) async {
                         late String name;
                         late String photoUrl;
                         late String mobileNumber;
                         late String email;
                         late String time;
                         late String price;

                         DatabaseEvent event = await dbRef.child(doc.id)
                             .once();
                         name = event.snapshot
                             .child("name")
                             .value
                             .toString();
                         mobileNumber = event.snapshot
                             .child("mobileNumber")
                             .value
                             .toString();
                         email = event.snapshot
                             .child("email")
                             .value
                             .toString();
                         photoUrl = event.snapshot
                             .child("photoUrl")
                             .value
                             .toString();



                         list.add(Rides(
                           doc["Starting Point"],
                           doc["Ending Point"],
                           dateCtl.text,
                           doc.id,
                           name,
                           photoUrl,
                           mobileNumber,
                           email,
                           doc["Total Passenger"],
                           doc["Time"],
                           doc["Route Name"],
                           doc["Price"],

                         )

                         );
                         setState(() {
                           EasyLoading.dismiss();
                           search = true;
                         });

                         /*
                      //Read data from list
                      Rides rides = list[0];
                      print(rides.name);
                      print(rides.photoUrl);
                      print(rides.time);
                      print(list[0].name);
                      */

                       });


                            }


                          , child: Icon(
                             Icons.search
                            )),
                            )
                            ]
                            ),

            ],


          ),
      ),


              if (list.isNotEmpty)...[

                Container(
                  width: double.infinity,
                  height: 300,//next day
                  color: Colors.white,
                  child: ListView.builder(

                    itemCount: list.length,
                      itemBuilder: (context,index){
                        Rides rides = list[index];
                        return Card(
                          child: ListTile(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                            title: Text(rides.name),
                            leading: CircleAvatar(
                              backgroundImage: Image.network(list[index].photoUrl).image,
                            ),
                            subtitle: Text(rides.time),
                            trailing: Text(rides.price),


                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>  RideBookScreen(list[index])));
                            },
                          ),
                        );
                      }),
                )
              ]else if(search)...[
                Text("Not Available!"),
              ]else...[
                Text("Enter data!"),
              ]
            ],
          ),
        ),
      ),

    );
  }

  viewSubTitle(String id) {
    DatabaseReference db = FirebaseDatabase.instance.reference();
    db.child("user_data").child("name").once().then((value){
      String val = value.snapshot.value.toString();
      print(val);

      //return Text(val);
    });
    db.child("user_data").child("photoUrl").once().then((value) {
      String val = value.snapshot.value.toString();
      print(val);
    });
    return Text("data");
  }

  String getStartingPoint() {

    Rides ride = list[0];
    return ride.source;
  }
  
  
}
