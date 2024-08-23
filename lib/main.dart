import 'package:flutter/material.dart';
import 'package:simple_app/screens/home.dart';
import 'package:simple_app/screens/menus.dart';

void main() {
  runApp( MaterialApp(
    title:"simple App",
    home: Scaffold(
      appBar: AppBar(
        title :Text("Simple App"),
      ),
      body: Menus(),
    ),
  ));
}

