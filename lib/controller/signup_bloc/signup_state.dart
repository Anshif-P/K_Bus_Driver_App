part of 'signup_bloc.dart';

abstract class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupSuccessState extends SignupState {}

final class SignupFailedState extends SignupState {
  final String message;
  SignupFailedState({required this.message});
}

final class SignupLoadingState extends SignupState {}
