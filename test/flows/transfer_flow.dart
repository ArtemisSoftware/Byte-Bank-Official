
import 'package:bytebankofficial/main.dart';
import 'package:bytebankofficial/screens/contacts_list.dart';
import 'package:bytebankofficial/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/mocks.dart';
import 'actions.dart';

void main(){

  testWidgets("should transfer to a contact", (tester) async{


    final mockContactDao = MockContactDao();

    await tester.pumpWidget(ByteBankApp(contactDao: mockContactDao));


    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);


    await clickOnTheTransferFeatureItem(tester);

    await tester.pumpAndSettle();

    final contactsList = find.byType(ContactsList);
    expect(contactsList, findsOneWidget);


    verify(mockContactDao.findAll()).called(1);


  });
}

