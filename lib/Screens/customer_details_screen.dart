import 'dart:async';

import 'package:anbu_stores_bills/Widgets/add_dialog.dart';
import 'package:anbu_stores_bills/Widgets/customer_balance_summary.dart';
import 'package:anbu_stores_bills/Widgets/minus_dialog.dart';
import 'package:anbu_stores_bills/Widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/Customer.dart';

class CustomerDetailsScreen extends StatelessWidget {
  final Customer customer = customers[0];

  @override
  Widget build(BuildContext context) {
    final _controller = ScrollController();
    Timer(
      Duration(microseconds: 100),
          () => _controller.jumpTo(_controller.position.maxScrollExtent),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildAppBar(context),
      body: Container(

        child: Column(
          children: [
            CustomerBalanceSummary(),
            Expanded(child: ListView.builder(
              controller: _controller,
              itemBuilder: (cxt, index){
              return TransactionCard(transaction: customer.transactions[index],);
            },
            itemCount: customer.transactions.length,)),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Divider(
                    color: Colors.black,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 5,),
                      Expanded(
                        child: FlatButton(
                            onPressed: () {
                              showDialog(context: context, builder: (_) => MinusDialog());
                            },
                            color: Colors.redAccent[700],
                            child: Container(
                              height: 50,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    )
                                  ]),
                            )),
                      ),
                      SizedBox(width: 5,),
                      Expanded(
                        child: FlatButton(
                            onPressed: () {
                              showDialog(context: context, builder: (_) => AddDialog());
                            },
                            color: Theme.of(context).accentColor,
                            padding: const EdgeInsets.all(0),
                            child: Container(
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            )),
                      ),
                      SizedBox(width: 5,),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(
              customer.name.substring(0, 2),
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                customer.name,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "+91 " + customer.phNo.toString(),
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.white),
              )
            ],
          ),
        ],
      ),
      actions: [
        Container(
            width: 60,
            child: FlatButton(
                padding: const EdgeInsets.all(0),
                child: Icon(
                  Icons.call,
                  color: Colors.white,
                ),
                onPressed: () {
                  launch("tel://${customer.phNo}");
                }))
      ],
    );
  }
}
