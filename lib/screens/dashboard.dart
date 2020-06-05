import 'package:bytebankofficial/screens/contacts_list.dart';
import 'package:bytebankofficial/screens/transactions_list.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard"),),

      body: Column(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    child: Image.asset('images/bytebank_logo.png'),
                    fit: BoxFit.fill,
                  )
              ),
            ],
          ),
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _FeatureItem("Transfer", Icons.monetization_on, onClick: (){_showContactsList(context);},),
                _FeatureItem("Transaction Feed", Icons.description, onClick: (){_showTransactionList(context);},),
              ],
            ),
          ),
        ],
      ),
    );
  }


  void _showContactsList(BuildContext context){

    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return ContactsList();
        })
    );
  }

  void _showTransactionList(BuildContext context){

    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return TransactionsList();
        })
    );
  }
}


class _FeatureItem extends StatelessWidget {

  final String name;
  final IconData icon;
  final Function onClick;


  _FeatureItem(this.name, this.icon, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(

        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: (){

            onClick();


          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon,
                  color: Colors.white,
                  size: 24.0 ,
                ),
                Text(name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}



