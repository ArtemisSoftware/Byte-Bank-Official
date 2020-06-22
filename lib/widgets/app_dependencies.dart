

import 'package:bytebankofficial/database/dao/contact_dao.dart';
import 'package:bytebankofficial/http/webclients/transaction_webclient.dart';
import 'package:flutter/material.dart';

class AppDependencies extends InheritedWidget{


  final ContactDao contactDao;
  final TransactionWebClient transactionWebClient;



  AppDependencies({
    @required this.contactDao,
    @required this.transactionWebClient,
    @required Widget child
  }) : super (child : child);


  @override
  bool updateShouldNotify(AppDependencies oldWidget) {
    return contactDao != oldWidget.contactDao || transactionWebClient != oldWidget.transactionWebClient;
  }


  static AppDependencies of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<AppDependencies>();
  }
}