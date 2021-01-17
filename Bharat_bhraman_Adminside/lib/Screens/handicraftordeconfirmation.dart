import 'package:bharat_bhraman_app/Screens/orderscreen.dart';
import 'package:bharat_bhraman_app/models/handicraft_model.dart';
import 'package:bharat_bhraman_app/models/order.dart';
import 'package:bharat_bhraman_app/services/orderfirebase.dart';
import 'package:bharat_bhraman_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradients/flutter_gradients.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Handicraftorderconfirmation extends StatefulWidget {
  final Handicraft handicraft;
  final String uid;
  Handicraftorderconfirmation({Key key, this.handicraft, this.uid})
      : super(key: key);

  @override
  _HandicraftorderconfirmationState createState() =>
      _HandicraftorderconfirmationState();
}

class _HandicraftorderconfirmationState
    extends State<Handicraftorderconfirmation> {
  String cname;
  String phoneno;
  String address;
  String city;
  String pincode;
  String state;

  final _formKey = GlobalKey<FormState>();
  Razorpay _razorpay;
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

  void openCheckout(int amount, String imageurl, String city) async {
    var options = {
      'key': 'rzp_test_XEbBJxAGMnU2k6',
      'amount': amount * 100,
      'name': city,
      'description': city,
      'image': imageurl,
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

  final firestoreService = OrederFirebase();

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    var neworder = Order(
        name: widget.handicraft.name,
        amount: widget.handicraft.amount.toString(),
        transactionid: response.paymentId,
        date: DateTime.now().toString(),
        cname: cname,
        address: address,
        city: city,
        imageurl: widget.handicraft.imageUrl,
        phoneno: phoneno,
        pincode: pincode,
        state: state);
    firestoreService.setEntry(neworder, widget.uid, response.paymentId);
    firestoreService.adminsetEntry(neworder, response.paymentId);
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIosWeb: 4);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => OrderScreen(
              uid: widget.uid,
            )));
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
        body: Container(
          decoration: BoxDecoration(
            gradient: FlutterGradients.blessing(
              tileMode: TileMode.clamp,
            ),
          ),
          child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: 100,
                   width: 100,
                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Image.network('https://cdn.iconscout.com/icon/premium/png-256-thumb/checkout-51-623253.png'),
                ),
                SizedBox(height: 10,),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: 60.0,
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: TextFormField(
                      keyboardType: TextInputType.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        hintText: 'Your Name',
                        hintStyle: kHintTextStyle,
                      ),
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        cname = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: 60.0,
                  child: ListTile(
                    leading: Icon(Icons.phone),
                    title:  TextFormField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        hintText: 'Mobile no.',
                        hintStyle: kHintTextStyle,
                      ),
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        phoneno = value;
                      },
                      maxLength: 10,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: ListTile(
              leading: Icon(Icons.location_city),
              title: TextFormField(
                keyboardType: TextInputType.name,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  hintText: 'Address',
                  hintStyle: kHintTextStyle,
                ),
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  address = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: ListTile(
              leading: Icon(Icons.location_on),
              title: TextFormField(
                keyboardType: TextInputType.name,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  hintText: 'City',
                  hintStyle: kHintTextStyle,
                ),
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  city = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: ListTile(
              leading: Icon(FontAwesomeIcons.city),
              title: TextFormField(
                keyboardType: TextInputType.name,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  hintText: 'State',
                  hintStyle: kHintTextStyle,
                ),
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  state = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: ListTile(
              leading: Icon(Icons.code),
              title: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  hintText: 'Pincode',
                  hintStyle: kHintTextStyle,
                ),
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  pincode = value;
                },
                maxLength: 6,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            color: Colors.amber,
            child: Text(
              "Proceed to Payment",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            onPressed: () => openCheckout(
              widget.handicraft.amount,
              widget.handicraft.imageUrl,
              widget.handicraft.name,
            ),
          )
      ],
    ),
        ));
  }
}
