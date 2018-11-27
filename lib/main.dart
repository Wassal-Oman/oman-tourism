// import needed libraries
import 'package:flutter/material.dart';

// load other dart files
import './splash.dart';
import './login.dart';
import './register.dart';
import './home.dart';

// load application
void main() => runApp(MyApp());


// main widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      title: 'Oman Tourism',
      theme: ThemeData(
        primaryColor: Colors.orange,
      ),
      home: Splash(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => Login(),
        '/register': (BuildContext context) => Register(),
        '/home': (BuildContext context) => Home()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}