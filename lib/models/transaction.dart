import 'package:flutter/cupertino.dart';

class Transaction{
  DateTime date;
  int amount;
  bool isAdd;
  Transaction({@required this.date, @required this.amount, @required this.isAdd});
}


List<Transaction> transactions = [
  Transaction(date: DateTime.now(), amount: 500, isAdd: true),
  Transaction(date: DateTime.now(), amount: 500, isAdd: false),
  Transaction(date: DateTime.now(), amount: 500, isAdd: true),
  Transaction(date: DateTime.now(), amount: 500, isAdd: true),
  Transaction(date: DateTime.now(), amount: 500, isAdd: false),
  Transaction(date: DateTime.now(), amount: 500, isAdd: false),
  Transaction(date: DateTime.now(), amount: 500, isAdd: true),
];