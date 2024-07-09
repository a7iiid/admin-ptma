import 'package:cloud_firestore/cloud_firestore.dart';

class StationModel {
  String name;
  GeoPoint stationLocation;
  String Id;

  StationModel(
      {required this.Id, required this.stationLocation, required this.name});
  factory StationModel.fromJson(Map<String, dynamic> json, String id) {
    return StationModel(
      Id: id,
      name: json['name'],
      stationLocation: json['stationLocation'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'name': name, 'stationLocation': stationLocation};
  }
}
