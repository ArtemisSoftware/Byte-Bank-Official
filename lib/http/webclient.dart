import 'dart:convert';

import 'package:bytebankofficial/models/contact.dart';
import 'package:bytebankofficial/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

Future<List<Transaction>> findAll() async{

  final Client client = HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);

  final Response response =  await client.get("http://192.168.68.113:8080/transactions").timeout(Duration(seconds: 5));

  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<Transaction> transaction = List();

  for(Map<String, dynamic> transactionsJson in decodedJson){

    final Map<String, dynamic> contactJson = transactionsJson['contact'];
    transaction.add(Transaction(transactionsJson['value'], Contact(0, contactJson['name'], contactJson['accountNumber'])));
  }

  return transaction;
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