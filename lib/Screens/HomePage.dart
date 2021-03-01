import 'package:anbu_stores_bills/Screens/add_customer.dart';
import 'package:anbu_stores_bills/Widgets/main_screen_body.dart';
import 'package:anbu_stores_bills/util/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final key = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    new Utils(context);
    return Scaffold(
      key: key,
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.my_library_books_sharp),
            SizedBox(
              width: 10,
            ),
            Text(
              widget.title,
              style: TextStyle(fontWeight: FontWeight.w700),
            )
          ],
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (ctx) =>
            [
              PopupMenuItem(
                child: Text("Logout"),
                value: "Logout",
              )
            ],
            onSelected: (value) {
              if(value == "Logout") FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
      body: MainScreenBody(),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Add Customer"),
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (cxt) => AddCustomer()));
        },
        tooltip: 'Add Customer',
      ),
    );
  }
}