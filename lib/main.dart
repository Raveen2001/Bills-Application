import 'package:anbu_stores_bills/Screens/add_customer.dart';
import 'file:///E:/Anbu%20Stores/anbu_stores_bills/lib/Widgets/main_screen_body.dart';
import 'package:anbu_stores_bills/Store/CustomerStore.dart';
import 'package:anbu_stores_bills/Store/TransactionStore.dart';
import 'package:anbu_stores_bills/util/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => print("completed"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx)=> CustomerStore()),
        ChangeNotifierProvider(create: (ctx)=> TransactionStore()),
      ],
      child: MaterialApp(
        title: 'Anbu Stores Bills',
        theme: ThemeData(
          // primarySwatch: Colors.green,
          primaryColor: Color.fromRGBO(44, 163, 97, 1),
          accentColor: Color.fromRGBO(61, 218, 132, 1),
          textTheme: Theme.of(context)
              .textTheme
              .apply(displayColor: Color.fromRGBO(47, 47, 47, 1)),
          fontFamily: "Heebo",
          backgroundColor: Color.fromRGBO(247, 247, 247, 1),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: CustomerDetailsScreen(),
        home: MyHomePage(title: 'Anbu Stores Bills'),
        // home: AddCustomer()
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    new Utils(context);
    return Scaffold(
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
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Text("Logout"),
                value: "Logout",
              )
            ],
            onSelected: (value) {
              //TODO: make logout
              print(value);
            },
          )
        ],
      ),
      body: MainScreenBody(),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Add Customer"),
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (cxt) => AddCustomer()));
        },
        tooltip: 'Add Customer',
      ),
    );
  }
}
