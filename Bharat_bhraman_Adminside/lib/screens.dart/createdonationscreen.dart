import 'dart:io';

import 'package:admin_side/model/donation.dart';
import 'package:admin_side/services/donationfirebase.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';

class CreateDonationScreen extends StatefulWidget {
  CreateDonationScreen({Key key}) : super(key: key);

  @override
  _CreateDonationScreenState createState() => _CreateDonationScreenState();
}

class _CreateDonationScreenState extends State<CreateDonationScreen> {
  File _image;
  String description;

  var uuid = Uuid();

  final picker = ImagePicker();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final firestoreservice = Donationfirebase();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Donation"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextFormField(
              minLines: 1,
              maxLines: 10,
              keyboardType: TextInputType.multiline,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  borderSide: new BorderSide(),
                ),
                contentPadding: EdgeInsets.only(top: 14.0),
              ),
              textInputAction: TextInputAction.newline,
              onChanged: (value) {
                description = value;
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
                color: Colors.amber,
                child: Text(
                  "Create",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                onPressed: () {
                  Donation donation = Donation(
                      description: description,
                      date: DateTime.now().toString());
                  firestoreservice.setEntry(donation, uuid.v1());
                  Navigator.of(context).pop();
                })
          ],
        ),
      ),
    );
  }
}
