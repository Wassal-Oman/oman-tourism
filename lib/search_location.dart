// import needed libtraries
import 'package:flutter/material.dart';

// include widget class
class SearchLocation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchLocationState();
}

// state widget
class _SearchLocationState extends State<SearchLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Search Location Wedget'),
      ),
    );
  }
}