import 'package:simple_app/databases/transaction_db.dart';
import 'package:flutter/foundation.dart';
import 'package:simple_app/models/transactions.dart';

class TransactionProvider with ChangeNotifier {
  List<Transactions> transactions = [];

  TransactionProvider() {
    // Load all transactions when the provider is initialized
    loadTransactions();
  }

  List<Transactions> getTransaction() {
    return transactions;
  }

  void loadTransactions() async {
    var db = TransactionDB(dbName: 'transactions.db');
    this.transactions = await db.loadAllData();
    notifyListeners(); // Update the UI after loading data
  }

  void addTransaction(Transactions transaction) async {
    var db = TransactionDB(dbName: 'transactions.db');
    var keyID = await db.insertDatabase(transaction);
    this.transactions = await db.loadAllData(); // Reload all data after adding new one
    notifyListeners();
  }

  void deleteTransaction(int index) async {
    var db = TransactionDB(dbName: 'transactions.db');
    var transaction = transactions[index];

    if (transaction.id != null) {
      await db.deleteDatabase(transaction.id!); // Delete the transaction by id
      transactions.removeAt(index); // Remove from the list
      notifyListeners(); // Update the UI after deleting
    }
  }
}
