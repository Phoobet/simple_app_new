import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/models/transaction.dart';
import 'package:simple_app/provider/transaction_provider.dart';

class EditFormScreen extends StatefulWidget {
  final Transactions transaction;

  EditFormScreen({super.key, required this.transaction});

  @override
  _EditFormScreenState createState() => _EditFormScreenState();
}

class _EditFormScreenState extends State<EditFormScreen> {
  final formKey = GlobalKey<FormState>();
  final gundamnameController = TextEditingController();
  final serialcodeController = TextEditingController();
  final pilotController = TextEditingController();
  final weaponController = TextEditingController();
  final functionalsystemController = TextEditingController();

  @override
  void initState() {
    super.initState();
    gundamnameController.text = widget.transaction.gundamname;
    serialcodeController.text = widget.transaction.serialcode;
    pilotController.text = widget.transaction.pilot;
    weaponController.text = widget.transaction.weapon;
    functionalsystemController.text = widget.transaction.functionalsystem;
  }

  @override
  void dispose() {
    gundamnameController.dispose();
    serialcodeController.dispose();
    pilotController.dispose();
    weaponController.dispose();
    functionalsystemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit data'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Gundam Name',
                  border: OutlineInputBorder(),
                ),
                controller: gundamnameController,
                validator: (String? str) {
                  if (str == null || str.isEmpty) {
                    return 'กรุณากรอกข้อมูล';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Serial Code',
                  border: OutlineInputBorder(),
                ),
                controller: serialcodeController,
                validator: (String? str) {
                  if (str == null || str.isEmpty) {
                    return 'กรุณากรอกข้อมูล';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Pilot',
                  border: OutlineInputBorder(),
                ),
                controller: pilotController,
                validator: (String? str) {
                  if (str == null || str.isEmpty) {
                    return 'กรุณากรอกข้อมูล';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Weapon',
                  border: OutlineInputBorder(),
                ),
                controller: weaponController,
                validator: (String? str) {
                  if (str == null || str.isEmpty) {
                    return 'กรุณากรอกข้อมูล';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Functional System',
                  border: OutlineInputBorder(),
                ),
                controller: functionalsystemController,
                validator: (String? str) {
                  if (str == null || str.isEmpty) {
                    return 'กรุณากรอกข้อมูล';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    var updatedTransaction = Transactions(
                      keyID: widget.transaction.keyID,
                      gundamname: gundamnameController.text,
                      serialcode: serialcodeController.text,
                      pilot: pilotController.text,
                      weapon: weaponController.text,
                      functionalsystem: functionalsystemController.text,
                      date: widget.transaction.date, // Keep the same date
                    );

                    // Update the transaction data in the provider
                    var provider = Provider.of<TransactionProvider>(context, listen: false);
                    provider.updateTransaction(updatedTransaction);

                    Navigator.pop(context); // Go back to the previous screen
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
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
    );
  }
}
