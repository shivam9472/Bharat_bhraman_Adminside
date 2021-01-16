import './destinationorderscreen.dart';
import './orderscreen.dart';
import './handicraftorder.dart';
import 'package:flutter/material.dart';

import 'handicraftorder.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Welcome to Bharat Bhraman',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                      color: Colors.orangeAccent.shade100),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      child: ClipOval(
                        child: Image.network(
                            'https://png.pngtree.com/png-vector/20190710/ourmid/pngtree-user-vector-avatar-png-image_1541962.jpg'

                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Hello Admin'
                      ,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FlatButton(
            padding: EdgeInsets.all(20),
            minWidth: double.infinity,
            height: 50,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            color: Colors.orangeAccent,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => Handicraftorder(
                  )));
            },
            child: Text(
              "Barcode Scanner",
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            minWidth: double.infinity,
            height: 50,
            color: Colors.pinkAccent.shade100,
            child: Text(
              'Booked Tickets',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () =>
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => DestinationOrderscreen(
                    ))),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            minWidth: double.infinity,
            height: 50,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            color: Colors.indigo,
            onPressed: () =>
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => Orderscreen(
                    ))),
            child: Text(
              "Orders",
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
