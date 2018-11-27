// load needed libraries
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

// widget class
class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // local fields
  String email = '';
  String password = '';

  // firebase
  FirebaseAuth auth;
  Firestore database;

  @override
  void initState() {
    auth = FirebaseAuth.instance;
    database = Firestore.instance;

    // check if user logged in
    checkLoggedUser().then((FirebaseUser user) {
      if (user != null) {
        Navigator.of(context).pushNamed('/home');
      }
    });

    super.initState();
  }

  // sign in using Firebase Auth
  void signIn(BuildContext context) {

    // check if fields are not empty
    if(this.email.isNotEmpty && this.password.isNotEmpty) {

      // try login to firebase authentication
      makeLogin(this.email, this.password).then((FirebaseUser user) {
        
        // check if user available
        if (user != null) {
          Navigator.of(context).pushNamed('/home');
        } else {
          this._showDailog(context, 'Failed', 'Wrong email or password!');
        }

      }).catchError((AuthException e) {
        this._showDailog(context, 'ERROR', 'Error has occurred!');
      });

    } else {
      _showToast('Please fill all fields');
    }
  }

  void _showDailog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(content),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // toast message
  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  // method to make login in firebase authentication system
  Future<FirebaseUser> makeLogin(String email, String password) async {
    
    FirebaseUser firebaseUser;

    try {
      firebaseUser = await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (error) {
      print('Error $error');
    }

    return firebaseUser;
  }

  // method to check if user logged in
  Future<FirebaseUser> checkLoggedUser() async {
    return await this.auth.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
            Image.asset(
              'assets/images/logo.png',
              scale: 1.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: 'Enter Your Email'),
              onChanged: (String value) {
               setState(() {
                this.email = value.trim();
               });
              },
            ),
            TextField(
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(hintText: 'Enter Your Password'),
              onChanged: (String value) {
                setState(() {
                  this.password = value;
                });
              },
            ),
            FlatButton(
              child: Text('Sign In'),
              color: Colors.orange,
              textColor: Colors.white,
              onPressed: () => this.signIn(context)
            ),
            FlatButton(
              child: Text("I don't have an account!"),
              onPressed: () => Navigator.of(context).pushNamed('/register'),
            )
          ],
        ),
      )
    );
  }
}
