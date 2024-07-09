import 'dart:developer';

import 'package:admin/feture/google_map/data/model/station_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import '../data/bus.dart';

part 'bus_state.dart';

class BusCubit extends Cubit<BusState> {
  BusCubit() : super(BusInitial());
 static BusCubit get(context) =>
      BlocProvider.of<BusCubit>(context);

////////////////////////////////////////
  List<Bus> busModel = [];
  StationModel? sourceStation;
  StationModel? distnationStation;
  Dio dio = Dio();

////////////////////////////////////

  Stream<List<Bus>> streamBusModels() async* {
    yield* FirebaseFirestore.instance
        .collection('bus')
        
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) =>
                Bus.fromJson(doc.data() as Map<String, dynamic>, doc.id))
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
        }
        emit(StreamBusModel(busModel: fetchedBusModels));
      } catch (e) {
        // Handle error
        log("Error loading bus models: $e");
      }
    });
  }

 

  

  
  
}
