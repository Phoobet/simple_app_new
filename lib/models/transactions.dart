class Transactions {
  int? id;
  final String title;
  final String pilot;
  final String serialcode;
  final String weapon;
  final String functionalsystem;
  final String imagePath;
  final DateTime date;
 

  Transactions({
    this.id,
    required this.title,
    required this.pilot,
    required this.serialcode,
    required this.weapon,
    required this.functionalsystem,
    required this.imagePath,
    required this.date,
   
  });
}