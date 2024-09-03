import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

class LatestRate extends StatefulWidget {
  const LatestRate({super.key});

  @override
  State<LatestRate> createState() => _LatestRateState();
}

class _LatestRateState extends State<LatestRate> {
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
  }

  @override
  Widget build(BuildContext context) {
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

