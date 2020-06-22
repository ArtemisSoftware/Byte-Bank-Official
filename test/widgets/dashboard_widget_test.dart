import 'package:bytebankofficial/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers/matchers.dart';

void main(){

  testWidgets("Should display the main image when the Dashboard is open", (WidgetTester tester) async{

    await tester.pumpWidget(MaterialApp(home: Dashboard()));

    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });


  testWidgets("Should display the transfer feature when the Dashboard is open", (WidgetTester tester) async{

    await tester.pumpWidget(MaterialApp(home: Dashboard()));

//    final iconTransferFeatureItem = find.widgetWithIcon(FeatureItem, Icons.monetization_on);
//    expect(iconTransferFeatureItem, findsOneWidget);
//
//
//    final nameTransferFeatureItem = find.widgetWithText(FeatureItem, "Transfer");
//    expect(iconTransferFeatureItem, findsOneWidget);


    final transferFeatureItem = find.byWidgetPredicate((widget){

      return featureItemMatcher(widget, 'Transfer', Icons.monetization_on);
    });


    expect(transferFeatureItem, findsOneWidget);


  });



  testWidgets("Should display the transaction feed feature when the Dashboard is open", (WidgetTester tester) async{

    await tester.pumpWidget(MaterialApp(home: Dashboard()));

//    final iconTransactionFeedFeatureItem = find.widgetWithIcon(FeatureItem, Icons.monetization_on);
//    expect(iconTransactionFeedFeatureItem, findsOneWidget);
//
//
//    final nameTransactionFeedFeatureItem = find.widgetWithText(FeatureItem, "Transaction Feed");
//    expect(nameTransactionFeedFeatureItem, findsOneWidget);



    final transactionFeedFeatureItem = find.byWidgetPredicate((widget){

      return featureItemMatcher(widget, 'Transaction Feed', Icons.description);
    });


    expect(transactionFeedFeatureItem, findsOneWidget);
  });


}

