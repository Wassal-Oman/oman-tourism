// import needed libraries
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// tabs wedgets
import './tourism_map.dart';
import './search_location.dart';
import './booking.dart';

// other dart files
import './drawer.dart';
import './bottom_navigation.dart';

// widget
class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

// state
class HomeState extends State<Home> {
  // buttom novigation settings
  int _currentIndex = 0;
  final List<Widget> _tabs = [TourismMap(), SearchLocation(), Booking()];

  // fireabase
  FirebaseAuth auth;
  Firestore database;
  FirebaseUser currentUser;

  // user details
  String name = '';
  String email = '';

  @override
  void initState() {
    auth = FirebaseAuth.instance;
    database = Firestore.instance;

    getRegisteredUser().then((user) {
      if(user != null) {
        currentUser = user;

        // set user email
        setState(() {
          email = currentUser.email;  
        });

        // get user name from database
        getUserName(currentUser.uid).then((snapshot) {
          // set user name base on value coming from database
          setState(() {
            name = snapshot.data['user_name']; 
          });
        });
      }
    });

    super.initState();
  }

  // get tabbed page
  void onTabClicked(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // get registered user
  Future<FirebaseUser> getRegisteredUser() async {
    return await auth.currentUser();
  }

  // get registered user name
  Future<DocumentSnapshot> getUserName(String id) async {
    return await database.collection('users').document(id).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Home',
            style: TextStyle(color: Colors.white)
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        drawer: AppDrawer(name, currentUser.email),
        body: _tabs[_currentIndex],
        bottomNavigationBar: AppBottomNavigation(_currentIndex, onTabClicked));
  }
}
