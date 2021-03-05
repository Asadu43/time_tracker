import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {

  String txt;


  TextWidget(this.txt);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(txt,style: TextStyle(
          fontSize: 17.0,
          color: Colors.black,
        ),),
      ),
    );
  }
}
