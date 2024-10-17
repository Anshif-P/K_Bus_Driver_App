part of 'login_bloc.dart';

abstract class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginSuccessState extends LoginState {}

final class LoginFailedState extends LoginState {
  final String message;
  LoginFailedState({required this.message});
}

final class LoginLoadingState extends LoginState {}
