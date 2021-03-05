import 'package:flutter/material.dart';

class BoldTextWidget extends StatelessWidget {

  String txt;


  BoldTextWidget(this.txt);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(txt,style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),),
      ),
    );
  }
}
