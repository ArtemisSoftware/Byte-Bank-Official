import 'package:bytebankofficial/screens/contact_form.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contacts"),),
      body : ListView(
        children: [
          Card(
            child: ListTile(

              title: Text('Name', style: TextStyle(fontSize: 24.0),),


              subtitle: Text('10000', style: TextStyle(fontSize: 16.0),),
            ),
          )
        ],
      ),

        floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return ContactForm();
              })
          ).then((newContact) {});
        },
          child: Icon(Icons.add),

    ),
    );
  }
}
