import 'package:flutter/material.dart';
import 'package:simple_app/models/transactions.dart';

class TransactionDetailScreen extends StatelessWidget {
  final Transactions transaction;

  const TransactionDetailScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(transaction.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gundam Name: ${transaction.title}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Pilot: ${transaction.pilot}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'Serial Code: ${transaction.serialcode}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'Weapon: ${transaction.weapon}', // เพิ่มฟิลด์สถานะ
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'Functional System: ${transaction.functionalsystem}', // เพิ่มฟิลด์สถานะ
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'Date: ${transaction.date}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            // แสดงภาพ
            const SizedBox(height: 50), 
            Center(
              child: Image.asset(
                "assets/images/Freedom.png", // แก้ไขเป็น path ที่ถูกต้อง
                height: 150,
                width: 200, // ปรับความสูงของภาพตามต้องการ
                fit: BoxFit.cover, // ปรับให้พอดีกับกรอบ
              ),
            ),
          ],
        ),
      ),
    );
  }
}
