import 'package:flutter/material.dart';
import 'package:simpleApp/src/app/pages/home/home_view.dart';

void main() {
  runApp(SimpleApp());
}

class SimpleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: HomePage());
  }
}