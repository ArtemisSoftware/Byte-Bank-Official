import 'package:bytebankofficial/main.dart';
import 'package:bytebankofficial/screens/contact_form.dart';
import 'package:bytebankofficial/screens/contacts_list.dart';
import 'package:bytebankofficial/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'matchers.dart';

void main(){

  testWidgets("Should save a contact", (tester) async{


      await tester.pumpWidget(ByteBankApp());


      final dashboard = find.byType(Dashboard);
      expect(dashboard, findsOneWidget);


      final transferFeatureItem = find.byWidgetPredicate((widget) => featureItemMatcher(widget, "Transfer", Icons.monetization_on));
      expect(transferFeatureItem, findsOneWidget);
      await tester.tap(transferFeatureItem);

      await tester.pump();
      await tester.pump();

      await tester.pump();
      await tester.pump();
      await tester.pump();
      await tester.pump();
      await tester.pump();

      final contactsList = find.byType(ContactsList);
      expect(contactsList, findsOneWidget);

      final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
      expect(fabNewContact, findsOneWidget);
      await tester.tap(fabNewContact);

      await tester.pump();


      final contactForm = find.byType(ContactForm);
      expect(contactForm, findsOneWidget);



  });
}