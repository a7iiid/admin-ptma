import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../data/model/bus_model.dart';
import '../manegar/cubit/map_cubit.dart';

class MapPage extends StatefulWidget {
  MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Listen for bus location changes
    var cubit = MapCubit.get(context);
    cubit.busLocationStream.listen((busLocation) {
      _animateCameraToNewPosition(busLocation);
    });
  }

  void _animateCameraToNewPosition(LatLng newPosition) {
    final cubit = MapCubit.get(context);

    if (cubit.googleMapController != null) {
      cubit.googleMapController!
          .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: newPosition,
        zoom: 15,
      )));
    }
  }

  @override
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
            target: cubit.selectedBus != null
                ? LatLng(cubit.selectedBus!.busLocation.latitude,
                    cubit.selectedBus!.busLocation.longitude)
                : LatLng(cubit.userLocationData!.latitude,
                    cubit.userLocationData!.longitude),
            zoom: 15,
          ),
          onMapCreated: (controller) {
            cubit.googleMapController = controller;
          },
          onTap: (destination) async {
            try {
              cubit.userDestnationData =
                  LatLng(destination.latitude, destination.longitude);
              cubit.displayUserPoint(await cubit.getRouteUserData());
            } catch (e) {
              log(e.toString());
            }
          },
          markers: cubit.markers,
          polylines: cubit.polylines,
        ),
      );
    });
  }
}
