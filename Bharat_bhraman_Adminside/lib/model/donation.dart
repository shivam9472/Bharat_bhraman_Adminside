import 'package:flutter/material.dart';

class Donation {
  final String description;

  final String date;
  Donation({this.description, this.date});
  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      description: json['description'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'description': description, 'date': date};
  }
}
