part of 'signup_bloc.dart';

abstract class SignupEvent {}

class SignupUserEvent extends SignupEvent {
  final String email;
  final String password;

  SignupUserEvent({
    required this.email,
    required this.password,
  });
}
