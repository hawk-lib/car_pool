

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:car_pool/utility/rides.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/book_ride_history.dart';
import '../utility/appPreferences.dart';

class BookRideHistory extends StatefulWidget{
  final BookedHistory data;
  const BookRideHistory(this.data, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _BookRideHistory(data);
}

class _BookRideHistory extends State<BookRideHistory> {

  final BookRideController controller = Get.put(BookRideController());

  _BookRideHistory(BookedHistory data) {
    controller.aSyncData(data);
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background/road.jpg"),
                fit: BoxFit.cover
            )
        ),
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: Colors.black54,

            ),
            child: Column(
              children: [
                BlurryContainer(
                  blur: 10,
                  elevation: 0.5,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)
                  ),
                  color: Colors.lightGreen,

                  child: ListTile(
                    leading: Obx(()=>CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 23,
                      child: CircleAvatar(
                        radius: 21,
                        backgroundImage: Image.network(controller.ownerPhotoUrl.value).image,
                      ),
                    ),
                    ),
                    title: Obx((){
                      return Text("${controller.ownerName}",style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ));
                    }),
                    subtitle: Obx((){
                      return Text("${controller.ownerMobileNumber}",style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ));
                    }),

                    onTap: (){
                    },
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx((){
                          return Hero(
                            tag: "titleB",
                            child: Text("${controller.source} - ${controller.destination}",style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),),
                          );
                        }),
                        Obx((){
                          return Text("Date & Time : ${controller.date} ${controller.time}",style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),);
                        }),
                        Obx((){
                          return Text("Route : ${controller.route}",style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),);
                        }),
                        Obx((){
                          return Text("Total Seats : ${controller.totalSeats}",style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),);
                        }),
                        Obx((){
                          return Text("Seats Remaining: ${controller.seatsRemaining}",style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),);
                        }),
                        Obx((){
                          return Text("Price : ${controller.price}",style: const TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),);
                        }),
                      ],
                    )
                ),


                Container(
                  height: 150,
                  child: Obx(() {

                    if(controller.passenger.isFalse){
                      return Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Not Available!",style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),)
                          ],
                        ),
                      );
                    }

                    if(controller.list.isNotEmpty) {
                      return ListView.builder(
                          itemCount: controller.list.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.green,
                                  radius: 22,
                                  child: CircleAvatar(
                                    backgroundImage: Image
                                        .network(controller.list[index].photoUrl)
                                        .image,),
                                ),
                                title: Text(controller.list[index].name),
                                subtitle: Text(
                                    controller.list[index].mobileNumber),
                                trailing: Text(
                                    " Seats : ${controller.list[index]
                                        .seatBooked}"),


                                onTap: () {},
                              ),
                            );
                          });
                    }else {
                      return Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Loading...",style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),)
                          ],
                        ),
                      );
                    }
                  }),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.list.clear();
    controller.source.value = "";
    controller.destination.value = "";
    controller.price.value = "";
    controller.route.value = "";
    controller.date.value = "";
    controller.time.value = "";
    controller.source.value = "";
    controller.totalSeats.value = "";
    controller.seatsRemaining.value = "";
    controller.ownerName.value = "";
    controller.ownerMobileNumber.value = "";
    controller.ownerPhotoUrl.value = "";
    controller.passenger.value = true;
    super.dispose();
  }

}