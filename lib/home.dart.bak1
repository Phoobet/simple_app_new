import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Test Button'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
           children: [
            TextButton(
                onPressed: () {
                  print("Text Button Clicked");
                },
                child: const Text("Text")),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                print("Filled Button Clicked");
              },
              child: Text("Filled",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
                onPressed: () {
                  print("Elevated Button Clicked");
                },
                child: Text("Elevated",
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
              ),
              onPressed: () {
                print("Outlined Button Clicked");
              },
              child: Text("Outlined",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            )
          ]),
        ));
  }
}
