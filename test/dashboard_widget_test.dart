import 'package:bytebankofficial/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  testWidgets("Should display the main image when the Dashboard is open", (WidgetTester tester) async{

    await tester.pumpWidget(MaterialApp(home: Dashboard()));

    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });


  testWidgets("Should display the transfer feature when the Dashboard is open", (WidgetTester tester) async{

    await tester.pumpWidget(MaterialApp(home: Dashboard()));

    final iconTransferFeatureItem = find.widgetWithIcon(FeatureItem, Icons.monetization_on);
    expect(iconTransferFeatureItem, findsOneWidget);


    final nameTransferFeatureItem = find.widgetWithText(FeatureItem, "Transfer");
    expect(iconTransferFeatureItem, findsOneWidget);
  });
}