import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';


class TextFieldWidgets extends StatelessWidget {

  String nameTxt, hintTxt, labelTxt;
  Icon icon;


  TextFieldWidgets(this.nameTxt, this.hintTxt, this.labelTxt, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(

      child: FormBuilderTextField(
        name: nameTxt,
        validator: FormBuilderValidators.required(context),
        decoration: InputDecoration(
          prefixIcon: icon,
          hintText: hintTxt,
          hintStyle: TextStyle(color: Colors.black),
          labelText: labelTxt,
          labelStyle: TextStyle(color: Colors.black),
          border: InputBorder.none,

        ),
      ),
    );
  }
}
