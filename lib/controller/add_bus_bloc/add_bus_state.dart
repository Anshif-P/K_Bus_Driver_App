part of 'add_bus_bloc.dart';

abstract class AddBusState {}

final class AddBusInitial extends AddBusState {}

final class AddBusDetailsSuccessState extends AddBusState {}

final class AddBusDetailsFailedState extends AddBusState {
  final String message;
  AddBusDetailsFailedState({required this.message});
}

final class AddBusLoadingState extends AddBusState {}
