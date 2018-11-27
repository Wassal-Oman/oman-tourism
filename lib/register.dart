// load needed libraries
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

// widget class
class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // local fields
  String _name = '';
  String _email = '';
  String _phone = '';
  String _password = '';

  // firebase
  FirebaseAuth auth;
  Firestore database;
  FirebaseUser user;

  // initialize firebase auth and cloud firestore
  @override
  void initState() {
    this.auth = FirebaseAuth.instance;
    this.database = Firestore.instance;
    this.user = null;
    super.initState();
  }

  // sign up using Firebase Auth
  void signUp(BuildContext context) {
    if (this._name != '' &&
        this._email != '' &&
        this._password != '' &&
        this._phone != '') {
      getFirebaseUser(this._email, this._password).then((FirebaseUser u) {
        this.user = u;

        if (this.user != null) {
          // add user details in database
          registerUserInDatabase(
                  this.user.uid, this._name, this.user.email, this._phone)
              .then((val) {
            _showDailog(
                context, 'Success', 'User has been registered successfully');
          }).catchError((error) {
            _showDailog(context, 'Failed', 'Cannot register user:\n$error');
          });
        } else {
          _showDailog(context, 'Failed', 'Cannot register user!');
        }
      }).catchError((AuthException e) {
        _showDailog(context, 'Failed', '${e.toString()}');
      });
    } else {
      _showToast('Please fill all fields');
    }
  }

  // dailog message
  void _showDailog(BuildContext context, String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text('Close'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  // toast message
  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  // register user in Firebase Authentication System
  Future<FirebaseUser> getFirebaseUser(String email, String password) async {
    FirebaseUser firebaseUser;

    try {
      // register new user
      firebaseUser = await this
          .auth
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print('Exception: $e');
    }

    // return created user
    return firebaseUser;
  }

  // register user in Cloud Firestore
  Future<void> registerUserInDatabase(
      String id, String name, String email, String phone) async {
    return await database.collection('users').document(id).setData({
      'user_id': id,
      'user_name': name,
      'user_email': email,
      'user_phone': '+968' + phone,
      'user_type': 'user'
    });
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
              decoration: InputDecoration(hintText: 'Full Name'),
              keyboardType: TextInputType.text,
              onChanged: (String value) {
                setState(() {
                  this._name = value.trim();
                });
              },
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              onChanged: (String value) {
                setState(() {
                  this._email = value.trim();
                });
              },
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Phone Number'),
              keyboardType: TextInputType.phone,
              onChanged: (String value) {
                setState(() {
                  this._phone = value.trim();
                });
              },
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Password'),
              keyboardType: TextInputType.text,
              obscureText: true,
              onChanged: (String value) {
                setState(() {
                  this._password = value.trim();
                });
              },
            ),
            FlatButton(
              child: Text('Sign Up'),
              color: Colors.orange,
              textColor: Colors.white,
              onPressed: () => this.signUp(context),
            )
          ],
        ),
      ),
    );
  }
}
