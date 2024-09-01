import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simple_app/Currency.dart';

class Convert extends StatefulWidget {
  const Convert({super.key});

  @override
  State<Convert> createState() => _ConvertState();
}

class _ConvertState extends State<Convert> {

  @override
  void initState() {
    super.initState();
    Future<Currency> result = getCurrency();
  }

  Future<Currency> getCurrency() async{
    // var params = <String, String>{
    //   'base': 'USD'
    // };
    var url = "https://currency-converter-pro1.p.rapidapi.com/currencies";

    var uri = Uri.https(url,'/currencies');

    var response = await http.get(
      uri,
      headers: <String, String>{
        'X-RapidAPI-Key': ' ebe77befcamsh4b38efb093e9848p1e09bejsn3b5365d6ede2',
        'X-RapidAPI-Host': 'currency-converter-pro1.p.rapidapi.com'
      },
    );
    Currency currency = currencyFromJson(response.body);
    return currency;
    
    // return result;

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCurrency(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          return Text("Finished Load Data"); 
        }
        return CircularProgressIndicator();
      });
  }
}
