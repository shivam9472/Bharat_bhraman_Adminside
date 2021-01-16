import 'package:admin_side/model/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Orderscreen extends StatefulWidget {
  Orderscreen({Key key}) : super(key: key);

  @override
  _OrderscreenState createState() => _OrderscreenState();
}

class _OrderscreenState extends State<Orderscreen> {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  Stream<List<Order>> readEntries() {
    return _db
        .collection('handicraftorders')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Order.fromJson(doc.data())).toList());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Handicraft Orders"),
      ),
      body: StreamBuilder<List<Order>>(
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
                      title: Text(
                          "${snapshot.data[i].name}\nYour Name:${snapshot.data[i].cname}\nAddress:${snapshot.data[i].address},${snapshot.data[i].city},${snapshot.data[i].state},${snapshot.data[i].pincode}\nphoneno:${snapshot.data[i].phoneno}"),
                      subtitle: Text(snapshot.data[i].amount),
                      trailing: Text(snapshot.data[i].transactionid),
                    )
                  : Container(
                      height: size.height,
                      width: size.width,
                      color: Colors.white,
                      child: Center(child: Text("There are no orders")));
            },
          );
        },
      ),
    );
  }
}
