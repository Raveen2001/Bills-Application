import 'package:anbu_stores_bills/Store/CustomerStore.dart';
import 'package:anbu_stores_bills/Widgets/all_customers.dart';
import 'package:anbu_stores_bills/Widgets/total_balance_summary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreenBody extends StatefulWidget {
  @override
  _MainScreenBodyState createState() => _MainScreenBodyState();
}

class _MainScreenBodyState extends State<MainScreenBody> {
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          TotalBalanceSummary(),
          Expanded(child: AllCustomers()),
        ],
      ),
    );
  }
}
