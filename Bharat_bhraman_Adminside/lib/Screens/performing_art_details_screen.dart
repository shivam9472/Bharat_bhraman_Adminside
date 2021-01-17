import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradients/flutter_gradients.dart';
import '../models/performing_arts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PerformingArtsDetailScreen extends StatefulWidget {
  final PerformingArts performingArts;

  PerformingArtsDetailScreen({this.performingArts});

  @override
  _PerformingArtsDetailScreenState createState() => _PerformingArtsDetailScreenState();
}

class _PerformingArtsDetailScreenState extends State<PerformingArtsDetailScreen> {

  @override
  Widget build(BuildContext context) {
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
                      tag: widget.performingArts.imageUrl,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        child: Image(
                          image: NetworkImage(widget.performingArts.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 0.0,
                    bottom: 20.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.performingArts.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
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
                                widget.performingArts.state,
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
              SizedBox(height: 10,),
              Container(
                child: Text(
                  widget.performingArts.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(

                height: MediaQuery.of(context).size.height*0.3,

                child: SingleChildScrollView(
                  child: Text(
                    widget.performingArts.description,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
