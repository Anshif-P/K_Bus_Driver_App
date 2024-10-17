import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_bus_driver/network/shared_preferences/shared_pref_model.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserTokenCheckingEvent>(userTokenCheckingEvent);
  }

  FutureOr<void> userTokenCheckingEvent(
      UserTokenCheckingEvent event, Emitter<UserState> emit) {
    final token = SharedPrefModel.instance.getData('token');
    if (token != null) {
      emit(UserTokenFoundState(token: token));
    } else {
      emit(UserTokenNotFoundState());
    }
  }
}
