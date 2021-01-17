import 'package:bharat_bhraman_app/models/destination_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradients/flutter_gradients.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Destinationorderdetailsscreen extends StatelessWidget {
  final String paymentid;
  final Destination destination;
  final String amount;
  final int noofperson;
  final String name;
  final String pickeddate;

  Destinationorderdetailsscreen(
      {Key key,
      this.destination,
      this.paymentid,
      this.amount,
      this.noofperson,
      this.name,
      this.pickeddate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          backgroundColor: Colors.orangeAccent.shade100,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text("Your Ticket",style: TextStyle(color: Colors.black),),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: FlutterGradients.blessing(
              tileMode: TileMode.clamp,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QrImage(
                  data:
                      'name:$name\n amuont:$amount\nplace:${destination.city}\nNo Of Person:$noofperson\nPicked Date:$pickeddate \n  transactionid:$paymentid'),
              SizedBox(
                height: 20,
              ),
              Text("Kindly Take Screenshot for future Refrence"),
            ],
          ),
        ));
  }
}
