part of 'add_bus_bloc.dart';

abstract class AddBusEvent {}

class AddBusDetailsEvent extends AddBusEvent {
  String busName;
  String busNumber;
  String busColor;
  String busType;
  String ownerName;
  String ownerPhone;
  String assistentPhon;
  AddBusDetailsEvent(
      {required this.busName,
      required this.busNumber,
      required this.busColor,
      required this.busType,
      required this.ownerName,
      required this.ownerPhone,
      required this.assistentPhon});
}
