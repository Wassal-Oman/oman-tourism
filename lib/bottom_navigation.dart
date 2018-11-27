import 'package:flutter/material.dart';


class AppBottomNavigation extends StatelessWidget {

  final int currentIndex;
  final Function onTabClicked;

  AppBottomNavigation(this.currentIndex, this.onTabClicked);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: this.currentIndex,
      onTap: this.onTabClicked,
      items: [
        BottomNavigationBarItem(
          title: Text('Map'),
          icon: Icon(Icons.location_on),
        ),
        BottomNavigationBarItem(
          title: Text('Search'),
          icon: Icon(Icons.search),
        ),
        BottomNavigationBarItem(
          title: Text('Booking'),
          icon: Icon(Icons.create),
        ),
      ],
    );
  }
}