
import 'package:bytebankofficial/main.dart';
import 'package:bytebankofficial/models/contact.dart';
import 'package:bytebankofficial/screens/contacts_list.dart';
import 'package:bytebankofficial/screens/dashboard.dart';
import 'package:bytebankofficial/screens/transaction_form.dart';
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


    when(mockContactDao.findAll()).thenAnswer((realInvocation) async {

      debugPrint("invocating: ${realInvocation.memberName}");
      return [Contact(0,"Alex", 1000)];
    });
    
    await clickOnTheTransferFeatureItem(tester);

    await tester.pumpAndSettle();

    final contactsList = find.byType(ContactsList);
    expect(contactsList, findsOneWidget);


    verify(mockContactDao.findAll()).called(1);


    final contactItem = find.byWidgetPredicate((widget) {

      if(widget is ContactItem){
        return widget.contact.name == "Alex" && widget.contact.accountNumber == 1000;
      }

      return false;
    });

    expect(contactItem, findsOneWidget);
    await tester.tap(contactItem);
    await tester.pumpAndSettle();

    final transactionForm = find.byType(TransactionForm);
    expect(transactionForm, findsOneWidget);

  });
}

