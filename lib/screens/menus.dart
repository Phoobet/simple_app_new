import 'package:flutter/material.dart';

class Menus extends StatefulWidget{
  const Menus ({super.key});

  @override
  State<Menus> createState() => _MenusState();
}

class _MenusState extends State<Menus> {
  List<String> item = <String>['Item 1','Item 2','Item 3'];
  @override
  Widget build(BuildContext context){
    return ListView.builder(
      itemCount:item.length,
      itemBuilder: (BuildContext,int index){
        return ListTile(
          title: Text('${item[index]}'),
          onLongPress: () {
            setState(() {
              item.removeAt(index);
          });
          },
        );
      },
    );
  }
}