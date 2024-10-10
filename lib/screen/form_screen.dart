import 'package:app/main.dart';
import 'package:app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/provider/transaction_provider.dart';
import 'package:app/screen/HomeScreen.dart';

class FormScreen extends StatelessWidget {
  FormScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final gundamnameController = TextEditingController();
  final serialcodeController = TextEditingController();
  final pilotController = TextEditingController();
  final weaponController = TextEditingController();
  final functionalsystemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แบบฟอร์มข้อมูล'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // เพิ่ม Padding รอบๆ Form
        child: Form(
          key: formKey,
          child: SingleChildScrollView( // เพื่อให้ Scroll ได้เมื่อหน้าจอเล็ก
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Gundam Name',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  autofocus: true,
                  controller: gundamnameController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                    return null; // เพิ่มการส่งค่ากลับเมื่อข้อมูลถูกต้อง
                  },
                ),
                const SizedBox(height: 16), // เว้นระยะห่างระหว่าง TextFormField
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Serial Code',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  controller: serialcodeController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Pilot',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  controller: pilotController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Weapon',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  controller: weaponController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Functional System',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  controller: functionalsystemController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Create transaction data object
                      var statement = Transactions(
                        keyID: null,
                        gundamname: gundamnameController.text,
                        serialcode: serialcodeController.text,
                        pilot: pilotController.text,
                        weapon: weaponController.text,
                        functionalsystem: functionalsystemController.text,
                        date: DateTime.now(),
                      );

                      // Add transaction data object to provider
                      var provider = Provider.of<TransactionProvider>(context, listen: false);
                      provider.addTransaction(statement);

                      // Navigate back to HomeScreen
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return MyHomePage();
                      }));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16), // เพิ่ม Padding ในปุ่ม
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // เพิ่มมุมโค้ง
                    ),
                  ),
                  child: const Text(
                    'save',
                    style: TextStyle(fontSize: 18),
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
