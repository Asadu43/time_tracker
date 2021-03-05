import 'package:flutter/material.dart';



// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {

  String txt;


  ButtonWidget(this.txt);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.amber,
        borderRadius: BorderRadius.circular(20.0)
      ),
      height: 50.0,
      width: double.infinity,

      child: FlatButton(

        child: Text(txt,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),),
      ),
    );
  }
}
