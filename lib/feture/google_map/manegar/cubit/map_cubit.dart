import 'dart:developer';

import 'package:admin/feture/stations/widget/add_station.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';
import '/feture/google_map/data/model/bus_model.dart';

import '../../../../core/utils/manger/method.dart';
import '../../data/model/routes_model/routes_model.dart';
import '../../../../core/utils/ApiServes/map_service.dart';
import '../../../../core/utils/ApiServes/routes_service.dart';
import 'package:dio/dio.dart';

import '../../data/model/station_model.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());
  static MapCubit get(context) => BlocProvider.of<MapCubit>(context);

  /////////////////////////////
  GoogleMapController? googleMapController;

  List<LatLng> polylineCoordinates = [];
  Set<Polyline> polylines = {};
  MapService mapService = MapService();
  LatLng? userLocationData;
  LatLng? userDestnationData;
  StationModel? newStation;
  RoutesService routesService = RoutesService();
  Set<Marker> markers = {};
  List<StationModel> stationModel = [];
  LatLng? busLocation, endStation;

  PolylinePoints polylinePoints = PolylinePoints();
  BusModel? selectedBus;
  late StationModel selectStation;

  Dio dio = Dio();
/////////////////////////////////////////////

  void mapServiceApp() async {
    try {
      emit(MapCheckService());
      mapService.getUserRealTimeLocation((position) {
        userLocationData = LatLng(position.latitude!, position.longitude!);
        googleMapController?.animateCamera(
          CameraUpdate.newLatLng(
            userLocationData!,
          ),
        );
        // setUserMarker(position);
      });
      setStation();
      emit(MapSuccess());
    } on ServiceEnabelExption catch (e) {
      // TODO
    } on PermissionExption catch (e) {
      // TODO
    } on Exception catch (e) {
      //TODO :
    }
  }

  void setUserMarker(LocationData position) async {
    emit(MapSetMarker());
    markers.add(
      Marker(
        markerId: const MarkerId('user location'),
        position: LatLng(position.latitude!, position.longitude!),
      ),
    );
    // if (polylineCoordinates.isNotEmpty) {
    //routesService.destans(userDestnationData, userLocationData);
    // }
  }

  Stream<List<StationModel>> streamStation() async* {
    yield* FirebaseFirestore.instance.collection('station').snapshots().map(
        (querySnapshot) => querySnapshot.docs
            .map((doc) => StationModel.fromJson(
                doc.data() as Map<String, dynamic>, doc.id))
            .toList());
  }

  Future<void> getStationFromFireBase() async {
    emit(LodeingStation());
    streamStation().listen((fetchedStation) async {
      try {
        stationModel = fetchedStation;
        log(stationModel.toString());
        setStation();

        emit(SuccessLoding());
      } on Exception catch (e) {
        emit(FiluerLoding());
      }
    });
  }

  Future<void> updateStation() async {
    emit(ChangeStationData());

    await FirebaseFirestore.instance
        .collection('station')
        .doc(selectStation.Id)
        .update({
      'name': selectStation.name,
    });
    emit(ChangeStationData());
  }

  Future<void> addStation(String stationName) async {
    emit(ChangeStationData());

    await FirebaseFirestore.instance.collection('station').add({
      'name': stationName,
      'stationLocation': newStation!.stationLocation,
    });
    emit(ChangeStationData());
  }

  void setStation() async {
    emit(SetStationOnMap());
    var customMarkerIcone = BitmapDescriptor.fromBytes(
        await getImageFromRowData('assets/images/marker.jpg', 50));
    var myMarker = stationModel
        .map((station) => Marker(
              icon: customMarkerIcone,
              markerId: MarkerId(station.name),
              position: LatLng(station.stationLocation.latitude,
                  station.stationLocation.longitude),
              infoWindow: InfoWindow(title: station.name),
            ))
        .toSet();
    log(markers.toString());
    markers = myMarker;
    log(markers.toString());
    emit(SuccessSetStation());
  }

  Future<void> clearPolyLineOnTap() async {
    polylineCoordinates.clear();

    polylines.clear();
    // if (busLocation != null && endStation != null) {
    //   displayBusPoint(await getRouteBusData());
    // }
    emit(MapClear());
  }

  Future<void> clear() async {
    polylineCoordinates.clear();
    polylines.clear();
    if (busLocation != null && endStation != null) {
      selectedBus = null;
      busLocation = null;
      endStation = null;
    }
    markers.removeWhere((marker) => marker.markerId.value == 'selected_bus');
    emit(MapClear());
  }

  Future<List<LatLng>> getRouteUserData() async {
    RoutesModel route = await routesService.fetchRoutes(
        origindata: userLocationData!, destinationData: userDestnationData!);

    List<PointLatLng> result = polylinePoints
        .decodePolyline(route.routes!.first.polyline!.encodedPolyline!);
    List<LatLng> pointes =
        result.map((e) => LatLng(e.latitude, e.longitude)).toList();
    log("${pointes}");

    return pointes;
  }

  void displayUserPoint(List<LatLng> point) {
    Polyline route = Polyline(
        polylineId: PolylineId('userRoute'),
        points: point,
        color: Colors.green,
        startCap: Cap.roundCap,
        width: 4);
    polylines.add(route);
    emit(MapSetLine());
  }

  void setSelectedBus(BusModel busModel) {
    selectedBus = busModel;
    log("${selectedBus!.startStation.latitude} ${selectedBus!.endStation.latitude}");
    emit(SetSelectedBus());
  }

  Future<void> displaySelectedBusLocation() async {
    if (selectedBus != null) {
      LatLng busLocation = LatLng(selectedBus!.busLocation.latitude,
          selectedBus!.busLocation.longitude);
      Marker busMarker = Marker(
        markerId: MarkerId('selected_bus'),
        position: busLocation,
        icon: BitmapDescriptor.fromBytes(
          await getImageFromRowData('assets/images/marker.jpg', 50),
        ),
      );
      markers.removeWhere((marker) => marker.markerId.value == 'selected_bus');

      markers.add(busMarker);
      emit(MapSetMarker());
    }
  }

  void displayBusPoint(List<LatLng> point) {
    Polyline route = Polyline(
        polylineId: PolylineId('busRoute'),
        points: point,
        color: Colors.green,
        startCap: Cap.roundCap,
        width: 4);
    polylines.add(route);

    emit(MapSetLine());
  }
}
