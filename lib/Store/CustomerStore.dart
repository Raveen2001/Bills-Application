import 'dart:async';

import 'package:anbu_stores_bills/models/Customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class CustomerStore with ChangeNotifier{
  List<Customer> customers;
  bool isSorted = true;

  CustomerStore(){
    print("constructor called");
    customers = [];
    fetchCustomers();
  }

  List<Customer> get getCustomers{
    print("getting data");
    customers.forEach((element) {print(element.balance);});
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
    customers = [];
    FirebaseFirestore.instance.collection("customers").snapshots().listen((event) {
      customers = [];
      event.docs.forEach((element) {
        print(element.id);
        customers.add(Customer(id: element.id, name: element['name'], phNo: element['phNo'], balance: element['balance']));
        print("here" + customers.toString());
      });
      notifyListeners();
    });

    // print(customers);

    // await FirebaseFirestore.instance.collection('customers').get().then((data) {
    //   data.docs.forEach((element) {
    //     print(element.id);
    //     customers.add(Customer(id: element.id, name: element['name'], phNo: element['phNo'], balance: element['balance']));
    //   });
    // });
  }
  void setCustomers(List<Customer> customers){
    this.customers = customers;
    this.customers.forEach((element) { print("setting " + element.balance.toString());});
    notifyListeners();
  }
}