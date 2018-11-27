// import needed libraries
import 'dart:async';
import 'package:flutter/material.dart';

// home screen widget
class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashState();
}

// splash screen state
class _SplashState extends State<Splash> {

  // method to set timer
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigateToLoginPage);
  }

  // method to navigate to login page
  void navigateToLoginPage() {
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/logo.png', scale: 1.0,),
      ),
    );
  }
}
