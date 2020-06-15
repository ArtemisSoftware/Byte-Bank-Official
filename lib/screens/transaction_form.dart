import 'dart:async';

import 'package:bytebankofficial/components/response_dialog.dart';
import 'package:bytebankofficial/components/transaction_auth_dialog.dart';
import 'package:bytebankofficial/http/webclients/transaction_webclient.dart';
import 'package:bytebankofficial/models/contact.dart';
import 'package:bytebankofficial/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {

  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Transfer'), onPressed: () {
                      final double value = double.tryParse(_valueController.text);
                      final transactionCreated = Transaction(value, widget.contact);

                      showDialog(context: context, builder: (contextDialog){
                        return TransactionAuthDialog(

                          onConfirm: (password) {

                            _save(transactionCreated, password, context);
                          },
                        );

                      });




                  },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(Transaction transactionCreated, String password, BuildContext context) async{

    //await Future.delayed(Duration(seconds: 1));


    Transaction transaction = await _send(transactionCreated, password, context);


    await _showSuccessfulMessage(transaction, context);
  }

  Future _showSuccessfulMessage(Transaction transaction, BuildContext context) async {
    if(transaction != null){

      await showDialog(context: context, builder: (contextDialog) {
        return SuccessDialog('successful transaction');
      });

      Navigator.pop(context);


    }
  }

  Future<Transaction> _send(Transaction transactionCreated, String password, BuildContext context) async {
    final Transaction transaction = await _webClient.save(transactionCreated, password)

        .catchError((e){

          showDialog(context: context, builder: (contextDialog) {

            _showFailureMessage(context, message: "timeout submitting the transaction");

          });

    }, test: (e) => e is TimeoutException)

        .catchError((e){

      _showFailureMessage(context,  message:  e.message);

    }, test: (e) => e is HttpException)

        .catchError((e){

          _showFailureMessage(context);
    });
    return transaction;
  }

  void _showFailureMessage(BuildContext context, {String message = "Unknown error"}) {
     showDialog(context: context, builder: (contextDialog) {
      return FailureDialog(message);
    });
  }
}
