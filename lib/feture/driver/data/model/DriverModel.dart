class DriverModel {
  String driverName;
  String? photoUrl;
  String phoneNumber;
  String busNum;
  String email;
  DriverModel(
      {required this.driverName,
      required this.phoneNumber,
      required this.busNum,
      required this.email,
      this.photoUrl});

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
        busNum: json['busNum'],
        driverName: json['display_name'],
        phoneNumber: json['phoneNumber'],
        email: json['email'],
        photoUrl: json['photoUrl']);
  }
}
