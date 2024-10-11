import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // ใช้สำหรับการจัดรูปแบบวันที่
import 'package:simple_app/models/transaction.dart';

class DetailScreen extends StatelessWidget {
  final Transactions transaction;

  const DetailScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detailed information'),
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
                _buildDetailTile(
                  icon: Icons.star,
                  title: 'Gundam Name',
                  subtitle: transaction.gundamname,
                ),
                const Divider(thickness: 1, height: 20),
                _buildDetailTile(
                  icon: Icons.qr_code,
                  title: 'Serial Code',
                  subtitle: transaction.serialcode,
                ),
                const Divider(thickness: 1, height: 20),
                _buildDetailTile(
                  icon: Icons.person,
                  title: 'Pilot',
                  subtitle: transaction.pilot,
                ),
                const Divider(thickness: 1, height: 20),
                _buildDetailTile(
                  icon: Icons.security,
                  title: 'Weapon',
                  subtitle: transaction.weapon,
                ),
                const Divider(thickness: 1, height: 20),
                _buildDetailTile(
                  icon: Icons.settings,
                  title: 'Functional System',
                  subtitle: transaction.functionalsystem,
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

  // ฟังก์ชันสร้าง ListTile สำหรับข้อมูลรายละเอียด
  Widget _buildDetailTile({required IconData icon, required String title, required String subtitle}) {
    return ListTile(
      leading: Icon(icon, color: Colors.amber, size: 30),
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 18),
        maxLines: 2, // จำกัดจำนวนบรรทัดที่แสดง
        overflow: TextOverflow.ellipsis, // ตัดคำเมื่อเกิน
      ),
    );
  }
}
