import 'dart:async';

import 'package:anbu_stores_bills/Store/TransactionStore.dart';
import 'package:anbu_stores_bills/Widgets/add_dialog.dart';
import 'package:anbu_stores_bills/Widgets/customer_balance_summary.dart';
import 'package:anbu_stores_bills/Widgets/minus_dialog.dart';
import 'package:anbu_stores_bills/Widgets/transaction_card.dart';
import 'package:anbu_stores_bills/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/Customer.dart';

class CustomerDetailsScreen extends StatefulWidget {
  final Customer customer;

  CustomerDetailsScreen({@required this.customer});

  @override
  _CustomerDetailsScreenState createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {

  bool isFirst = true;
  TransactionStore transactionStore;


  @override
  void didChangeDependencies() {
    if(isFirst){
      transactionStore = Provider.of<TransactionStore>(context);
      transactionStore.fetchTransactions(widget.customer.id); //widget.customer.id
      isFirst = false;
    }
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    final List<TransactionData> transactions = transactionStore.getTransactions;
    final _controller = ScrollController();
    if(transactions.isNotEmpty){
      Timer(
        Duration(microseconds: 100),
            () => _controller.jumpTo(_controller.position.maxScrollExtent),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildAppBar(context),
      body: transactionStore.isLoading? Center(child: CircularProgressIndicator(),):Column(
        children: [
          CustomerBalanceSummary(),
          Expanded(child: ListView.builder(
            controller: _controller,
            itemBuilder: (cxt, index){
            return TransactionCard(transaction: transactions[index],);
          },
          itemCount: transactions.length,)),
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
              widget.customer.name.substring(0, 2),
              style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.customer.name,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "+91 " + widget.customer.phNo.toString(),
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
                  launch("tel://${widget.customer.phNo}");
                }))
      ],
    );
  }
}
