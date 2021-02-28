import 'dart:async';

import 'package:anbu_stores_bills/Screens/customer_details_screen.dart';
import 'package:anbu_stores_bills/Store/CustomerStore.dart';
import 'package:anbu_stores_bills/Widgets/search_bar.dart';
import 'package:anbu_stores_bills/models/Customer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllCustomers extends StatefulWidget {
  @override
  _AllCustomersState createState() => _AllCustomersState();
}

class _AllCustomersState extends State<AllCustomers> {
  CustomerStore customerStore;
  List<Customer> customers;
  bool isFirst = true;

  @override
  void didChangeDependencies() async {
    if (isFirst) {
      customerStore = Provider.of<CustomerStore>(context, listen: true);
      customerStore.fetchCustomers();
      isFirst = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    customers = customerStore.getCustomers;
    print(customers);
    print("Notified");

    return customerStore.isLoading? Center(child: CircularProgressIndicator(),):Container(
      margin: const EdgeInsets.all(5),
      width: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SearchBar(),
          Expanded(
            child: ListView.builder(
              itemBuilder: (cxt, index) {
                return Column(
                  children: [
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => CustomerDetailsScreen(customer: customers[index])),
                        );
                      },
                      padding: const EdgeInsets.all(0),
                      child: ListTile(
                        key: ValueKey(customers[index].id),
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Text(
                            customers[index].name.substring(0, 2),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(customers[index].name),
                        subtitle: Text(customers[index].phNo.toString()),
                        trailing: Text("₹ ${customers[index].balance}",
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                .copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    Divider(
                      height: 2,
                      color: Colors.black,
                    )
                  ],
                );
              },
              itemCount: customers.length,
            ),
          ),
          SizedBox(height: 60)
        ],
      ),
    );
  }
}
