import 'package:anbu_stores_bills/Store/CustomerStore.dart';
import 'package:anbu_stores_bills/util/funs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {


  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool isFirst = true;
  CustomerStore customerStore;

  @override
  void didChangeDependencies() {
    if(isFirst){
      print("building");
      customerStore = Provider.of<CustomerStore>(context);
      isFirst = false;
    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    print("rebuilding");
    return Row(
      children: [
        Expanded(
          child: Container(
            padding:
                const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
            height: 70,
            child: Center(
              child: TextField(
                onChanged: (value) {
                  print(value);
                },
                style: TextStyle(
                  fontSize: 15,
                ),
                cursorColor: Theme.of(context).primaryColor,
                maxLines: 1,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    labelText: "Search",
                    border: OutlineInputBorder()),
              ),
            ),
          ),
        ),
        Container(
            height: 60,
            width: 60,
            padding: const EdgeInsets.only(right: 5),
            child: FlatButton(
              child: Image.asset(
                "assets/images/sort.png",
                height: 30,
                width: 25,
              ),
              onPressed: () {
                customerStore.sortCustomers();
                       // var customers= sort(customerStore.customers);
               // customerStore.setCustomers(customers);
              },
              padding: const EdgeInsets.all(0),
            ))
      ],
    );
  }
}
