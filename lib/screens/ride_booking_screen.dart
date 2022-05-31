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
  TextEditingController endSearch = TextEditingController();
  bool changeButton=false;



  @override



  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Form(child: Column(
          children:  [
            const SizedBox(height: 50,),
            const Text('Book Your Ride',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blueAccent),),
             const SizedBox(
              height: 20.0,
            ),
    Padding(
    padding:  const EdgeInsets.symmetric(vertical:16.0, horizontal: 32.0),
    child: Column(children: [
      TextFormField(
        controller: dateCtl,
        decoration: const InputDecoration(
          labelText: "Date of birth",
          hintText: "Ex. Insert your dob",),
        onTap: () async{
          DateTime ? date = DateTime(1900);
          FocusScope.of(context).requestFocus(FocusNode());
          date = await showDatePicker(
              context: context,
              initialDate:DateTime.now(),
              firstDate:DateTime(1900),
              lastDate: DateTime(2100));

          dateCtl.text = date.toString();
          },
      ),
      TextFormField(
        controller: startSearch,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: "From",

        ),
        validator: (value){
          if(value==null || value.isEmpty){
            return "EndingPoint is not empty";
          }
          return null;
        },

      ),
      TextFormField(
        controller: endSearch,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: "Destination",

        ),
        validator: (value){
          if(value==null || value.isEmpty){
            return "EndingPoint is not empty";
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
            onTap: null,
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
                  : const Text("SearchRide",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),

            ),
          ),
        ),
      )

        ],
        ),

        ),
        ],
        )

      ),
    ),
    );

  }

}

