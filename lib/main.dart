import 'package:flutter/material.dart';
import 'package:simple_app/screens/convert.dart';

void main() {
  runApp( MaterialApp(
    title:"simple App",
    home: Scaffold(
      appBar: AppBar(
        title :Text("Simple App"),
      ),
      body: Convert(),
    ),
  ));
}

