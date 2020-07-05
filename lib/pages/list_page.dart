import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unsplash_gallery/model/photo.dart';
import 'package:unsplash_gallery/pages/photo_page.dart';

class ListPage extends StatefulWidget {
  ListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Photo> photoList = List<Photo>();

  Future _fetchPhotos() async {
    final response = await http.get(
        'https://api.unsplash.com/photos/?client_id=cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0');
    if (response.statusCode == 200) {
      if (photoList.isEmpty) {
        var decodeJson = json.decode(response.body);
        decodeJson
            .asMap()
            .forEach((i, value) => photoList.add(Photo.fromJson(value)));
      }
    } else {
      throw Exception("Failed to load photos");
    }
    return photoList;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              padding: EdgeInsets.all(10.0),
              child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  children: photoList
                      .map<Widget>(
                        (p) => GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PhotoPage(),
                                  settings: RouteSettings(arguments: p))),
                          child:
                              photoCard(p.id, p.url, p.username, p.description),
                        ),
                      )
                      .toList()),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return Center(
                child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF669999)),
            ));
          }
        },
        future: _fetchPhotos(),
      ),
    );
  }

  Widget photoCard(id, imageUrl, username, description) {
    return GridTile(
      child: Hero(
        child: FadeInImage.assetNetwork(
          placeholder: 'images/loading.gif',
          image: imageUrl,
          fit: BoxFit.cover,
        ),
        tag: id,
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black45,
        title: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
            child: Text(
              username,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
        subtitle: Center(
          child: Text(
            description,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14.0),
            maxLines: 2,
          ),
        ),
      ),
    );
  }
}
