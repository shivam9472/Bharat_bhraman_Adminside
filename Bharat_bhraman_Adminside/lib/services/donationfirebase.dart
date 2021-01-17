import 'package:admin_side/model/donation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Donationfirebase {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> setEntry(Donation entry, String uuid) {
    var options = SetOptions(merge: true);

    return _db.collection('donation').doc(uuid).set(entry.toMap(), options);
  }
}
