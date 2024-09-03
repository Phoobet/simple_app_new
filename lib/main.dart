import 'package:flutter/material.dart';
<<<<<<< HEAD
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
=======
import 'package:resume/screen/lateRate.dart';

void main() {
  runApp(MaterialApp(
    title: "Exchange Currency",
    home: Scaffold(
      appBar: AppBar(
        title: const Text("Exchange Currency"),
      ),
      body: const LatestRate(),
>>>>>>> d09184cebee1139ef799212a4f17a5d94db89ed2
    ),
  );
}
<<<<<<< HEAD


=======
>>>>>>> d09184cebee1139ef799212a4f17a5d94db89ed2
