import 'package:car_pool/screens/ride_booking_screen.dart';
import 'package:car_pool/utility/rides.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchRide extends StatefulWidget {
  const SearchRide({Key? key}) : super(key: key);

  @override
  State<SearchRide> createState() => _SearchRideState();
}

class _SearchRideState extends State<SearchRide> {
  List<String> list1 = [];
  TextEditingController sourceLoc = TextEditingController();
  TextEditingController destinationLoc = TextEditingController();
  TextEditingController dateCtl = TextEditingController();
  bool changeButton=false;
  bool search = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
        Container(
        margin: EdgeInsets.only(top: 20),
        width: double.infinity,
        height: 304,
        decoration: BoxDecoration(
            color: Colors.blueAccent,
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
                colors: [
                  Colors.indigo,
                  Colors.blueAccent
                ]
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey ,
                  blurRadius: 2.0,
                  offset: Offset(2.0,2.0)
              )
            ]
        ),
        child: Column(
          children: [
            Container(
              height: 40,
              width: 200,
              child:  Align(
                alignment: Alignment.center,
                child: Text(
                  'Search your Ride'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,

                  ),
                ),
              ),),

            Container(
              height: 40,
              width: 200,
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Colors.white
              ),
              child: TextFormField(
                controller: sourceLoc,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                    EdgeInsets.only(left: 20, bottom: 11, top: 11, right: 15),
                    hintText: "source Location"
                ),
              ),
            ),
            Container(
              height: 40,
              width: 200,
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Colors.white
              ),
              child: TextFormField(
                controller: destinationLoc,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                    EdgeInsets.only(left: 20, bottom: 11, top: 11, right: 15),
                    hintText: "Destination Location"
                ),

              ),
            ),



            Container(
              height: 40,
              width: 200,
              margin: EdgeInsets.only(top: 20),
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





            InkWell(
              child: Container(
                margin: EdgeInsets.only(top: 40),
                height: 40,
                width: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Colors.orange,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orangeAccent,
                        spreadRadius: 2,
                        blurRadius: 5,
                      )
                    ]

                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Search Ride'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,

                    ),
                  ),
                ),
              ),
              onTap: () async {

                List<Rides> list = [];
                DatabaseReference dbRef = FirebaseDatabase.instance.reference();

                await FirebaseFirestore.instance
                    .collection("rides")
                    .doc("${sourceLoc.text.toLowerCase()}${destinationLoc.text.toLowerCase()}")
                    .collection(dateCtl.text)
                    .get()
                    .then((QuerySnapshot querySnapshot) {
                  querySnapshot.docs.forEach((doc) async {
                    late String name;
                    late String photoUrl;
                    late String mobileNumber;
                    late String email;

                    await dbRef.child(doc.id).once().then((values) {
                      photoUrl = values.snapshot.child("photoUrl").value.toString();
                      name = values.snapshot.child("name").value.toString();
                      mobileNumber = values.snapshot.child("mobileNumber").value.toString();
                      email = values.snapshot.child("email").value.toString();

                    });

                    list.add(Rides(
                        doc["source"],
                        doc["destination"],
                        dateCtl.text,
                        doc.id,
                        name,
                        photoUrl,
                        mobileNumber,
                        email,
                        doc["totalSeats"],
                        doc["time"],
                        doc["route"]));
                    print(doc["route"]+ " " +name);

                    /*
                    //Read data from list
                    Rides rides = list[index];
                    print(rides.name);
                    print(rides.photoUrl);
                    print(rides.time);
                    */

                  });
                });
                setState(() {
                  search = true;
                });
              })

          ],


        ),
      ),


            if (search)...[
              Container(
                width: double.infinity,
                height: 300,
                color: Colors.red,
                child: StreamBuilder<QuerySnapshot> (
                  stream: FirebaseFirestore.instance.collection('rides').doc("${sourceLoc.text.toLowerCase()}${destinationLoc.text.toLowerCase()}").collection(dateCtl.text).snapshots(),
                  builder: (context,snapshot) {
                    if (!snapshot.hasData) {
                      print('No Data...');
                      return const Text("No data");
                    }
                    if (snapshot.hasError) {
                      print('error');
                      return const Text("Error");
                    }
                    if(snapshot.hasData){
                      List picUrl = [];
                      print(list1);

                      for(int i=0; i<snapshot.data!.docs.length; i++){
                        DocumentSnapshot data = snapshot.data?.docs[i] as DocumentSnapshot<Object?>;
                        FutureBuilder<DocumentSnapshot> (
                            future: FirebaseFirestore.instance.collection('user_data').doc(data.id).get(),
                            builder: (context,snapshot2) {
                              if (!snapshot2.hasData) {
                                print('No Data...');
                                return const Text("No data");
                              }else {
                                picUrl.add(snapshot2.data!.get('Name'));
                                print(snapshot2.data!.get('Name'));
                                return const Text("found");
                              }
                            });

                      }



                      return ListView.builder(itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                        String val = '';
                            DocumentSnapshot data = snapshot.data?.docs[index] as DocumentSnapshot<Object?>;

                            return Container(
                              child: ListTile(
                                title: Text(data.id),
                                subtitle: Text(val),
                              ),
                            );
                          });
                      //return const Text("found");
                    }
                    return Center(child: CircularProgressIndicator());
                  }
                ),
              )
            ]else...[
              Text("Enter Source and Destination"),
            ]
          ],
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
    return Text("data");
  }
}
