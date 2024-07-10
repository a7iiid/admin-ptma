import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../google_map/data/model/station_model.dart';
import '../../google_map/manegar/cubit/map_cubit.dart';

class AddStation extends StatefulWidget {
  AddStation({super.key});

  @override
  State<AddStation> createState() => _AddStationState();
}

class _AddStationState extends State<AddStation> {
  TextEditingController stationName = TextEditingController();

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Station Name'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: stationName,
                decoration: InputDecoration(labelText: 'Station Name'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (stationName.text.isNotEmpty) {
                  await MapCubit.get(context).addStation(stationName.text);

                  Navigator.of(context).pop(); // Close the dialog
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var cubit = MapCubit.get(context);
    return BlocBuilder<MapCubit, MapState>(builder: (context, state) {
      return PopScope(
        canPop: true,
        onPopInvoked: (didPop) async {
          await MapCubit.get(context).clear();
        },
        child: Scaffold(
          body: GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target:
                  cubit.userLocationData ?? const LatLng(32.409161, 31.279642),
              zoom: 15,
            ),
            onMapCreated: (controller) {
              cubit.googleMapController = controller;
            },
            onTap: (destination) async {
              if (cubit.newStation == null) {
                cubit.newStation = StationModel(
                  name: '',
                  stationLocation:
                      GeoPoint(0, 0), // Initialize with default value
                );
              }
              cubit.newStation!.stationLocation =
                  convertLatLngToGeoPoint(destination);
              _showEditDialog(context);
            },
            markers: cubit.markers,
            polylines: cubit.polylines,
          ),
        ),
      );
    });
  }
}

GeoPoint convertLatLngToGeoPoint(LatLng latLng) {
  return GeoPoint(latLng.latitude, latLng.longitude);
}
