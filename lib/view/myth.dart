import 'dart:convert';
import 'package:covid_nepal/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Myths extends StatefulWidget {
  @override
  _MythsState createState() => _MythsState();
}

class _MythsState extends State<Myths> {
  var myth;
  bool mLoading = true;

  Future getMyth() async {
    String url = "https://nepalcorona.info/api/v1/myths";
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': 'application/json'});
    setState(() {
      myth = json.decode(response.body)['data'];
      mLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getLatestNepalNews();
    getMyth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text("Covid-19 Myths"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //todo: Nepal Latest Update on Covid 19
            //myth
            mLoading == true
                ? Text('Loading..')
                : ListView.builder(
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
