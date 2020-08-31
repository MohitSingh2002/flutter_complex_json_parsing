import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complex_json/models/user.dart';
import 'package:flutter_complex_json/screens/load_when_scroll_page.dart';
import 'package:flutter_complex_json/services/service_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<User> _user;

  @override
  void initState() {
    super.initState();
    ServiceHelper().getAllUsers().then((value) {
      setState(() {
        _user = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoadWhenScrollPage()));
              },
          ),
        ],
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
          "Flutter Complex Json Parsing",
        ),
      ),
      body: SafeArea(
        child: _user != null ? ListView.builder(
          itemCount: _user.length,
          itemBuilder: (_, index) {
            User user = _user[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Name : ${user.name}",
                ),
                Text(
                  "Username : ${user.username}",
                ),
                Text(
                  "Email : ${user.email}",
                ),
                Text(
                  "Address Street : ${user.address.street}",
                ),
                Text(
                  "Address Suite : ${user.address.suite}",
                ),
                Text(
                  "Address City : ${user.address.city}",
                ),
                Text(
                  "Address Zipcode : ${user.address.zipcode}",
                ),
                Text(
                  "Address Geo Lat : ${user.address.geo.lat}",
                ),
                Text(
                  "Address Geo Lng : ${user.address.geo.lng}",
                ),
                Text(
                  "Phone : ${user.phone}",
                ),
                Text(
                  "Website : ${user.website}",
                ),
                Text(
                  "Company Name : ${user.company.name}",
                ),
                Text(
                  "Company Catch Phrase : ${user.company.catchPhrase}",
                ),
                Text(
                  "Company Bs : ${user.company.bs}",
                ),
                Divider(),
              ],
            );
          },
        ) : Center(
          child: Text(
            "Loading.....",
          ),
        ),
      ),
    );
  }
}
