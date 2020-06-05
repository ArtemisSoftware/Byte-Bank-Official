import 'dart:convert';

import 'package:bytebankofficial/models/contact.dart';
import 'package:bytebankofficial/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

final Client client = HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
const String baseUrl = "http://192.168.68.113:8080/transactions";

Future<List<Transaction>> findAll() async{
  
  final Response response =  await client.get(baseUrl).timeout(Duration(seconds: 5));

  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<Transaction> transaction = List();

  for(Map<String, dynamic> transactionsJson in decodedJson){

    final Map<String, dynamic> contactJson = transactionsJson['contact'];
    transaction.add(Transaction(transactionsJson['value'], Contact(0, contactJson['name'], contactJson['accountNumber'])));
  }

  return transaction;
}

Future<Transaction> save (Transaction transaction) async {

  final Map<String, dynamic> transactionMap = {
    'value' : transaction.value,
    'contact' : {
      'name' : transaction.contact.name,
      'accountNumber' : transaction.contact.accountNumber
    }
  };

  final String transactionJson = jsonEncode(transactionMap);
  
  final Response response = await client.post(baseUrl, headers: {'Content-type' : 'application/json', 'password' : '1000'}, body : transactionJson);

  Map<String, dynamic> json = jsonDecode(response.body);


  final Map<String, dynamic> contactJson = json['contact'];
  return Transaction(json['value'], Contact(0, contactJson['name'], contactJson['accountNumber']));
}



class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print('Request');
    print('url ${data.url}');
    print('headers ${data.headers}');
    print('body ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print('Response');
    print('Status code: ${data.statusCode}');
    print('headers ${data.headers}');
    print('body ${data.body}');
    return data;
  }

}

