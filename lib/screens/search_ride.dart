import 'package:car_pool/controllers/search_ride.dart';
import 'package:car_pool/screens/ride_booking_screen.dart';
import 'package:car_pool/utility/rides.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SearchRide extends StatefulWidget {
  const SearchRide({Key? key}) : super(key: key);

  @override
  State<SearchRide> createState() => _SearchRideState();
}

class _SearchRideState extends State<SearchRide>  {
  final SearchRideController controller = Get.put(SearchRideController());

  List<Rides> list = [];
  TextEditingController sourceLoc = TextEditingController();
  TextEditingController destinationLoc = TextEditingController();
  TextEditingController dateCtl = TextEditingController();
  TextEditingController timeCtl = TextEditingController();


  DatabaseReference db = FirebaseDatabase.instance.reference();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime ? date = DateTime.now();
    dateCtl.text = "${date?.year}-${date?.month}-${date?.day}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return AbsorbPointer(
          absorbing: controller.isAbsorbed.isTrue,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 20, bottom: 20),
                color: Colors.lightBlue,
                child: SafeArea(
                  child: SizedBox(

                    child: Column(
                      children: [

                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: sourceLoc,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(15)),
                                  borderSide: BorderSide(color: Colors.black),
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
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.all(5.0),
                                prefixIcon: Icon(
                                  Icons.home,
                                  color: Color(0xFF00E676),
                                ),
                                hintText: "Source Location"
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(15)),
                              color: Colors.white
                          ),
                          child: TextFormField(
                            controller: destinationLoc,
                            textInputAction: TextInputAction.done,
                            decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(15)),
                                  borderSide: BorderSide(color: Colors.black),
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
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.all(5.0),
                                prefixIcon: Icon(
                                  Icons.location_city,
                                  color: Color(0xFF00E676),
                                ),
                                hintText: "Destination Location"
                            ),

                          ),
                        ),


                        Row(children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(15)),
                                  color: Colors.white
                              ),
                              child: TextFormField(
                                controller: dateCtl,
                                enableInteractiveSelection: false,
                                decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15)),
                                    borderSide: BorderSide(color: Colors.black),
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
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.all(5.0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.only(
                                          left: 2, right: 2),
                                      child: Icon(
                                        Icons.date_range,
                                        color: Color(0xFF00E676),
                                      )
                                  ),

                                  hintText: "JourneyDate",
                                ),
                                onTap: () async {
                                  DateTime ? date = DateTime(1900);
                                  FocusScope.of(context).requestFocus(
                                      FocusNode());
                                  date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2100));

                                  if(date?.month == null){

                                  }else {
                                    dateCtl.text = "${date?.year}-${date?.month}-${date?.day}";
                                  }
                                },
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all<
                                      Color>(Colors.green),
                                  backgroundColor: MaterialStateProperty.all<
                                      Color>(Colors.white),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40),
                                      ))
                              ),
                              child: Icon(
                                  Icons.search
                              ),

                              onPressed: () async {
                                String source = sourceLoc.text.toLowerCase().trim();
                                String destination = destinationLoc.text.toLowerCase().trim();
                                String date = dateCtl.text;
                                if (source.isEmpty || destination.isEmpty || date.isEmpty) {
                                  snackBar("Enter details correctly!", Colors.red);
                                } else {
                                  controller.source.value = source;
                                  controller.destination.value = destination;
                                  controller.date.value = date;
                                  controller.list.clear();
                                  controller.aSyncData();
                                }
                              }

                              ,),
                          )
                        ]
                        ),

                      ],


                    ),
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (controller.source.value.isEmpty) {
                    return Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("The World", style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w700,
                            fontSize: 25),),
                        Text("is waiting for YOU", style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w700,
                            fontSize: 25),),
                        Text("Travel Safe", style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w700,
                            fontSize: 25),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("GO!", style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w700,
                              fontSize: 25),),
                        ),


                      ],
                    ),);
                  } else if (controller.noData.isTrue) {
                    return Center(child: Text(
                      "No Data Found!", style: TextStyle(fontWeight: FontWeight
                        .w700, fontSize: 25),),);
                  } else if (controller.list.isEmpty) {
                    return Center(child: Text(
                      "Loading...",
                      style: TextStyle(fontWeight: FontWeight.w700,
                          fontSize: 25),),);
                  } else {
                    return Container(
                      child: ListView.builder(

                          itemCount: controller.list.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                title: Hero(tag: "profileName",
                                    child: Text(controller.list[index].name)),
                                leading: Hero(
                                  tag: "profilePic",
                                  child: CircleAvatar(
                                    radius: 22,
                                    backgroundColor: Colors.green,
                                    child: CircleAvatar(
                                      backgroundImage: Image
                                          .network(
                                          controller.list[index].photoUrl)
                                          .image,
                                    ),
                                  ),
                                ),
                                subtitle: Text(controller.list[index].time),
                                trailing: Text(
                                    "Price : ${controller.list[index]
                                        .price} Rs"),


                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          RideBookScreen(
                                              controller.list[index])));
                                },
                              ),
                            );
                          }),
                    );
                  }
                }),
              ),

            ],
          ),
        );
      }
      ),
    );
  }



  @override
  void dispose() {
    // TODO: implement dispose
    controller.list.clear();
    controller.source.value= "";
    controller.destination.value= "";
    controller.date.value= "";
    if(EasyLoading.isShow){
      EasyLoading.dismiss();
    }
    super.dispose();
  }

  void snackBar(String m, Color color){
    showTopSnackBar(
      context,
      CustomSnackBar.error(
        message: m, backgroundColor: color,
      ),
    );
  }


}
