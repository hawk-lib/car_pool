import 'package:car_pool/utility/dataControler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RideBookScreen extends StatefulWidget {
   const RideBookScreen({Key? key}) : super(key: key);

  @override
  State<RideBookScreen> createState() => _RideBookScreenState();
}

class _RideBookScreenState extends State<RideBookScreen> {

  TextEditingController dateCtl = TextEditingController();
  TextEditingController startSearch = TextEditingController();
  TextEditingController totalSeatBook = TextEditingController();
  bool changeButton=false;



  @override



  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: 200,
            margin: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 10),
            color: Colors.red,
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: 300,
                  margin: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                  color: Colors.white,
                  child: Align(
                    alignment: Alignment.center,
                  child: Text(
                'UserName'.toUpperCase(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,

                ),
              ),
            ),
                ),
                Container(
                  height: 50,
                  width: 300,
                  margin: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                  color: Colors.white,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'sourceLocation'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,

                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 300,
                  margin: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                  color: Colors.white,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Destination Location'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,

                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 300,
                  margin: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                  color: Colors.white,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Date'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,

                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 300,
                  margin: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                  color: Colors.white,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'time'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,

                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 300,
                  margin: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                  color: Colors.white,
                  child: Align(
                    alignment: Alignment.center,
                    child: TextFormField(
                      enableInteractiveSelection: false,
                      controller: totalSeatBook,
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
                  ),
                ),


                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(top: 40,bottom: 20),
                    height: 40,
                    width: 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Colors.blueAccent,
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
                        'Book Now'.toUpperCase(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,

                        ),
                      ),
                    ),
                  ),
                  onTap: (){








                    Navigator.push(context, MaterialPageRoute(builder: (context)=>RideBookScreen()));
                  },
                ),
              ],
            ),
          ),
        ),

      )
    );

  }

}

