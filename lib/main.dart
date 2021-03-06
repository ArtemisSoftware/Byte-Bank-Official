
import 'package:bytebankofficial/database/dao/contact_dao.dart';
import 'package:bytebankofficial/http/webclients/transaction_webclient.dart';
import 'package:bytebankofficial/screens/dashboard.dart';
import 'package:bytebankofficial/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(ByteBankApp(contactDao: ContactDao(), transactionWebClient: TransactionWebClient()));
}

class ByteBankApp extends StatelessWidget {

  final ContactDao contactDao;
  final TransactionWebClient transactionWebClient;

  ByteBankApp({
    @required this.contactDao,
    @required this.transactionWebClient,
  });


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppDependencies(

      contactDao: contactDao,
      transactionWebClient: transactionWebClient,

      child: MaterialApp(

        theme: ThemeData(
          primaryColor: Colors.green[900],
          accentColor: Colors.blueAccent[700],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary,
          ),
        ),

        home: Dashboard()
      ),
    );
  }
}


