import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // ใช้สำหรับการจัดรูปแบบวันที่
import 'package:app/models/transaction.dart';

class DetailScreen extends StatelessWidget {
  final Transactions transaction;

  const DetailScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายละเอียดข้อมูล'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(Icons.android,
                      size: 40, color: Colors.deepPurple),
                  title: Text(
                    transaction.gundamname,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(thickness: 1, height: 20),
                ListTile(
                  leading:
                      const Icon(Icons.star, color: Colors.amber, size: 30),
                  title: const Text('Gundam Name : '),
                  subtitle: Text(
                    transaction.gundamname,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const Divider(thickness: 1, height: 20),
                ListTile(
                  leading: const Icon(Icons.qr_code,
                      color: Colors.green, size: 30),
                  title: const Text('Serial Code : '),
                  subtitle: Text(
                    transaction.serialcode,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                
                const Divider(thickness: 1, height: 20),
                ListTile(
                  leading:
                      const Icon(Icons.person, color: Color.fromARGB(255, 5, 216, 231), size: 30),
                  title: const Text('Pilot : '),
                  subtitle: Text(
                    transaction.pilot,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const Divider(thickness: 1, height: 20),
                ListTile(
                  leading:
                      const Icon(Icons.security, color: Color.fromARGB(255, 19, 209, 44), size: 30),
                  title: const Text('Weapon : '),
                  subtitle: Text(
                    transaction.weapon,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const Divider(thickness: 1, height: 20),
                ListTile(
                  leading:
                      const Icon(Icons.settings, color: Color.fromARGB(255, 35, 7, 161), size: 30),
                  title: const Text('Functional System : '),
                  subtitle: Text(
                    transaction.functionalsystem,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const Divider(thickness: 1, height: 20),
                ListTile(
                  leading: const Icon(Icons.calendar_today,
                      color: Colors.blue, size: 30),
                  title: const Text('วันที่บันทึก'),
                  subtitle: Text(
                    DateFormat('dd MMM yyyy').format(transaction.date),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
