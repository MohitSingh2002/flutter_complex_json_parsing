import 'package:flutter/material.dart';
import 'package:flutter_complex_json/models/photos.dart';

class SearchPhotosPage extends StatefulWidget {

  List<Photos> photos;

  SearchPhotosPage({this.photos});

  @override
  _SearchPhotosPageState createState() => _SearchPhotosPageState();
}

class _SearchPhotosPageState extends State<SearchPhotosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
          "Search Photos",
        ),
      ),
      body: Container(
        color: Colors.grey,
        child: Center(
          child: RaisedButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(
                  photos: widget.photos,
                ),
              );
            },
            child: Text(
              "SEARCH",
            ),
          ),
        ),
//      child: Padding(
//          padding: EdgeInsets.only(top: 15, left: 16, right: 16),
//          child: GestureDetector(
//            onTap: () {
//              showSearch(
//                context: context,
//                delegate: DataSearch(
//                  photos: widget.photos,
//                ),
//              );
//            },
//            child: Container(
//              height: 47.0,
//              decoration: BoxDecoration(
//                borderRadius: BorderRadius.circular(50.0),
//                color: Color(0xFF293e63),
//                boxShadow: [
//                  BoxShadow(
//                      blurRadius: 20.0,
//                      color: Colors.blue.withAlpha(100),
//                      spreadRadius: 5.0),
//                ],
//              ),
//              child: Row(
//                children: [
//                  SizedBox(width: 18.0),
//                  Icon(
//                    Icons.search,
//                    size: 22.0,
//                    color: Colors.blue.withOpacity(0.7),
//                  ),
//                  SizedBox(width: 15.0),
//                  Text(
//                    'Search',
//                    style: TextStyle(
//                        color: Colors.blue.withOpacity(0.7),
//                        fontSize: 17.0),
//                  ),
//                ],
//              ),
//            ),
//          )),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  List<Photos> photos;

  DataSearch({this.photos});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
        primaryColor: Colors.lightBlue[700].withOpacity(0.3),
        textTheme: Theme.of(context)
            .textTheme
            .copyWith(headline6: TextStyle(color: Colors.white)));
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
    // return Center(child: Container(width: 50.0, height: 50.0, color: Colors.red, child: Text(query),));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionsList = query.isEmpty
        ? photos
        : photos
        .where((p) =>
        p.title.startsWith(RegExp(query, caseSensitive: false)))
        .toList();
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: suggestionsList.length,
        itemBuilder: ((context, index) => Container(
          margin: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 5,
          ),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                backgroundImage:
                NetworkImage(suggestionsList[index].thumbnailUrl),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 130,
                child: Text(
                  suggestionsList[index].title,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
