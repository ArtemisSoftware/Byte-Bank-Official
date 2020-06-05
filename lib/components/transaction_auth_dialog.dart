import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      title: Text("Authenticate"),

      content: TextField(
        obscureText: true,
        maxLength: 4,
        textAlign: TextAlign.center,
        decoration: InputDecoration(border: OutlineInputBorder()),
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize:  64, letterSpacing: 32),
      ),

      actions: [
        FlatButton(
          onPressed: () { print("Confirm");},
          child: Text("Cancel"),
        ),

        FlatButton(
          onPressed: () { print("Confirm");},
          child: Text("Confirm"),
        )
      ],
    );
  }
}
