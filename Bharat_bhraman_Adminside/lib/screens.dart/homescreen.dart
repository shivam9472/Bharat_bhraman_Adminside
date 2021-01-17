import 'package:admin_side/model/Destinationorder.dart';
import 'package:admin_side/screens.dart/createdonationscreen.dart';
import 'package:admin_side/screens.dart/destinationorderscreen.dart';
import 'package:admin_side/screens.dart/handicraftorder.dart';
import 'package:admin_side/screens.dart/main_drawer.dart';
import 'package:admin_side/screens.dart/orderscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  Homescreen({Key key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => CreateDonationScreen())),
      ),
      appBar: AppBar(
        title: Text("Admin"),
//        actions: [
//          FlatButton.icon(
//            icon: Icon(Icons.qr_code),
//            label: Text("Barcode"),
//            onPressed: () => Navigator.of(context)
//                .push(MaterialPageRoute(builder: (ctx) => Handicraftorder())),
//          ),
//          FlatButton(
//            child: Text("Orders"),
//            onPressed: () => Navigator.of(context)
//                .push(MaterialPageRoute(builder: (ctx) => Orderscreen())),
//          ),
//          FlatButton(
//              child: Text("Hoders"),
//              onPressed: () => Navigator.of(context).push(
//                    MaterialPageRoute(
//                        builder: (ctx) => DestinationOrderscreen()),
//                  ))
//        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Welcome to the admin section ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 0,
              child: Image.network(
                  'https://static.vecteezy.com/system/resources/thumbnails/000/512/900/small/122_-_3_-_Under_Maintenance.jpg'),
            ),
          ],
        ),
      ),
    );
  }
}
