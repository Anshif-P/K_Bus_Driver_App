import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_bus_driver/network/shared_preferences/shared_pref_model.dart';
import 'package:k_bus_driver/repositories/authentication_repo.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginUserEvent>(loginUserEvent);
  }

  FutureOr<void> loginUserEvent(
      LoginUserEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    final either = await AuthenticationRepo()
        .loginUser({'emailOrPhone': event.email, 'password': event.password});
    either.fold((error) => emit(LoginFailedState(message: error.message)),
        (response) {
      if (response['message'] == 'Login successful') {
        SharedPrefModel.instance.insertData('token', response['token']);
        emit(LoginSuccessState());
      }
    });
  }
}
