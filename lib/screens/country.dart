import 'dart:convert';

import 'package:coronatracker/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Country extends StatefulWidget {
  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {
  List countryData;

  fetchCountryData() async {
    http.Response response =
        await http.get("https://corona.lmao.ninja/v2/countries");
    setState(() {
      countryData = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    fetchCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: Text("Country Stats"),
        backgroundColor: Colors.grey[900],
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white70,
            ),
            onPressed: () {
              showSearch(context: context, delegate: Search(countryData));
            },
          )
        ],
      ),
      body: countryData == null
          ? Center(
              child: Container(
                height: 40.0,
                child: CircularProgressIndicator(),
              ),
            )
          : ListView.builder(
              itemCount: countryData == null ? 0 : countryData.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(5.0),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  height: 130.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Image.network(
                            countryData[index]['countryInfo']['flag'],
                            height: 40.0,
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            countryData[index]['country'],
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                          )
                        ],
                      ),
                      Divider(
                        height: 20.0,
                        color: Colors.grey,
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
                                countryData[index]['cases'].toString(),
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
                                countryData[index]['recovered'].toString(),
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                            ],
                          ),
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
                                countryData[index]['active'].toString(),
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
                                countryData[index]['deaths'].toString(),
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }),
    );
  }
}
