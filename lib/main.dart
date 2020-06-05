
import 'package:bytebankofficial/screens/dashboard.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(ByteBankApp());
  /*
  findAll().then((contacts) {
    debugPrint(contacts.toString());
  });
  */
  /*
  save(Contact(0, 'alex', 1000)).then((id) {
    findAll().then((contacts) {
        debugPrint(contacts.toString());
    });
  });
  */

  //save(Transaction(900, Contact(0, "Dick Grayson" ,4000))).then((transaction) => print("transaction $transaction"));
  //findAll().then((transactions) => print("new transactions $transactions"));
}

class ByteBankApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Colors.blueAccent[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary,
        ),
      ),

      home: Dashboard()
    );
  }
}


