import 'package:bytebankofficial/screens/contacts_list.dart';
import 'package:bytebankofficial/screens/dashboard.dart';
import 'package:flutter/material.dart';

import 'database/app_database.dart';
import 'models/contact.dart';

void main() {
  runApp(ByteBankApp());

  save(Contact(0, 'alex', 1000)).then((id) {
    findAll().then((contacts) {
        debugPrint(contacts.toString());
    });
  });
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


