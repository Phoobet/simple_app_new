class Transactions {
  // final String id;
  final int? keyID;
  final String gundamname;
  final String serialcode;
  final String pilot;
  final String weapon;
  final String functionalsystem;
  final DateTime date;
  final String? imagePath; 

  Transactions({
    // required this.id,
    this.keyID,
    required this.gundamname,
    required this.serialcode,
    required this.pilot,
    required this.weapon,
    required this.functionalsystem,
    required this.date,
    this.imagePath,
  });
}
