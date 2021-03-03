import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_tracking_app/Services/auth.dart';

class Home extends StatelessWidget {

  const Home({Key key,@required this.auth}) : super(key: key);

  final AuthBase auth;

  Future<void> _onSignOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          FlatButton(
              onPressed: _onSignOut,
              child: Text(
                "Logout",
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ))
        ],
      ),
      body: Center(
        child: Text("Home page"),
      ),
    );
  }
}
