import 'package:admin/core/utils/localization/app_localaization.dart';
import 'package:admin/feture/driver/data/model/DriverModel.dart';
import 'package:flutter/material.dart';

class DriverCard extends StatelessWidget {
  DriverModel driverModel;

  DriverCard({Key? key, required this.driverModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40.0,
                backgroundImage: NetworkImage(driverModel.photoUrl ?? ""),
                backgroundColor: Colors.grey[200],
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      driverModel.driverName,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Phone:'.tr(context) + ' ${driverModel.phoneNumber}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Bus Number:'.tr(context) + ' ${driverModel.busNum}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
