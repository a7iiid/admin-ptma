part of 'bus_cubit.dart';

@immutable
sealed class BusState {}

final class BusInitial extends BusState {}

final class FiltringBus extends BusState {}

final class SuccessFiltringBus extends BusState {}

final class LodingBus extends BusState {}

final class LodingBusSuccess extends BusState {}

final class LodingBusFiluer extends BusState {}

final class UpdateStation extends BusState {}

final class ChangeSourceStation extends BusState {}

final class ChangeDistnationStation extends BusState {}

final class StreamBusModel extends BusState {
  final List<Bus> busModel;

  StreamBusModel({required this.busModel});
}
