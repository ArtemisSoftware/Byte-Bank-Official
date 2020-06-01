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
          Padding(
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
                      Icon(Icons.people,
                        color: Colors.white,
                        size: 24.0 ,
                      ),
                      Text("Contacts",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



