import 'package:covid_nepal/view/home.dart';
import 'package:covid_nepal/view/myth.dart';
import 'package:covid_nepal/view/news.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Home"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()));
            },
          ),
          ListTile(
            title: Text("News"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CoronaNews()));
            },
          ),
          ListTile(
            title: Text("Myths"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Myths()));
            },
          ),
        ],
      ),
    );
  }
}
