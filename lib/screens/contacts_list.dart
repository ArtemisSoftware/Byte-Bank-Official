import 'package:bytebankofficial/components/progress.dart';
import 'package:bytebankofficial/database/dao/contact_dao.dart';
import 'package:bytebankofficial/models/contact.dart';
import 'package:bytebankofficial/screens/contact_form.dart';
import 'package:bytebankofficial/screens/transaction_form.dart';
import 'package:flutter/material.dart';



/*
class ContactsList extends StatelessWidget {
  //final ContactDao _dao = ContactDao();

  final ContactDao contactDao;

  ContactsList({@required this.contactDao});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer'),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: List(),
        future: contactDao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contact> contacts = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Contact contact = contacts[index];
                  return _ContactItem(
                    contact,
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TransactionForm(contact),
                        ),
                      );
                    },
                  );
                },
                itemCount: contacts.length,
              );
              break;
          }
          return Text('Unknown error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ContactForm(),
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
*/



class ContactsList extends StatefulWidget{

  final ContactDao contactDao;

  ContactsList({@required this.contactDao});

  @override
  State<StatefulWidget> createState() {
    return ContactsListState(contactDao: contactDao);
  }
}



class ContactsListState extends State<ContactsList> {


  final ContactDao contactDao;
  ContactsListState({@required this.contactDao});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Transfer"),),


        body : FutureBuilder<List<Contact>>(

            initialData: List(),
            future: /*Future.delayed(Duration(seconds: 1)).then((value) => */contactDao.findAll()/*)*/,

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
                MaterialPageRoute(builder: (context) { return ContactForm(contactDao: contactDao,); })
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
