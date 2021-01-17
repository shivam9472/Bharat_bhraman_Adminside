import 'package:flutter/material.dart';

class Donation {
  final String description;
  final String imageurl;
  Donation({this.description, this.imageurl});
  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      description: json['description'],
      imageurl: json['imageurl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'imageurl': imageurl,
    };
  }
}
