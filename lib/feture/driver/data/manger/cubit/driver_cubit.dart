import 'dart:developer';

import 'package:admin/feture/history/data/history.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../model/Driver.dart';

part 'driver_state.dart';

class DriverCubit extends Cubit<DriverState> {
  DriverCubit() : super(DriverInitial());
  static DriverCubit get(context) => BlocProvider.of(context);
  FirebaseFirestore instance = FirebaseFirestore.instance;
  List<Driver> drivers = [];
  late Driver selectDriver;
  List<History> history = [];

  //to get driver data from firebase
  Stream<List<Driver>> streamDriverModel() async* {
    yield* FirebaseFirestore.instance.collection('Users').snapshots().map(
        (querySnapshot) => querySnapshot.docs
            .map((doc) => Driver.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Future<void> loadDriver() async {
    emit(DriverLoading());
    streamDriverModel().listen((fetchedBusModels) async {
      try {
        drivers = fetchedBusModels;
        emit(DriverLoaded(drivers: drivers));
      } catch (e) {
        emit(DriverFailure(error: e.toString()));
      }
    });
  }

//// get trip data for driver
  Stream<List<History>> streamTripeHistory() async* {
    yield* FirebaseFirestore.instance
        .collection('Trips')
        .where('driver_id', isEqualTo: selectDriver.id)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => History.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Future<void> loadTripsDriver() async {
    emit(DriverHistoryLoading());
    streamTripeHistory().listen((fetchedHistory) async {
      try {
        log(fetchedHistory.toString());
        history = fetchedHistory;
        emit(DriverHistorySuccess(historyDriver: history));
      } catch (e) {
        emit(DriverHistoryFailure());
      }
    });
  }

  void selecteDriver(int index) {
    selectDriver = drivers[index];
    emit(SelecteDriver());
  }
}
