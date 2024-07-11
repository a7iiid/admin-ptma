import 'package:admin/core/utils/localization/app_localaization.dart';
import 'package:admin/feture/Bus/data/bus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../google_map/data/model/station_model.dart';
import '../../../google_map/manegar/cubit/select_rout_cubit.dart';
import '../../../home/presentation/view/widget/station_menue.dart';

class AddBus extends StatelessWidget {
  AddBus({super.key});
  TextEditingController nameBus = TextEditingController();

  TextEditingController numBus = TextEditingController();
  StationModel? sourseStation;

  StationModel? distnationStation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Bus".tr(context)),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: nameBus,
                  decoration:
                      InputDecoration(labelText: 'Bus Name'.tr(context)),
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: TextFormField(
                  controller: numBus,
                  decoration:
                      InputDecoration(labelText: 'Bus Number'.tr(context)),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          DropMenuItem(
            location: sourseStation,
            onChanged: (value) {
              sourseStation = value;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          DropMenuItem(
            location: distnationStation,
            onChanged: (value) {
              distnationStation = value;
            },
          ),
          SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: () async {
              Bus bus = Bus(
                  busLocation: GeoPoint(32.4, 35.1),
                  busname: nameBus.text,
                  busnumber: numBus.text,
                  endStation: distnationStation!.stationLocation,
                  startStation: sourseStation!.stationLocation);

              await SelectRoutCubit.get(context).addBus(bus);
              Navigator.pop(context); // Close the edit page after saving
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
