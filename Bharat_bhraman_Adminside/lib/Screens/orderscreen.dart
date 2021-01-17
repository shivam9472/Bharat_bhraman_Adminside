import 'package:bharat_bhraman_app/models/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderScreen extends StatefulWidget {
  final String uid;
  OrderScreen({Key key, this.uid}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  Stream<List<Order>> readEntries() {
    return _db
        .collection('users')
        .doc(widget.uid)
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
        backgroundColor: Colors.orangeAccent.shade100,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Your Orders",style: TextStyle(color: Colors.black),),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
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
                  height: 200,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      snapshot.data[i].imageurl,
                      fit: BoxFit.cover,

                    ),
                  ),
                ),
                title: Text(snapshot.data[i].name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                subtitle: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.person),
                        Text('Name    =  ',style: TextStyle(fontSize: 15,),),
                        Text(
                            "${snapshot.data[i].cname}"),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.attach_money),
                        Text('Amount =  ',style: TextStyle(fontSize: 15),),
                        Text(
                            "Rs. ${snapshot.data[i].amount}"),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on),
                        Text('Address = ',style: TextStyle(fontSize: 15),),
                        Text(
                            "${snapshot.data[i].address}"),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.phone),
                        Text('Contact  = ',style: TextStyle(fontSize: 15),),
                        Text(
                            "${snapshot.data[i].phoneno}"),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.credit_card),
//                        Text('Payment Id ',style: TextStyle(fontSize: 15),),
                        Text(
                            "${snapshot.data[i].transactionid}"),
                      ],
                    ),
                    Divider(thickness: 5,),
                    SizedBox(height: 10,),
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
        },
      ),
    );
  }
}
