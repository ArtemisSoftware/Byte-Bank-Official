import 'package:bytebankofficial/screens/contacts_list.dart';
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
          Row(
            children: [
              _FeatureItem("Transfer", Icons.monetization_on),
              _FeatureItem("Transaction Feed", Icons.description),
            ],
          ),
        ],
      ),
    );
  }
}


class _FeatureItem extends StatelessWidget {

  final String name;
  final IconData icon;


  _FeatureItem(this.name, this.icon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(

        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return ContactsList();
                })
            );
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            height :100,
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



