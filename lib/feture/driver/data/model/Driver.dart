import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Driver {
  int? bus_num;
  String? name;
  String? email;
  bool? status;
  String? id;
  GeoPoint? user_loc;
  int? salary;
  String? phone;
  String? photo_url;

  Driver(
      {this.bus_num,
      this.email,
      this.id,
      this.name,
      this.status,
      this.user_loc,
      this.salary,
      this.phone,
      this.photo_url});

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      bus_num: json['bus_num'],
      email: json['email'],
      id: json['uid'],
      name: json['display_name'],
      status: json['status'],
      user_loc: (json['user_loc']),
      salary: json['salary'],
      phone: json['phone_number'],
      photo_url: json['photo_url'],
    );
  }
}
