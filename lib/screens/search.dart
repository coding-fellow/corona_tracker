import 'package:flutter/material.dart';

class Search extends SearchDelegate {
  final List countryData;

  Search(this.countryData);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? countryData
        : countryData
            .where((element) =>
                element['country'].toString().toLowerCase().startsWith(query))
            .toList();

    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(5.0),
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
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
                      suggestionList[index]['countryInfo']['flag'],
                      height: 40.0,
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      suggestionList[index]['country'],
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
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
                          suggestionList[index]['cases'].toString(),
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
                          suggestionList[index]['recovered'].toString(),
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
                          suggestionList[index]['active'].toString(),
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
                          suggestionList[index]['deaths'].toString(),
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
        });
  }
}
