
import 'package:bytebankofficial/components/response_dialog.dart';
import 'package:bytebankofficial/components/transaction_auth_dialog.dart';
import 'package:bytebankofficial/main.dart';
import 'package:bytebankofficial/models/contact.dart';
import 'package:bytebankofficial/models/transaction.dart';
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
    final mockTransactionWebClient = MockTransactionWebClient();

    await tester.pumpWidget(ByteBankApp(contactDao: mockContactDao, transactionWebClient: mockTransactionWebClient));


    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);


    final contact = Contact(0,"Alex", 1000);

    when(mockContactDao.findAll()).thenAnswer((realInvocation) async {

      debugPrint("invocating: ${realInvocation.memberName}");
      return [contact];
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


    final contactName = find.text("Alex");
    expect(contactName, findsOneWidget);


    final accountNumberName = find.text("1000");
    expect(accountNumberName, findsOneWidget);


    final textFieldValue = find.byWidgetPredicate((widget) {
      return textFieldByLabelTextMatcher(widget, "Value");
    });
    expect(textFieldValue, findsOneWidget);

    await tester.enterText(textFieldValue, "200");

    final transferButton = find.widgetWithText(RaisedButton, "Transfer");
    expect(transferButton, findsOneWidget);

    await tester.tap(transferButton);
    await tester.pumpAndSettle();

    final transactionAuthDialog = find.byType(TransactionAuthDialog);
    expect(transactionAuthDialog, findsOneWidget);


    final textFieldPassword = find.byKey(transactionAuthDialogTextFieldPasswordKey);
    expect(textFieldPassword, findsOneWidget);
    await tester.enterText(textFieldPassword, "1000");


    final cancelButton = find.widgetWithText(FlatButton, "Cancel");
    expect(cancelButton, findsOneWidget);

    final confirmButton = find.widgetWithText(FlatButton, "Confirm");
    expect(confirmButton, findsOneWidget);


    when(mockTransactionWebClient.save(Transaction(null, 200, contact), "1000"))
        .thenAnswer((realInvocation) async => Transaction(null, 200, contact));

    await tester.tap(confirmButton);
    await tester.pumpAndSettle();

    final successDialog = find.byType(SuccessDialog);
    expect(successDialog, findsOneWidget);

    final okButton = find.widgetWithText(FlatButton, "Ok");
    expect(okButton, findsOneWidget);

    await tester.tap(okButton);
    await tester.pumpAndSettle();

    final contactsListBack = find.byType(ContactsList);
    expect(contactsListBack, findsOneWidget);

  });
}

