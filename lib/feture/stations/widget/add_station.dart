import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../google_map/manegar/cubit/map_cubit.dart';

class AddStation extends StatefulWidget {
  AddStation({super.key});

  @override
  State<AddStation> createState() => _AddStationState();
}

class _AddStationState extends State<AddStation> {
  @override
  TextEditingController stationName = TextEditingController();

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        stationName.text = MapCubit.get(context).selectStation.name;
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
                  MapCubit.get(context).newStation!.name = stationName.text;
                  await MapCubit.get(context).updateStation();

                  Navigator.of(context).pop();
                } // Close the dialog
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    var cubit = MapCubit.get(context);
    return BlocBuilder<MapCubit, MapState>(builder: (context, state) {
      return PopScope(
          canPop: true,
          onPopInvoked: (didPop) {
            MapCubit.get(context).clear();
          },
          child: GoogleMap(
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
            onTap: (destnation) async {
              try {
                cubit.newStation!.stationLocation = destnation as GeoPoint;
                _showEditDialog(context);
                //cubit.displayUserPoint(await cubit.getRouteUserData());
              } catch (e) {}
            },
            markers: cubit.markers,
            polylines: cubit.polylines,
          ));
    });
  }
}
