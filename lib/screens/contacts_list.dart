import 'package:bytebankofficial/database/app_database.dart';
import 'package:bytebankofficial/models/contact.dart';
import 'package:bytebankofficial/screens/contact_form.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contacts"),),


        body : FutureBuilder<List<Contact>>(

            initialData: List(),
            future: Future.delayed(Duration(seconds: 1)).then((value) => findAll()),

            builder: (context, snapshot){

              switch(snapshot.connectionState){


                case ConnectionState.none:
                  break;

                case ConnectionState.waiting:
                  return Center(

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Text("Loading")
                      ]
                    ),
                  );
                  break;

                case ConnectionState.active:
                  break;

                case ConnectionState.done:
                  final List<Contact> contacts = snapshot.data;

                  return ListView.builder(

                    itemBuilder: (context, index){ return _ContactItem(contacts[index]);},
                    itemCount: contacts.length,
                  );
                  break;
              }


              return Text("Unknown error");




        }),

      /*

*/
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


class _ContactItem extends StatelessWidget {

  final Contact contact;

  _ContactItem(this.contact);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(

        title: Text(contact.name, style: TextStyle(fontSize: 24.0),),


        subtitle: Text(contact.accountNumber.toString(), style: TextStyle(fontSize: 16.0),),
      ),
    );
  }
}
