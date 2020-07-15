import 'dart:convert';
import 'package:covid_nepal/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CoronaNews extends StatefulWidget {
  @override
  _CoronaNewsState createState() => _CoronaNewsState();
}

class _CoronaNewsState extends State<CoronaNews> {
  var news;

  bool wLoading = true;

  Future getLatestNews() async {
    String url = "https://nepalcorona.info/api/v1/news";
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': 'application/json'});
    setState(() {
      news = json.decode(response.body)['data'];
      wLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLatestNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text("Covid-19 News"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //news
            wLoading == true
                ? Text('Loading...')
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: news.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shadowColor: Colors.red,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                news[index]['title'],
                              ),
                              subtitle: Text(news[index]['summary']),
                            ),
                            Text(news[index]['summary']),
                            Image.network(news[index]['image_url']),
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
