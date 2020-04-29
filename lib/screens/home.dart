import 'dart:convert';

import 'package:coronatracker/screens/country.dart';
import 'package:coronatracker/services/date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map worldData;

  fetchWorldData() async {
    http.Response response = await http.get("https://corona.lmao.ninja/v2/all");
    setState(() {
      worldData = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    fetchWorldData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          // image credit
          // <a href="https://www.freepik.com/free-photos-vectors/background">Background photo
          // created by freepik - www.freepik.com</a>
          image: AssetImage("images/corona.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: worldData == null
            ? Center(
                child:
                    Container(height: 40, child: CircularProgressIndicator()),
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      Date().getCurrentDate(),
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.asset(
                              "images/global.png",
                              height: 38.0,
                            ),
                            SizedBox(width: 4.0,),
                            Text(
                              "World",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 38.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.map,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return Country();
                              }),
                            );
                          },
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 50.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Positive",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              worldData['cases'].toString(),
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Recovered",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              worldData['recovered'].toString(),
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Active",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              worldData['active'].toString(),
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Died",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              worldData['deaths'].toString(),
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
