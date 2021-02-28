import 'package:anbu_stores_bills/models/transaction.dart';
import 'package:anbu_stores_bills/util/utils.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  TransactionCard({@required this.transaction});
  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 2,
      child: ListTile(
        tileColor: Colors.white,
        title: Text(Utils.format.format(transaction.date) ),
        subtitle: Row(
          children: [
            Card(
              margin: EdgeInsets.only(top: 5),
              color: Theme.of(context).accentColor.withOpacity(0.4),
              child: Container( padding: const EdgeInsets.all(5),child: Text("Bal. ₹ ${transaction.amount}")),
            ),
            Spacer()
          ],
        ),
        trailing: Text("₹ 400", style: TextStyle(color: transaction.isAdd?Colors.green:Colors.red, fontSize: 18, fontWeight: FontWeight.w700),),
      ),
    );
  }
}
