import 'package:anbu_stores_bills/models/Customer.dart';
import 'package:anbu_stores_bills/models/transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TransactionStore with ChangeNotifier{
  String customerId;
  List<TransactionData> transactions;
  bool isLoading, isUploading;
  TransactionStore(){
    transactions = [];
    isLoading = true;
    isUploading = false;
  }

  List<TransactionData> get getTransactions{
    print("getting trans");
    return transactions;
  }

  void fetchTransactions(String id){
    DateTime date;
    customerId = id;
    transactions = [];
    FirebaseFirestore.instance.collection("customers/$customerId/transactions").orderBy('date', descending: true).snapshots().listen((event) {
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
  
  void addTransaction(int balance, int amount, bool isAdd){
    isUploading = true;
    notifyListeners();
    FirebaseFirestore.instance.collection("customers/$customerId/transactions").add(
        {
          'date': DateTime.now(),
          'amount': amount,
          'balance': balance,
          'isAdd': isAdd
        }).then((value) => print(value.id));
  }


}