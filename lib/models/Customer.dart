import 'package:anbu_stores_bills/models/transaction.dart';
import 'package:flutter/cupertino.dart';

class Customer{
  String id, name;
  int phNo, balance;
  List<TransactionData> transactions;
  Customer({@required this.id, @required this.name, @required this.phNo, @required this.balance});
}


List customers = [
  Customer(id: "1", name: "Raveen", phNo: 12342348948, balance: 1000),
  Customer(id: "2", name: "132", phNo: 12342348948, balance: 200),
  Customer(id: "3", name: "Rsadfaveen", phNo: 12342348948, balance: 2342),
  Customer(id: "4", name: "Raveeafdsn", phNo: 12342348948, balance: 123),
  Customer(id: "5", name: "Raveeafdsn", phNo: 12342348948, balance: 123),
  Customer(id: "6", name: "Raveeafdsn", phNo: 12342348948, balance: 123),
  Customer(id: "7", name: "Raveeafdsn", phNo: 12342348948, balance: 123),
];

