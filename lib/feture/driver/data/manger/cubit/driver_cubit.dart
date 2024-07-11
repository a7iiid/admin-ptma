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

//add new driver
  Future<void> addDriver(Driver newDriver) async {
    emit(AddDriver());
    try {
      var doc = await FirebaseFirestore.instance.collection('Users').add({});
      await FirebaseFirestore.instance.collection('Users').doc(doc.id).set({
        'display_name': newDriver.name,
        'email': newDriver.email,
        'phone_number': newDriver.phone,
        'bus_num': newDriver.bus_num,
        'salary': newDriver.salary,
        'photo_url':
            "https://firebasestorage.googleapis.com/v0/b/ptma-9c13f.appspot.com/o/cms_uploads%2FUsers%2F1718225499895000%2Fistockphoto-1316420668-612x612.jpg?alt=media&token=1192bb4d-b7de-41d9-a982-824becc7a452",
        'password': '12345678',
        'status': true, // Assuming status is active when added
      });
      emit(AddDriverSuccess());
    } catch (e) {
      emit(AddDriverFailure());
    }
  }
}
