import 'dart:async';

import 'package:anbu_stores_bills/models/Customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class CustomerStore with ChangeNotifier {
  List<Customer> customers;
  List<Customer> tempList;
  int total;
  bool isSorted, isLoading;

  CustomerStore() {
    print("constructor called");
    total = 0;
    isSorted = false;
    isLoading = true;
    customers = [];
  }

  List<Customer> get getCustomers {
    return customers;
  }

  void addCustomers(String name, int phNo, int balance) {
    isLoading = true;

    notifyListeners();
    FirebaseFirestore.instance
        .collection("customers")
        .add({'name': name, 'phNo': phNo, 'balance': balance}).then((value) => {
              FirebaseFirestore.instance
                  .collection("customers/${value.id}/transactions")
                  .add({
                'date': DateTime.now(),
                'amount': balance,
                'balance': balance,
                'isAdd': true
              })
            });
  }

  void sortCustomers() {
    if (!isSorted) {
      customers.sort((dynamic a, dynamic b) {
        if (a.balance > b.balance) return 1;
        return 0;
      });
    } else {
      this.customers.sort((dynamic a, dynamic b) {
        if (a.balance < b.balance) return 1;
        return 0;
      });
      this.customers.forEach((element) {
        print(element.balance);
      });
    }
    isSorted = !isSorted;
    notifyListeners();
  }

  void fetchCustomers() {
    print("Fetching data");
    total = 0;
    customers = [];
    FirebaseFirestore.instance
        .collection("customers")
        .orderBy("balance", descending: true)
        .snapshots()
        .listen((event) {
      total = 0;
      customers = [];
      event.docs.forEach((element) {
        total += element['balance'];
        customers.add(Customer(
            id: element.id,
            name: element['name'],
            phNo: element['phNo'],
            balance: element['balance']));
      });
      isLoading = false;
      tempList = customers;
      notifyListeners();
      print("fetch notify");
    });
  }

  void searchCustomer(String key){
    customers = tempList.where((element) => element.name.contains(key) || element.phNo.toString().contains(key)).toList();
    notifyListeners();
  }

  void updateBalance(String id, int balance) {
    FirebaseFirestore.instance
        .collection("customers")
        .doc(id)
        .update({'balance': balance});
  }

  int getBalance(String id) {
    Customer customer = customers.firstWhere((element) => element.id == id);
    return customer.balance;
  }
}
