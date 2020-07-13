import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var data;
  var myth;
  bool isLoading = true;

  Future getLatestNepalNews() async {
    String url = "https://nepalcorona.info/api/v1/data/nepal";
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': 'application/json'});
    setState(() {
      data = json.decode(response.body);
      isLoading = false;
    });
  }

  Future getMyth() async {
    String url = "https://nepalcorona.info/api/v1/myths";
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': 'application/json'});
    setState(() {
      myth = json.decode(response.body)['data'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLatestNepalNews();
    getMyth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  //todo: Nepal Latest Update on Covid 19
                  Row(
                    children: <Widget>[
                      //total tested
                      Expanded(
                        child: Container(
                          color: Colors.green,
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

                      //death
                      Expanded(
                        child: Container(
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
                  SizedBox(
                    height: 10,
                  ),

                  //second row

                  Row(
                    children: <Widget>[
                      //total tested
                      Expanded(
                        child: Container(
                          color: Colors.green,
                          child: Column(
                            children: <Widget>[
                              Text(
                                "In Isolation",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                data['in_isolation'].toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //positive
                      Expanded(
                        child: Container(
                          color: Colors.pink,
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

                      //death
                      Expanded(
                        child: Container(
                          color: Colors.red,
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
                    ],
                  ),

                  //myth
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: myth.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            children: <Widget>[
                              Image.network(myth[index]['image_url']),
                            ],
                          ),
                        );
                      })
                ],
              ),
            ),
    );
  }
}
