import 'package:admin_side/model/Destinationorder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DestinationOrderscreen extends StatefulWidget {
  DestinationOrderscreen({Key key}) : super(key: key);

  @override
  _DestinationOrderscreenState createState() => _DestinationOrderscreenState();
}

class _DestinationOrderscreenState extends State<DestinationOrderscreen> {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  Stream<List<Destinationorder>> readEntries() {
    return _db
        .collection('destinationorders')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Destinationorder.fromJson(doc.data()))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Orders"),
        ),
        body: StreamBuilder<List<Destinationorder>>(
            stream: readEntries(),
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  return snapshot.data.length != 0
                      ? ListTile(
                          leading: Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                snapshot.data[i].imageurl,
                                fit: BoxFit.fill,
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ),
                          title: Text(snapshot.data[i].city),
                          subtitle: Text(
                              "No Of Person :${snapshot.data[i].noofperson}\nPicked Date:${snapshot.data[i].pickeddate}\ntransactionid:${snapshot.data[i].paymentid}\nphoneno:${snapshot.data[i].phoneno}"),
                          trailing: Text(snapshot.data[i].amount),
                        )
                      : Container(
                          height: size.height,
                          width: size.width,
                          color: Colors.white,
                          child: Center(child: Text("There are no orders")));
                },
              );
            }));
  }
}
