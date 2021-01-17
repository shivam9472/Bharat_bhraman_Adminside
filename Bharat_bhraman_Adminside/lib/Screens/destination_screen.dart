import 'package:bharat_bhraman_app/Screens/destinationorderdetailsscreen.dart';
import 'package:bharat_bhraman_app/Screens/orderconfirmationscreen.dart';

import 'package:bharat_bhraman_app/services/orderfirebase.dart';
import 'package:bharat_bhraman_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradients/flutter_gradients.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shimmer/shimmer.dart';
import '../models/destination_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:date_format/date_format.dart';
import 'package:url_launcher/url_launcher.dart';

class DestinationScreen extends StatefulWidget {
  final Destination destination;
  final String uid;
  DestinationScreen({this.destination, this.uid});

  @override
  _DestinationScreenState createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  String imageurl;

  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
  }

  _launchURL(String mapkaurl) async {
    String url = mapkaurl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent.shade100,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Bharat Bhraman",style: TextStyle(color: Colors.black),),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: FlutterGradients.blessing(
              tileMode: TileMode.clamp,
            ),
          ),
          child: Column(

            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              CircleAvatar(
                radius: 60.0,
                backgroundImage:
                NetworkImage('https://toppng.com/uploads/preview/welcome-to-rajnagar-welcome-hand-11562969553eyjkkrcux0.png'),
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 10,),
              Text('Welcome !!',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: MediaQuery.of(context).size.width*0.7,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(0.0, 2.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Hero(
                        tag: widget.destination.imageUrl,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(0),
                            bottomLeft: Radius.circular(0),

                          ),
                          child: Image(
                            image: NetworkImage(widget.destination.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 20.0,
                    bottom: 20.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.9,

                      color: Colors.black54,
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(

                            widget.destination.city,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.locationArrow,
                                size: 15.0,
                                color: Colors.white70,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                widget.destination.country,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20.0,
                    bottom: 20.0,
                    child: Shimmer.fromColors(
                      baseColor: Colors.blue,
                      highlightColor: Colors.white,
                      child: IconButton(
                        icon: Icon(
                          Icons.location_on,
                          color: Colors.white70,
                          size: 35.0,
                        ),
                        onPressed: () => _launchURL(widget.destination.mapUrl),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Positioned(
                child: RaisedButton(
                    color: Colors.amber,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    child: Text(
                      "Book Tickets  At Rs.${widget.destination.amount}",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => Orderconfirmationscreen(
                              destination: widget.destination,
                              uid: widget.uid,
                            )))),
              ),
              Positioned(
                child: RaisedButton(
                    color: Colors.amber,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    child: Text(
                      "See Hotels Near.${widget.destination.city}",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () => null,
              ),

              ),
              Positioned(
                child: RaisedButton(
                    color: Colors.amber,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Check Flights",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Icon(FontAwesomeIcons.plane),
                      ],
                    ),
                    onPressed: () => null,
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
