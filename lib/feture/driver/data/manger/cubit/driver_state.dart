part of 'driver_cubit.dart';

@immutable
sealed class DriverState {}

class DriverInitial extends DriverState {}

class DriverLoading extends DriverState {}

class DriverLoaded extends DriverState {
  final List<Driver> drivers;
  DriverLoaded({required this.drivers});
}

class DriverFailure extends DriverState {
  final String error;
  DriverFailure({required this.error});
}

class SelecteDriver extends DriverState {}

class DriverHistoryLoading extends DriverState {}

class DriverHistorySuccess extends DriverState {
  List<History> historyDriver;
  DriverHistorySuccess({required this.historyDriver});
}

class DriverHistoryFailure extends DriverState {}
