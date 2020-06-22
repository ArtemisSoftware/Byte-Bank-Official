
import 'package:bytebankofficial/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){


  test("Should return the value when a transaction is created", (){

    final transaction = Transaction(null, 200, null);
    expect(transaction.value, 200);
  });

  test("Should show error when a transaction is created with value less than zero", (){

    expect(() => Transaction(null, 0, null), throwsAssertionError);
  });


}