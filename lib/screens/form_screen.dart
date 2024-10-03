import 'package:simple_app/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/provider/transaction_provider.dart';

class FormScreen extends StatelessWidget {
  FormScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final pilotController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gundam Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // เพิ่ม padding รอบๆ form
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // จัดตำแหน่งให้เริ่มจากซ้าย
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Gundam Name',
                ),
                autofocus: true,
                controller: titleController,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return 'กรุณากรอกข้อมูล';
                  }
                  return null;
                },
                
              ),
              
              const SizedBox(height: 16.0), // เพิ่ม spacing ระหว่าง fields
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Pilot',
                ),
                keyboardType: TextInputType.text,
                controller: pilotController,
                validator: (String? input) {
                  if (input == null || input.isEmpty) {
                    return 'กรุณากรอกข้อมูล';
                  }
                  if (input.length < 3) {
                    return 'กรุณากรอกข้อมูลอย่างน้อย 3 ตัวอักษร';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0), // เพิ่ม spacing ก่อนปุ่ม
              TextButton(
                child: const Text('Confirm'),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // ปิดแป้นพิมพ์
                    FocusScope.of(context).unfocus();
                    
                    // create transaction data object
                    var statement = Transactions(
                      title: titleController.text,
                      amount: pilotController.text,
                      date: DateTime.now(),
                    );
                    
                    // add transaction data object to provider
                    var provider = Provider.of<TransactionProvider>(context, listen: false);
                    provider.addTransaction(statement);

                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
