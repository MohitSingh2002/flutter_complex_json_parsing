import 'package:flutter/material.dart';
import 'package:flutter_complex_json/models/photos.dart';
import 'package:flutter_complex_json/screens/search_photos_page.dart';
import 'package:flutter_complex_json/services/service_helper.dart';

class LoadWhenScrollPage extends StatefulWidget {
  @override
  _LoadWhenScrollPageState createState() => _LoadWhenScrollPageState();
}

class _LoadWhenScrollPageState extends State<LoadWhenScrollPage> {

  List<Photos> _photos;

  loadAllPhotos() {
    ServiceHelper().getAllPhotos().then((value) {
      setState(() {
        _photos = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadAllPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPhotosPage(
                photos: _photos,
              )));
            },
          ),
        ],
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
          "Load When Scroll Page",
        ),
      ),
      body: SafeArea(
        child: _photos != null ? ListView.builder(
          itemCount: _photos.length,
          itemBuilder: (_, index) {
            Photos photos = _photos[index];
            return Card(
              child: ListTile(
                title: Text(index.toString()),
                subtitle: Text(photos.title),
              ),
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
