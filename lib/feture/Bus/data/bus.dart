import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Bus {
  GeoPoint? busLocation;
  GeoPoint? startStation;

  GeoPoint? endStation;

  String? busname;

  String? busnumber;
  bool? isActive;
  String? id;

  Bus({
    this.busname,
    this.busnumber,
    this.isActive = false,
    this.busLocation,
    this.endStation,
    this.startStation,
    this.id,
  });

  factory Bus.fromJson(Map<String, dynamic> json, String id) {
    return Bus(
      id: id,
      busname: json['busname'],
      busnumber: json['busnumber'],
      busLocation: json['busLocation'],
      endStation: json['endStation'],
      startStation: json['startStation'],
      isActive: json['isActive'],
    );
  }
}
