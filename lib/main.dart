import 'package:flutter/material.dart';
import 'package:simple_app/screens/lateRate.dart'; // Ensure this path is correct

void main() {
  runApp(
    MaterialApp(
      title: "Exchange Currency",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Exchange Currency"),
        ),
        body: const LatestRate(), // Ensure class name matches
      ),
    ),
  );
}


