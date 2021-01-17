import 'package:bharat_bhraman_app/models/donation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'home_screen.dart';

class Doantionscreen extends StatefulWidget {
  Doantionscreen({Key key}) : super(key: key);

  @override
  _DoantionscreenState createState() => _DoantionscreenState();
}

class _DoantionscreenState extends State<Doantionscreen> {
  Razorpay _razorpay;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  int amount;
  Stream<List<Donation>> readEntries() {
    return _db
        .collection('donation')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Donation.fromJson(doc.data())).toList());
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(int amount) async {
    var options = {
      'key': 'rzp_test_XEbBJxAGMnU2k6',
      'amount': amount * 100,
      'name': "donate",
      'prefill': {'contact': '7909050933', 'email': 'shivam9472@gmail.om'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // final qrimage = QrImage(
    //     data:
    //         'amuont:${widget.destination.amount}\nplace:${widget.destination.city}\ntransactionid:${response.paymentId}');
    // File _image = qrimage as File;
    // await firebase_storage.FirebaseStorage.instance
    //     .ref('qrcode/${widget.uid}')
    //     .putFile(_image);

    // imageurl = await firebase_storage.FirebaseStorage.instance
    //     .ref('qrcode/${widget.uid}')
    //     .getDownloadURL();

    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIosWeb: 4);
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen()));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Donate"),
      ),
      body: StreamBuilder<List<Donation>>(
        stream: readEntries(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, i) {
              return ListTile(
                title: Text(snapshot.data[i].description),
                trailing: RaisedButton(
                    color: Colors.amber,
                    child: Text(
                      "Doante",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    onPressed: () {
                      showMaterialModalBottomSheet(
                          expand: true,
                          context: context,
                          builder: (ctx) => Container(
                                width: size.width,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'OpenSans',
                                      ),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding:
                                              EdgeInsets.only(top: 14.0),
                                          hintText: 'Amount',
                                          hintStyle: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'OpenSans',
                                          )),
                                      textInputAction: TextInputAction.next,
                                      onChanged: (value) {
                                        amount = int.parse(value);
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                    ),
                                    RaisedButton(
                                        color: Colors.amber,
                                        child: Text(
                                          "Doante",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18)),
                                        onPressed: () => openCheckout(amount)),
                                  ],
                                ),
                              ));
                    }),
              );
            },
          );
        },
      ),
    );
  }
}
