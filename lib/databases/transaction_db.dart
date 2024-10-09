import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:simple_app/models/transactions.dart';

class TransactionDB {
  String dbName;

  TransactionDB({required this.dbName});

  Future<Database> openDatabase() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);

    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  Future<int> insertDatabase(Transactions statement) async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('expense');

    var keyID = await store.add(db, {
      "title": statement.title,
      "pilot": statement.pilot,
      "serialcode":statement.serialcode,
      "weapon":statement.weapon,
      "FunctionalSystem":statement.functionalsystem,
      "date": statement.date.toIso8601String(),
      
      
    });
    
    db.close(); // ปิดฐานข้อมูลหลังการ insert (คุณอาจต้องการปรับปรุงให้ไม่ปิดทุกครั้ง)
    return keyID;
  }

  Future<List<Transactions>> loadAllData() async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('expense');
    var snapshot = await store.find(db);
    
    List<Transactions> transactions = [];
    for (var record in snapshot) {
      transactions.add(Transactions(
        id: record.key,
        title: record['title'].toString(),
        pilot: record['pilot'].toString(),
        serialcode: record['serialcode'].toString(),
        weapon: record['weapon'].toString(),
        functionalsystem: record['FunctionalSystem'].toString(),
        imagePath: record['imagePath'].toString(),
        date: DateTime.parse(record['date'].toString()),
        
      ));
    }
    
    db.close(); // ปิดฐานข้อมูลหลังการ load ข้อมูลทั้งหมด
    return transactions;
  }

  Future<void> deleteDatabase(int id) async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('expense');
    await store.record(id).delete(db);
    db.close(); // ปิดฐานข้อมูลหลังการลบข้อมูล
  }

  updateDatabase(Transactions newTransaction) {}
}
