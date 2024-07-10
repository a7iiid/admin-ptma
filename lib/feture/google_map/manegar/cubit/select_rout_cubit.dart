import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import '../../../Bus/data/bus.dart';
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
        .snapshots()
        .map((querySnapshot) {
      log(querySnapshot.docs.toString());
      return querySnapshot.docs
          .map((doc) {
            final data = doc.data() as Map<String, dynamic>?;
            if (data != null) {
              return BusModel.fromJson(data, doc.id);
            } else {
              log("Null data in document: ${doc.id}");
              return null;
            }
          })
          .cast<BusModel>()
          .toList();
    });
  }

  void loadBusModels() async {
    streamBusModels().listen((fetchedBusModels) async {
      try {
        busModel = fetchedBusModels;

        log(fetchedBusModels.toString());

        emit(StreamBusModel(busModel: fetchedBusModels));
      } catch (e) {
        log("Error loading bus models: $e");
        emit(StreamBusModel(busModel: [])); // Emit empty list on error
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
      'isActive': selectBus.isActive,
    });
  }

  void enabelBus() {
    emit(ChangeBusData());
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

  Future<void> addBus(Bus bus) async {
    emit(AddBusState());
    await FirebaseFirestore.instance.collection("bus").add({
      "busname": bus.busname,
      "busnumber": bus.busnumber,
      "endStation": bus.endStation,
      "startStation": bus.startStation,
      "busLocation": bus.busLocation,
      "isActive": true
    });
    emit(AddBusState());
  }
}
