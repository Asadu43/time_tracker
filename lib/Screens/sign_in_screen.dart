import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';
import 'package:time_tracking_app/Services/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key,@required this.auth}) : super(key: key);
  final AuthBase auth;


  Future<void> _signInAnonymous() async {

   try {
     await auth.signInAnonymously();
   }catch (e){
     print (e.toString());
   }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sign In",
              style: GoogleFonts.handlee(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: 10.0,
            ),
            SignInButton(
                buttonType: ButtonType.googleDark,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                buttonSize: ButtonSize.large,
                btnText: "Sign in with Google",
                onPressed: () {}),
            SizedBox(
              height: 10.0,
            ),
            SignInButton(
                buttonType: ButtonType.facebookDark,
                btnText: "Facebook",
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                buttonSize: ButtonSize.large,
                btnColor: Colors.indigo,
                onPressed: () {}),
            SizedBox(
              height: 10.0,
            ),
            SignInButton(
                buttonType: ButtonType.mail,
                btnText: "Sign in with email",
                buttonSize: ButtonSize.large,
                imagePosition: ImagePosition.right,
                btnColor: Colors.teal[700],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                onPressed: () {}),
            SizedBox(
              height: 15.0,
            ),
            Text(
              "or",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
            ),
            FlatButton(
              onPressed: _signInAnonymous,
              child: Text("Sign in anonymous"),
              color: Colors.lime[300],
              minWidth: 290,
            ),
          ],
        ),
      ),
    );
  }


}
