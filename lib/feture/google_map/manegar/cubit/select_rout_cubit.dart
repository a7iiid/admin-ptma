import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import '/feture/google_map/data/model/distance_model/distance_model.dart';
import '/feture/google_map/manegar/cubit/driver_cubit.dart';

import '../../../../core/utils/apiKey.dart';
import '../../data/model/bus_model.dart';
import '../../data/model/station_model.dart';

part 'select_rout_state.dart';

class SelectRoutCubit extends Cubit<SelectRoutState> {
  SelectRoutCubit() : super(SelectRoutInitial());
  static SelectRoutCubit get(context) =>
      BlocProvider.of<SelectRoutCubit>(context);

////////////////////////////////////////
  List<BusModel> busModel = [];
  List<BusModel> listBusFilter = [];
  StationModel? sourceStation;
  StationModel? distnationStation;
  Dio dio = Dio();
  late BusModel selectBus;

////////////////////////////////////

  Stream<List<BusModel>> streamBusModels() async* {
    yield* FirebaseFirestore.instance
        .collection('bus')
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) =>
                BusModel.fromJson(doc.data() as Map<String, dynamic>, doc.id))
            .toList());
  }

  void loadBusModels() async {
    streamBusModels().listen((fetchedBusModels) async {
      try {
        log(fetchedBusModels.toString());

        busModel = fetchedBusModels;
        for (var busModel in fetchedBusModels) {
          final busLocation = LatLng(
              busModel.busLocation.latitude, busModel.busLocation.longitude);
          final destinationLocation = LatLng(
              busModel.endStation.latitude, busModel.endStation.longitude);
          busModel.duration = await destans(busLocation, destinationLocation);
        }
        emit(StreamBusModel(busModel: fetchedBusModels));
      } catch (e) {
        // Handle error
        log("Error loading bus models: $e");
      }
    });
  }

  void updateSourceStation(StationModel? station) {
    emit(ChangeSourceStation());
    if (station != null) {
      sourceStation = station;
      emit(UpdateStation());
    }
  }

  Future<void> updateBusData() async {
    emit(ChangeBusData());

    await FirebaseFirestore.instance
        .collection('bus')
        .doc(selectBus.id)
        .update({
      'busname': selectBus.busname,
      'busnumber': selectBus.busnumber,
      'endStation': selectBus.endStation,
      'startStation': selectBus.startStation,
    });
  }

  Future<DistanceModel> destans(LatLng destination, LatLng source) async {
    String baseUrlDistanceMatrix =
        'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=${destination.latitude},${destination.longitude}&origins=${source.latitude},${source.longitude}&key=${ApiKey.mapApiKey}';
    try {
      Response response = await dio.get(baseUrlDistanceMatrix);
      DistanceModel result =
          DistanceModel.fromJson(response.data as Map<String, dynamic>);
      return result;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
