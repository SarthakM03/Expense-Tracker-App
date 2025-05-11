import './category.dart';

class Expense {
  final int _id;
  String _title;
  double _amount;
  final DateTime _date;
  final Category _category;
  Expense({
    required int id,
    required String title,
    required double amount,
    required DateTime date,
    required Category category,
  }) : _id = id,
       _title = title,
       _amount = amount,
       _category = category,
       _date = date;

  int get id => _id;
  String get title => _title;
  double get amount => _amount;
  DateTime get date => _date;
  Category get category => _category;

  set title(String value) {
    if (value.isEmpty) {
      throw Exception("Title cannot be Empty.");
    }
    _title = value;
  }

  set amount(double value) {
    if (value <= 0) {
      throw Exception("amount cannot be negative or zero");
    }
    _amount = value;
  }
}
