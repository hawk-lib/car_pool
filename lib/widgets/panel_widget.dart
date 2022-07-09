import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PanelWidget extends StatefulWidget {
  const PanelWidget({Key? key, required ScrollController controller}) : super(key: key);

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
   late ScrollController controller;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        SizedBox(
          height: 36,
        ),
        buildAboutText()
      ],
    );
  }

  Widget buildAboutText() {
    return Container(
      color: Colors.transparent,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("hello"),
          SizedBox(height: 20,),
          Text("name"),
          SizedBox(height: 20,),
          Text("is"),
          SizedBox(height: 20,),
          Text("amit"),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}
