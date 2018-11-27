// import needed libraries
import 'package:flutter/material.dart';

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
  int _currentIndex = 0;
  final List<Widget> _tabs = [TourismMap(), SearchLocation(), Booking()];

  void onTabClicked(int index) {
    setState(() {
      _currentIndex = index;
    });
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
        drawer: AppDrawer('Ghanim Al Marzouqi', 'optimist_gm@hotmail.com'),
        body: _tabs[_currentIndex],
        bottomNavigationBar: AppBottomNavigation(_currentIndex, onTabClicked));
  }
}
