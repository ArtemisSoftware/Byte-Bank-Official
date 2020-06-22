

import 'package:bytebankofficial/database/dao/contact_dao.dart';
import 'package:flutter/material.dart';

class AppDependencies extends InheritedWidget{


  final ContactDao contactDao;



  AppDependencies({@required this.contactDao, @required Widget child}) : super (child : child);


  @override
  bool updateShouldNotify(AppDependencies oldWidget) {
    return contactDao != oldWidget.contactDao;
  }


  static AppDependencies of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<AppDependencies>();
  }
}