import 'package:flutter/material.dart';
import 'package:time_tracking_app/Screens/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:time_tracking_app/Services/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: LandingPage(auth: Auth(),),
    );
  }
}

