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
                      height: 100,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          snapshot.data[i].imageurl,
                          fit: BoxFit.fill,
                          height: 200,
                          width: 50,
                        ),
                      ),
                    ),
                    title: Text(snapshot.data[i].city,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    subtitle: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.person),
                            Text('Number of Persons = ',style: TextStyle(fontSize: 15),),
                            Text(
                                "${snapshot.data[i].noofperson}"),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.attach_money),
                            Text('Amount =  ',style: TextStyle(fontSize: 15),),
                            Text(
                                "${snapshot.data[i].amount}"),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.date_range),
                            Text('Booked On  ',style: TextStyle(fontSize: 15),),
                            Text(
                                "${snapshot.data[i].pickeddate}"),
                          ],
                        ),
                        Divider(thickness: 10,),
                      ],
                    ),
//                          trailing: Text(snapshot.data[i].amount),
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
