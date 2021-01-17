import 'package:bharat_bhraman_app/Screens/handicraftordeconfirmation.dart';
import 'package:bharat_bhraman_app/models/order.dart';
import 'package:bharat_bhraman_app/services/orderfirebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradients/flutter_gradients.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../models/handicraft_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HandicraftDetailScreen extends StatefulWidget {
  final Handicraft handicraft;
  final String uid;

  HandicraftDetailScreen({this.handicraft, this.uid});

  @override
  _HandicraftDetailScreenState createState() => _HandicraftDetailScreenState();
}

class _HandicraftDetailScreenState extends State<HandicraftDetailScreen> {
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
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: FlutterGradients.blessing(
              tileMode: TileMode.clamp,
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10,),
              Stack(
                children: <Widget>[

                  Container(
                    height: MediaQuery.of(context).size.width*0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Hero(
                      tag: widget.handicraft.imageUrl,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        child: Image(
                          image: NetworkImage(widget.handicraft.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 20.0,
                    bottom: 0.0,
                    child: Container(
                        width: 300,
                        color: Colors.black54,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            widget.handicraft.name,
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
                                widget.handicraft.address,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  widget.handicraft.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "M.R.P: Rs${widget.handicraft.amount}",
                style: GoogleFonts.acme(
                    textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                )),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(30),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    widget.handicraft.description,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.9,
                child: RaisedButton(
                    color: Colors.amber,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    child: Text(
                      "Buy Now",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => Handicraftorderconfirmation(
                              uid: widget.uid,
                              handicraft: widget.handicraft,
                            )))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
