import 'dart:async';

import 'package:anbu_stores_bills/models/Customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class CustomerStore with ChangeNotifier{
  List<Customer> customers;
  int total;
  bool isSorted, isLoading;

  CustomerStore(){
    print("constructor called");
    total = 0;
    isSorted = false;
    isLoading = true;
    customers = [];
    fetchCustomers();
  }

  List<Customer> get getCustomers{
    print("getting data");
    // customers.forEach((element) {print(element.balance);});
    return customers;
  }

  void sortCustomers(){
      if (!isSorted) {
        print("first");
        customers.sort((dynamic a, dynamic b) {
          if (a.balance > b.balance) return 1;
          return 0;
        });
        this.customers = customers;
        print("inside");
        this.customers.forEach((element) {
          print(element.balance);});
      }
      else {
        print("second");
        this.customers.sort((dynamic a, dynamic b) {
          if (a.balance < b.balance) return 1;
          return 0;
        });
        print("inside" + customers.length.toString());
        this.customers.forEach((element) {

          print(element.balance);});
        print("completed");
      }
      isSorted = !isSorted;
      // customers = [];
      notifyListeners();
      print('notified');
  }

  void fetchCustomers(){
    print("Fetching data");
    total = 0;
    customers = [];
    FirebaseFirestore.instance.collection("customers").orderBy("balance", descending: true).snapshots().listen((event) {
      customers = [];
      event.docs.forEach((element) {
        total += element['balance'];
        customers.add(Customer(id: element.id, name: element['name'], phNo: element['phNo'], balance: element['balance']));
      });
      isLoading = false;
      notifyListeners();
      print("fetch notify");
    });

  }
}