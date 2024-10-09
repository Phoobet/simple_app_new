import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:simple_app/databases/transaction_db.dart';
import 'package:simple_app/models/transactions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class TransactionProvider with ChangeNotifier {
  List<Transactions> transactions = [];
  final TransactionDB db = TransactionDB(dbName: 'transactions.db');

  TransactionProvider() {
    loadTransactions();
  }

  List<Transactions> get transactionsList => transactions;

  Future<void> loadTransactions() async {
    try {
      transactions = await db.loadAllData();
      notifyListeners();
    } catch (e) {
      print('Error loading transactions: $e');
    }
  }

  Future<void> addTransaction(Transactions transaction) async {
    try {
      String savedImagePath = transaction.imagePath;

      // Check if the image path is not empty and file exists
      if (transaction.imagePath.isNotEmpty) {
        final File originalImage = File(transaction.imagePath);
        if (await originalImage.exists()) {
          final appDir = await getApplicationDocumentsDirectory();
          final fileName = basename(originalImage.path);
          final savedImage = await originalImage.copy('${appDir.path}/$fileName');
          savedImagePath = savedImage.path;
        }
      }

      final newTransaction = Transactions(
        title: transaction.title,
        pilot: transaction.pilot,
        serialcode: transaction.serialcode,
        weapon: transaction.weapon,
        functionalsystem: transaction.functionalsystem,
        imagePath: savedImagePath,
        date: transaction.date,
      );

      await db.insertDatabase(newTransaction);
      await loadTransactions();
    } catch (e) {
      print('Error adding transaction: $e');
    }
  }

  Future<void> updateTransaction(Transactions updatedTransaction) async {
    try {
      String savedImagePath = updatedTransaction.imagePath;
      String? oldImagePath;

      // Find the transaction to update
      final index = transactions.indexWhere((t) => t.id == updatedTransaction.id);
      if (index != -1) {
        final existingTransaction = transactions[index];
        oldImagePath = existingTransaction.imagePath;
      }

      // Check if the updated image path is not empty and file exists
      if (updatedTransaction.imagePath.isNotEmpty && !updatedTransaction.imagePath.contains('assets/images')) {
        final File originalImage = File(updatedTransaction.imagePath);
        if (await originalImage.exists()) {
          final appDir = await getApplicationDocumentsDirectory();
          final fileName = basename(originalImage.path);
          final savedImage = await originalImage.copy('${appDir.path}/$fileName');
          savedImagePath = savedImage.path;
        }
      }

      final newTransaction = Transactions(
        id: updatedTransaction.id,
        title: updatedTransaction.title,
        pilot: updatedTransaction.pilot,
        serialcode: updatedTransaction.serialcode,
        weapon: updatedTransaction.weapon,
        functionalsystem: updatedTransaction.functionalsystem,
        imagePath: savedImagePath,
        date: updatedTransaction.date,
      );

      await db.updateDatabase(newTransaction);
      await loadTransactions();

      // Delete the old image if it exists and is different from the new one
      if (oldImagePath != null && oldImagePath.isNotEmpty && oldImagePath != savedImagePath && !oldImagePath.contains('assets/images')) {
        final oldImageFile = File(oldImagePath);
        if (await oldImageFile.exists()) {
          await oldImageFile.delete();
        }
      }
    } catch (e) {
      print('Error updating transaction: $e');
    }
  }

  Future<void> deleteTransaction(int index) async {
    try {
      var transaction = transactions[index];

      if (transaction.id != null) {
        await db.deleteDatabase(transaction.id!);

        // Check if the image path is not empty before attempting to delete
        if (transaction.imagePath.isNotEmpty && !transaction.imagePath.contains('assets/images')) {
          final imageFile = File(transaction.imagePath);
          if (await imageFile.exists()) {
            await imageFile.delete();
          }
        }

        transactions.removeAt(index);
        notifyListeners();
      }
    } catch (e) {
      print('Error deleting transaction: $e');
    }
  }
}
