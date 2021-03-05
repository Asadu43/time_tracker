import 'package:flutter/material.dart';
import 'package:time_tracking_app/Services/auth.dart';

enum emailSignInType {signIn,register}



class EmailSignIn extends StatefulWidget {
  const EmailSignIn({Key key,@required this.auth}) : super(key: key);
  final AuthBase auth;



  @override
  _EmailSignInState createState() => _EmailSignInState();
}

class _EmailSignInState extends State<EmailSignIn> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  emailSignInType _type = emailSignInType.signIn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Sign In "),
      ),
      body: Card(
        child: _buildContent(),
        margin: EdgeInsets.all(16.0),
      ),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent() {
    final primaryText = _type == emailSignInType.signIn ?
        "Sign In" : "Create An Account";
    final secondryText = _type == emailSignInType.signIn ?
        "Need An Account? Register" :"Have a Account? Sign In";
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "text@gmail.com",
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 10.0),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Enter Password",
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 10.0),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              color: Colors.indigo,
              child: Center(
                child: RaisedButton(
                  onPressed: submit,
                  color: Colors.indigo,
                  child: Text(
                    primaryText,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            FlatButton(
              onPressed: _togglingButton,
              child: Text(
                secondryText,
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
   void _togglingButton(){
    setState(() {
      _type = _type == emailSignInType.signIn?
          emailSignInType.register : emailSignInType.signIn;
    });
    emailController.clear();
    passwordController.clear();
   }
   void submit() async{
    try {
      if (_type == emailSignInType.signIn) {
        await widget.auth.signInWithEmail(
            emailController.text, passwordController.text);
      } else {
        await widget.auth.createAccountWithEmail(
            emailController.text, passwordController.text);
      }
      Navigator.of(context).pop();

    }catch (e){
      print(e.toString());
    }
   }
}
