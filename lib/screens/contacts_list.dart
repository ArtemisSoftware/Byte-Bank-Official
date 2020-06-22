import 'package:bytebankofficial/components/progress.dart';
import 'package:bytebankofficial/database/dao/contact_dao.dart';
import 'package:bytebankofficial/models/contact.dart';
import 'package:bytebankofficial/screens/contact_form.dart';
import 'package:bytebankofficial/screens/transaction_form.dart';
import 'package:bytebankofficial/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';



class ContactsList extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return ContactsListState();
  }
}



class ContactsListState extends State<ContactsList> {


  @override
  Widget build(BuildContext context) {

    final dependencies = AppDependencies.of(context);

    return Scaffold(
      appBar: AppBar(title: Text("Transfer"),),


        body : FutureBuilder<List<Contact>>(

            initialData: List(),
            future: /*Future.delayed(Duration(seconds: 1)).then((value) => */dependencies.contactDao.findAll()/*)*/,

            builder: (context, snapshot){

              switch(snapshot.connectionState){


                case ConnectionState.none:
                  break;

                case ConnectionState.waiting:
                  return Progress(message: "Loading contacts...");
                  break;

                case ConnectionState.active:
                  break;

                case ConnectionState.done:
                  final List<Contact> contacts = snapshot.data;

                  return ListView.builder(

                    itemBuilder: (context, index){

                      return ContactItem(contacts[index], onClick: (){
                      
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => TransactionForm(contacts[index])
                            ),
                        );
                      },);
                    },


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
                MaterialPageRoute(builder: (context) { return ContactForm(); })
            ).then((value) {
              setState(() {
                widget.createState();
              });
            });
          },

          child: Icon(Icons.add),

      ),
    );
  }
}


class ContactItem extends StatelessWidget {

  final Contact contact;
  final Function onClick;

  ContactItem(this.contact, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(

        onTap: () => onClick(),

        title: Text(contact.name, style: TextStyle(fontSize: 24.0),),


        subtitle: Text(contact.accountNumber.toString(), style: TextStyle(fontSize: 16.0),),
      ),
    );
  }
}
