import 'package:bytebankofficial/main.dart';
import 'package:bytebankofficial/models/contact.dart';
import 'package:bytebankofficial/screens/contact_form.dart';
import 'package:bytebankofficial/screens/contacts_list.dart';
import 'package:bytebankofficial/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/mocks.dart';

void main(){

  testWidgets("Should save a contact", (tester) async{


      final mockContactDao = MockContactDao();


      await tester.pumpWidget(ByteBankApp(contactDao: mockContactDao));


      final dashboard = find.byType(Dashboard);
      expect(dashboard, findsOneWidget);


      final transferFeatureItem = find.byWidgetPredicate((widget) => featureItemMatcher(widget, "Transfer", Icons.monetization_on));
      expect(transferFeatureItem, findsOneWidget);
      await tester.tap(transferFeatureItem);

      await tester.pumpAndSettle();

      final contactsList = find.byType(ContactsList);
      expect(contactsList, findsOneWidget);


      verify(mockContactDao.findAll()).called(1);



      final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
      expect(fabNewContact, findsOneWidget);
      await tester.tap(fabNewContact);
      await tester.pumpAndSettle();


      final contactForm = find.byType(ContactForm);
      expect(contactForm, findsOneWidget);


      final nameTextField = find.byWidgetPredicate((widget)  {

          return textFieldByLabelTextMatcher(widget, "Full name");
      });

      expect(nameTextField, findsOneWidget);
      await tester.enterText(nameTextField, "Alex");



      final accountNumberTextField = find.byWidgetPredicate((widget)  {

          return textFieldByLabelTextMatcher(widget, "Account number");
      });

      expect(accountNumberTextField, findsOneWidget);
      await tester.enterText(accountNumberTextField, "1000");


      final createButton = find.widgetWithText(RaisedButton, 'Create');
      expect(createButton, findsOneWidget);
      await tester.tap(createButton);
      await tester.pumpAndSettle();
      
      verify(mockContactDao.save(Contact(0, "Alex", 1000)));

      final contactsListBack = find.byType(ContactsList);
      expect(contactsListBack, findsOneWidget);


      verify(mockContactDao.findAll());
  });
}

