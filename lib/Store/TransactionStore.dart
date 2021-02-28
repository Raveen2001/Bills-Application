import 'package:anbu_stores_bills/models/transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TransactionStore with ChangeNotifier{
  String customerId;
  List<TransactionData> transactions;
  bool isLoading;
  TransactionStore(){
    transactions = [];
    isLoading = true;
  }

  List<TransactionData> get getTransactions{
    print("getting trans");
    return transactions;
  }

  void fetchTransactions(String id){
    DateTime date;
    customerId = id;
    transactions = [];
    FirebaseFirestore.instance.collection("customers/$customerId/transactions").snapshots().listen((event) {
      transactions = [];
      event.docs.forEach((element) {
        date = element['date'].toDate();
        print(date);
        transactions.add(TransactionData(date: date, amount: element['amount'],balance: element["balance"], isAdd: element['isAdd']));
       // print(element["amount"]);
      });
      print("transactions fetched");
      isLoading = false;
      notifyListeners();
    });
  }
}