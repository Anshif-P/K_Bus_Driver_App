import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_bus_driver/repositories/authentication_repo.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ForgotUserPasswordEvent>(forgorPassword);
  }

  FutureOr<void> forgorPassword(
      ForgotUserPasswordEvent event, Emitter<ForgotPasswordState> emit) async {
    emit(ForgotUserPasswordLoadingState());
    final either =
        await AuthenticationRepo().forgorPassword({'email': event.email});
    either.fold(
        (error) => emit(ForgotUserPasswordFailedState(message: error.message)),
        (response) {
      emit(ForgotUserPasswordSuccessState(message: response['message']));
    });
  }
}
