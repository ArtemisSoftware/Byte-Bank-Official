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

    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response = await client.post(baseUrl, headers: {'Content-type' : 'application/json', 'password' : '1000'}, body : transactionJson);

    return _toTransaction(response);
  }



  Transaction _toTransaction(Response response) {
    Map<String, dynamic> json = jsonDecode(response.body);
    return Transaction.fromJson(json);
  }


  List<Transaction> _toTransactions(Response response) {
    final List<dynamic> decodedJson = jsonDecode(response.body);
    final List<Transaction> transaction = List();

    for(Map<String, dynamic> transactionsJson in decodedJson){
      transaction.add(Transaction.fromJson (transactionsJson));
    }
    return transaction;
  }




}