import 'package:admin_side/model/Destinationorder.dart';
import 'package:admin_side/screens.dart/destinationorderscreen.dart';
import 'package:admin_side/screens.dart/handicraftorder.dart';
import 'package:admin_side/screens.dart/orderscreen.dart';
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
      appBar: AppBar(
        title: Text("Admin"),
        actions: [
          FlatButton.icon(
            icon: Icon(Icons.qr_code),
            label: Text("Barcode"),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => Handicraftorder())),
          ),
          FlatButton(
            child: Text("Orders"),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => Orderscreen())),
          ),
          FlatButton(
              child: Text("Hoders"),
              onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (ctx) => DestinationOrderscreen()),
                  ))
        ],
      ),
      body: null,
    );
  }
}
