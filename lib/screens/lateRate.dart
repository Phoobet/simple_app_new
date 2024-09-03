import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
<<<<<<< HEAD
import 'dart:convert';

// Define your Rate model here
class Rate {
  final Map<String, double> result;

  Rate({required this.result});

  factory Rate.fromJson(Map<String, dynamic> json) {
    final Map<String, double> rates = {};
    final rateData = json['rates'] as Map<String, dynamic>;
    rateData.forEach((key, value) {
      rates[key] = value.toDouble();
    });
    return Rate(result: rates);
  }

  @override
  String toString() {
    return result.toString();
  }
}
=======
import 'package:resume/Rate.dart';
>>>>>>> d09184cebee1139ef799212a4f17a5d94db89ed2

class LatestRate extends StatefulWidget {
  const LatestRate({super.key});

  @override
  State<LatestRate> createState() => _LatestRateState();
}

class _LatestRateState extends State<LatestRate> {
<<<<<<< HEAD
  Future<Rate> getRate() async {
    final url = "https://currency-converter-pro1.p.rapidapi.com/latest-rates";
    final uri = Uri.parse(url);

    final response = await http.get(
      uri,
      headers: {
        "X-RapidAPI-Host": "currency-converter-pro1.p.rapidapi.com",
        "X-RapidAPI-Key": "ebe77befcamsh4b38efb093e9848p1e09bejsn3b5365d6ed"
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return Rate.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load rates');
    }
=======
  @override
  initState() {
    super.initState();
    print("Init State");
    getRate();
  }

  Future<Rate> getRate() async {
    var params = {"base": "THB"};
    var uri = Uri.https(
        "ttps://currency-converter-pro1.p.rapidapi.com/latest-rates?base=USD", params);

    var result = await http.get(uri, headers: {
      "X-RapidAPI-Host": "currency-converter-pro1.p.rapidapi.com",
      "x-rapidapi-key": "ebe77befcamsh4b38efb093e9848p1e09bejsn3b5365d6ed"
    });

    Rate rate = rateFromJson(result.body);
    print(rate.toString());
    return rate;
>>>>>>> d09184cebee1139ef799212a4f17a5d94db89ed2
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return FutureBuilder<Rate>(
      future: getRate(),
      builder: (BuildContext context, AsyncSnapshot<Rate> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        } else if (snapshot.hasData) {
          final rate = snapshot.data!;
          return ListView.builder(
            itemCount: rate.result.length,
            itemBuilder: (BuildContext context, int index) {
              String key = rate.result.keys.elementAt(index);
              double value = rate.result[key]!;
              return ListTile(
                title: Text(key),
                subtitle: Text(value.toString()),
              );
            },
          );
        } else {
          return Center(
            child: Text("No data available"),
          );
        }
      },
    );
  }
}

=======
    return FutureBuilder(
        future: getRate(),
        builder: (BuildContext context, AsyncSnapshot<Rate> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.result!.length,
                  itemBuilder: (BuildContext context, int index) {
                    String? key = snapshot.data?.result!.keys.elementAt(index);
                    double? value = snapshot.data?.result![key];
                    String? show = value!.toString();
                    return ListTile(
                      title: Text(key!),
                      subtitle: Text(show),
                    );
                  });
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
>>>>>>> d09184cebee1139ef799212a4f17a5d94db89ed2
