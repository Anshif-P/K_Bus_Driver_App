import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_bus_driver/network/api_service/api_service.dart';
import 'package:k_bus_driver/network/shared_preferences/shared_pref_model.dart';
import 'package:k_bus_driver/repositories/bus_repo.dart';

part 'add_bus_event.dart';
part 'add_bus_state.dart';

class AddBusBloc extends Bloc<AddBusEvent, AddBusState> {
  AddBusBloc() : super(AddBusInitial()) {
    on<AddBusDetailsEvent>(addBusDetailsEvent);
  }

  FutureOr<void> addBusDetailsEvent(
      AddBusDetailsEvent event, Emitter<AddBusState> emit) async {
    emit(AddBusLoadingState());
    final token = await SharedPrefModel.instance.sharePrefObj.get('token');
    final either = await BusRepositories().addBusDetails({
      'busName': event.busName,
      'busNumber': event.busNumber,
      'busColor': event.busColor,
      'busType': event.busType,
      'ownerName': event.busName,
      'ownerPhone': event.ownerPhone,
      'assistentPhone': event.assistentPhon
    }, token);

    either
        .fold((error) => emit(AddBusDetailsFailedState(message: error.message)),
            (response) {
      if (response['message'] == "Route added successfully.") {
        SharedPrefModel.instance
            .insertData('busId', response['busDetails']['busId']);
        emit(AddBusDetailsSuccessState());
      } else {
        emit(AddBusDetailsFailedState(message: response["message"]));
      }
    });
  }
}
