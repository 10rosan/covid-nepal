import 'dart:convert';

import 'package:covid_nepal/widgets/carousel_widget.dart';
import 'package:covid_nepal/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var data;
  var worldData;

  bool isLoading = true;
  //bool worldLoading = true;

  Future getLatestNepalNews() async {
    String url = "https://nepalcorona.info/api/v1/data/nepal";
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': 'application/json'});
    setState(() {
      data = json.decode(response.body);
      isLoading = false;
    });
  }

  Future getWorldNews() async {
    String url = "https://data.nepalcorona.info/api/v1/world";
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': 'application/json'});
    setState(() {
      worldData = json.decode(response.body);
      //worldLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLatestNepalNews();
    getWorldNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text("Covid-19 Tracking"),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: MyCaro(),
                  ),

                  SizedBox(height: 10),

                  ListTile(
                    title: Text(
                      "Info of Nepal",
                      textScaleFactor: 1.2,
                    ),
                  ),
                  //todo: Nepal Latest Update on Covid 19
                  Container(
                    height: 50,
                    child: Row(
                      children: <Widget>[
                        //total tested
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 10),
                            color: Colors.orange,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Tested Tested",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  data['tested_total'].toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),

                        //positive
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 10),
                            color: Colors.pink,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Tested Positive",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  data['tested_positive'].toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //second row

                  Container(
                    height: 50,
                    child: Row(
                      children: <Widget>[
                        //Quarantined
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 10),
                            color: Colors.blue,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Quarantined",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  data['quarantined'].toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),

                        //In Isolation
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 10),
                            color: Colors.yellowAccent,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "In Isolation",
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  data['in_isolation'].toString(),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Container(
                    height: 50,
                    child: Row(
                      children: <Widget>[
                        //death
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 10),
                            color: Colors.green,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Recovered",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  data['recovered'].toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),

                        //death
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 10),
                            color: Colors.red,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Total Deaths",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  data['deaths'].toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),

                  ListTile(
                    title: Text(
                      "World Info",
                      textScaleFactor: 1.2,
                    ),
                  ),

                  Container(
                    height: 50,
                    child: Row(
                      children: <Widget>[
                        //death
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 10),
                            color: Colors.green,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Total Cases",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  worldData['cases'].toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),

                        //death
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 10),
                            color: Colors.red,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Total Deaths",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  worldData['deaths'].toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
