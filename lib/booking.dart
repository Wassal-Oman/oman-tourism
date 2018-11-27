// import needed libtraries
import 'package:flutter/material.dart';

// include widget class
class Booking extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BookingState();
}

// state widget
class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Booking Wedget'),
      ),
    );
  }
}