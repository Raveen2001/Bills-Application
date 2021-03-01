import 'package:anbu_stores_bills/Screens/HomePage.dart';
import 'package:anbu_stores_bills/Screens/login_page.dart';
import 'package:anbu_stores_bills/Store/CustomerStore.dart';
import 'package:anbu_stores_bills/Store/TransactionStore.dart';
import 'package:anbu_stores_bills/util/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => print("completed"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final key = GlobalKey<ScaffoldState>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => CustomerStore()),
        ChangeNotifierProvider(create: (ctx) => TransactionStore()),
      ],
      child: MaterialApp(
          title: 'Anbu Stores Bills',
          theme: ThemeData(
            // primarySwatch: Colors.green,
            primaryColor: Color.fromRGBO(44, 163, 97, 1),
            accentColor: Color.fromRGBO(61, 218, 132, 1),
            textTheme: Theme
                .of(context)
                .textTheme
                .apply(displayColor: Color.fromRGBO(47, 47, 47, 1)),
            fontFamily: "Heebo",
            backgroundColor: Color.fromRGBO(247, 247, 247, 1),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          // home: CustomerDetailsScreen(),
          home: StreamBuilder(
            stream: _auth(),
            builder: (cxt, snapshots) {
              Utils(cxt);
            if (snapshots.hasData) {
              return MyHomePage(title: 'Anbu Stores Bills');
            }else{
              return LoginPage();
            }
          },
          )
        // home: AddCustomer()
      ),
    );
  }

  Stream _auth(){
    return FirebaseAuth.instance.authStateChanges();
  }
}


