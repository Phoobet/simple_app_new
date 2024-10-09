// screens/transactiondetailScreen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:simple_app/models/transactions.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/provider/transaction_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class TransactionDetailScreen extends StatefulWidget {
  final Transactions transaction;

  const TransactionDetailScreen({super.key, required this.transaction});

  @override
  _TransactionDetailScreenState createState() => _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _changeImage() async {
    // ตรวจสอบและขอสิทธิ์
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
      if (!status.isGranted) {
        // แจ้งผู้ใช้ว่าต้องให้สิทธิ์
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ต้องให้สิทธิ์ในการเข้าถึง storage')),
        );
        return;
      }
    }

    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final provider = Provider.of<TransactionProvider>(context, listen: false);
      
      // สร้าง transaction ใหม่ด้วยเส้นทางภาพที่เลือก
      final updatedTransaction = Transactions(
        id: widget.transaction.id,
        title: widget.transaction.title,
        pilot: widget.transaction.pilot,
        serialcode: widget.transaction.serialcode,
        weapon: widget.transaction.weapon,
        functionalsystem: widget.transaction.functionalsystem,
        imagePath: pickedFile.path,
        date: widget.transaction.date,
      );

      // อัปเดตใน provider
      await provider.updateTransaction(updatedTransaction);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, provider, child) {
        // หา transaction ที่ต้องการจาก provider
        final updatedTransaction = provider.transactionsList.firstWhere(
          (t) => t.id == widget.transaction.id,
          orElse: () => widget.transaction,
        );

        return Scaffold(
          appBar: AppBar(
            title: Text(updatedTransaction.title),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: _changeImage, // เรียกใช้ฟังก์ชันเปลี่ยนภาพ
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // แสดงภาพ
                if (updatedTransaction.imagePath.isNotEmpty && File(updatedTransaction.imagePath).existsSync())
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0), // มุมมนของภาพ
                    child: Image.file(
                      File(updatedTransaction.imagePath),
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0), // มุมมนของภาพ
                    child: Image.asset(
                      'assets/images/Freedom.png', // รูปภาพเริ่มต้น
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: 16),

                // แสดงข้อมูลใน Card
                Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(top: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DetailRow(label: 'Gundam Name', value: updatedTransaction.title),
                        const SizedBox(height: 10),
                        DetailRow(label: 'Pilot', value: updatedTransaction.pilot),
                        const SizedBox(height: 10),
                        DetailRow(label: 'Serial Code', value: updatedTransaction.serialcode),
                        const SizedBox(height: 10),
                        DetailRow(label: 'Weapon', value: updatedTransaction.weapon),
                        const SizedBox(height: 10),
                        DetailRow(label: 'Functional System', value: updatedTransaction.functionalsystem),
                        const SizedBox(height: 10),
                        DetailRow(
                          label: 'Date',
                          value: DateFormat('dd MMM yyyy hh:mm:ss').format(updatedTransaction.date),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ป้ายกำกับ
        Container(
          width: 120,
          child: Text(
            '$label:',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // ค่าของข้อมูล
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
