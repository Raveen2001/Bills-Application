import 'package:flutter/cupertino.dart';

class TransactionData{
  DateTime date;
  int amount, balance;
  bool isAdd;
  TransactionData({@required this.date, @required this.amount, @required this.balance, @required this.isAdd});
}


// List<TransactionData> transactions = [
//   TransactionData(date: DateTime.now(), amount: 500, isAdd: true),
//   TransactionData(date: DateTime.now(), amount: 500, isAdd: false),
//   TransactionData(date: DateTime.now(), amount: 500, isAdd: true),
//   TransactionData(date: DateTime.now(), amount: 500, isAdd: true),
//   TransactionData(date: DateTime.now(), amount: 500, isAdd: false),
//   TransactionData(date: DateTime.now(), amount: 500, isAdd: false),
//   TransactionData(date: DateTime.now(), amount: 500, isAdd: true),
// ];