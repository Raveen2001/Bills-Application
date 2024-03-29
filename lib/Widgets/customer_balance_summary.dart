import 'package:anbu_stores_bills/Store/CustomerStore.dart';
import 'package:anbu_stores_bills/models/Customer.dart';
import 'package:anbu_stores_bills/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerBalanceSummary extends StatelessWidget {
  final String id;
  CustomerBalanceSummary(this.id);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 35,
            color: Theme.of(context).primaryColor,
          ),
          Positioned(
            height: 80,
            width: Utils.size.width,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Text(
                      "Total Balance : ",
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            fontWeight: FontWeight.w700,
                            fontFamily: "Heebo",
                          ),
                    ),
                    Spacer(),
                    Consumer<CustomerStore>(
                      builder: (_, store, __) => Text(
                        "₹ ${store.getBalance(id)}",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            fontWeight: FontWeight.w700,
                            fontFamily: "Heebo",
                            color: Theme.of(context).accentColor),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
