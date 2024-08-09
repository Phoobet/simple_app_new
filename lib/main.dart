
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
      home: const MyHomePage(),
    );
  }
}
class MyHomePage extends StatelessWidget{
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Bar Hello World'),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: NetworkImage('https://img.freepik.com/free-psd/ash-isolated-transparent-background_191095-10000.jpg?w=900&t=st=1722588726~exp=1722589326~hmac=8f0745de58de5b0c70351a718bd06cc122eecd6abee81a81952e96d260ee9a64'),
                width: 50,
                height: 50,
              ),
              Text('Resume',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ) ,
              )
            ]
          ),
          Row(
            children:[
              Column(
                children: [
                  Text('First Name: Nattapon'),
                  Text('Last Name: Kumyaito'),
                ]
            ),
            ]
          ),
          Row(children: [
            Text('Hobby: Cycling')
          ]),
          Row(children: [
            Text('Education:')
          ]),
          Row(children: [
            Column(
              children: [
                Text('Primary: Satit Pibulsongkram School'),
                Text('Secondary: Chalermkwansatree School'),
                Text('UnderGrad: Naresuan University'),
              ],
            ),
            Column(
              children: [
                Text('GPA: X.XX'),
                Text('GPA: Y.YY'),
                Text('GPA: Z.ZZ')
              ]
            ),

          ]),
        ]
      ),
    );
  }
}

 