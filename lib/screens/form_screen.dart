import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/models/transactions.dart';
import 'package:simple_app/provider/transaction_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class FormScreen extends StatelessWidget {
  FormScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final pilotController = TextEditingController();
  final weaponController = TextEditingController(); 
  final functionalsystemController = TextEditingController();
  final serialcodeController = TextEditingController();
  String? imagePath; // Variable to store the selected image path

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

              const SizedBox(height: 16.0), // เพิ่ม spacing ก่อน field ใหม่
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Serial Code', // เปลี่ยนชื่อ label ตามที่ต้องการ
                ),
                controller: serialcodeController,
                validator: (String? input) {
                  if (input == null || input.isEmpty) {
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
                  if (input.length < 1) {
                    return 'กรุณากรอกข้อมูลอย่างน้อย 1 ตัวอักษร';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16.0), // เพิ่ม spacing ก่อน field ใหม่
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Weapon', // เปลี่ยนชื่อ label ตามที่ต้องการ
                ),
                controller: weaponController,
                validator: (String? input) {
                  if (input == null || input.isEmpty) {
                    return 'กรุณากรอกข้อมูล';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0), // เพิ่ม spacing ก่อน field ใหม่
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Functional System', // เปลี่ยนชื่อ label ตามที่ต้องการ
                ),
                controller: functionalsystemController,
                validator: (String? input) {
                  if (input == null || input.isEmpty) {
                    return 'กรุณากรอกข้อมูล';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16.0), // เพิ่ม spacing ก่อน field ใหม่
              // Add an image picker button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    imagePath != null ? 'Selected Image: ${imagePath!.split('/').last}' : 'No Image Selected',
                    style: const TextStyle(fontSize: 16),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Request permission to access storage
                      var status = await Permission.storage.status;
                      if (!status.isGranted) {
                        status = await Permission.storage.request();
                      }

                      if (status.isGranted) {
                        // Open the image picker
                        final picker = ImagePicker();
                        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          imagePath = pickedFile.path; // Update the selected image path
                        }
                      } else {
                        // Show a message if permission is not granted
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('ต้องให้สิทธิ์ในการเข้าถึง storage')),
                        );
                      }
                    },
                    child: const Text('Select Image'),
                  ),
                ],
              ),

              const SizedBox(height: 24.0), // เพิ่ม spacing ก่อนปุ่ม
              TextButton(
                child: const Text('Confirm'),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // ปิดแป้นพิมพ์
                    FocusScope.of(context).unfocus();
                    
                    // Create transaction data object
                    var statement = Transactions(
                      title: titleController.text,
                      pilot: pilotController.text,
                      serialcode: serialcodeController.text,
                      weapon: weaponController.text,
                      functionalsystem: functionalsystemController.text,
                      imagePath: imagePath ?? 'assets/images/Freedom.png', // Use the selected image or a default
                      date: DateTime.now(),
                    );
                    
                    // Add transaction data object to provider
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
