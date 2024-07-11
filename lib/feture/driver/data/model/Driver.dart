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
      bus_num: json['bus_num'] ?? 0,
      email: json['email'] ?? '',
      id: json['uid'] ?? "",
      name: json['display_name'] ?? "",
      status: json['status'] ?? true,
      user_loc: (json['user_loc']) ?? GeoPoint(32.4, 35.1),
      salary: json['salary'] ?? 0,
      phone: json['phone_number'] ?? '',
      photo_url: json['photo_url'] ??
          "https://firebasestorage.googleapis.com/v0/b/ptma-9c13f.appspot.com/o/cms_uploads%2FUsers%2F1718225499895000%2Fistockphoto-1316420668-612x612.jpg?alt=media&token=1192bb4d-b7de-41d9-a982-824becc7a452",
    );
  }
}
