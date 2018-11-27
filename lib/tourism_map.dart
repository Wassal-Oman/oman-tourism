// import needed libtraries
import 'package:flutter/material.dart';

// include widget class
class TourismMap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TourismMapState();
}

// state widget
class _TourismMapState extends State<TourismMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Map Wedget'),
      ),
    );
  }
}
