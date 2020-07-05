import 'package:flutter/material.dart';
import 'package:unsplash_gallery/model/photo.dart';

class PhotoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Photo photo = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo"),
      ),
      body: Hero(
        tag: photo.id,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(photo.url)),
          ),
        ),
      ),
    );
  }
}
