import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracking_app/Screens/home.dart';
import 'package:time_tracking_app/Screens/sign_in_screen.dart';
import 'package:time_tracking_app/Services/auth.dart';


class LandingPage extends StatelessWidget {
  const LandingPage({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: auth.authStateChange() ,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.active){
          final User user = snapshot.data;
          if(user == null){

            return SignInPage(
               auth: auth,
            );
          }
          return HomePage(
            auth: auth,
          );

        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );


  }
}
