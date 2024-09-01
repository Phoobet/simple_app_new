import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:resume/Currency.dart';

class Convert extends StatefulWidget {
  const Convert({super.key});
  @override
  State<Convert> createState() => _ConvertState();
}

class _ConvertState extends State<Convert> {
  @override
  initState() {
    super.initState();
    print("Init State");
  }

  Future<Currency> getCurrency() async {
    var uri =
        Uri.parse("https://currency-converter-pro1.p.rapidapi.com/currencies");

    var response = await http.get(uri, headers: {
      "X-RapidAPI-Host": "currency-converter-pro1.p.rapidapi.com",
      "x-rapidapi-key": "ebe77befcamsh4b38efb093e9848p1e09bejsn3b5365d6ed"
    });
    Currency result = currencyFromJson(response.body);
    print(result.toString());
    return result;
  }

  @override
  Widget build(BuildContext context) {
    print("Build");
    return FutureBuilder(
      future: getCurrency(),
      builder: (BuildContext context, AsyncSnapshot<Currency> snapshot) {
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
                  String? value = snapshot.data?.result![key];
                  return ListTile(
                    title: Text(key!),
                    subtitle: Text(value!),
                  );
                });
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
