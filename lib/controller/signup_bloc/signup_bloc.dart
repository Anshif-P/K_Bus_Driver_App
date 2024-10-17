import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_bus_driver/network/shared_preferences/shared_pref_model.dart';
import 'package:k_bus_driver/repositories/authentication_repo.dart';
part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupUserEvent>(signupUser);
  }

  FutureOr<void> signupUser(
      SignupUserEvent event, Emitter<SignupState> emit) async {
    print('hello-----------------');
    emit(SignupLoadingState());
    final either = await AuthenticationRepo()
        .singUpUser({'emailOrPhone': event.email, 'password': event.password});
    either.fold((error) => emit(SignupFailedState(message: error.message)),
        (response) {
      print('hello-----------------');
      // final Map result = response;
      if (response['message'] == 'Registration successful') {
        SharedPrefModel.instance.insertData('token', response['token']);
        emit(SignupSuccessState());
      }
    });
  }
}
