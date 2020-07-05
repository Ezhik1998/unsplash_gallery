import 'package:flutter/material.dart';
import 'package:unsplash_gallery/pages/list_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gallery',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: ListPage(title: 'Gallery'),
    );
  }
}
