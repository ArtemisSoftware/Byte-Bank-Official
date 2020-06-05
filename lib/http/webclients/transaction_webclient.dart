import 'dart:convert';

import 'package:bytebankofficial/http/webclient.dart';
import 'package:bytebankofficial/models/contact.dart';
import 'package:bytebankofficial/models/transaction.dart';
import 'package:http/http.dart';


class TransactionWebClient{


  Future<List<Transaction>> findAll() async{

    final Response response =  await client.get(baseUrl).timeout(Duration(seconds: 5));

    List<Transaction> transaction = _toTransactions(response);

    return transaction;
  }

  Future<Transaction> save (Transaction transaction) async {

    Map<String, dynamic> transactionMap = _toMap(transaction);

    final String transactionJson = jsonEncode(transactionMap);

    final Response response = await client.post(baseUrl, headers: {'Content-type' : 'application/json', 'password' : '1000'}, body : transactionJson);

    return _toTransaction(response);
  }



  Transaction _toTransaction(Response response) {
    Map<String, dynamic> json = jsonDecode(response.body);


    final Map<String, dynamic> contactJson = json['contact'];
    return Transaction(json['value'], Contact(0, contactJson['name'], contactJson['accountNumber']));
  }


  List<Transaction> _toTransactions(Response response) {
    final List<dynamic> decodedJson = jsonDecode(response.body);
    final List<Transaction> transaction = List();

    for(Map<String, dynamic> transactionsJson in decodedJson){

      final Map<String, dynamic> contactJson = transactionsJson['contact'];
      transaction.add(Transaction(transactionsJson['value'], Contact(0, contactJson['name'], contactJson['accountNumber'])));
    }
    return transaction;
  }



  Map<String, dynamic> _toMap(Transaction transaction) {
    final Map<String, dynamic> transactionMap = {
      'value' : transaction.value,
      'contact' : {
        'name' : transaction.contact.name,
        'accountNumber' : transaction.contact.accountNumber
      }
    };
    return transactionMap;
  }



}