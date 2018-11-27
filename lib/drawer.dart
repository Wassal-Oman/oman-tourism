import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {

  // header details
  final String name;
  final String email;

  // set name and email
  AppDrawer(this.name, this.email);

  // return drawer wedget
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.orange
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(this.name, style: TextStyle(color: Colors.white),),
                Text(this.email, style: TextStyle(color: Colors.white),)
              ],
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {},
          ),
        ],
      )
    );
  }
}