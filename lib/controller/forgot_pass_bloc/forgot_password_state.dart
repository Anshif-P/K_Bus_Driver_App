part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState {}

final class ForgotPasswordInitial extends ForgotPasswordState {}

final class ForgotUserPasswordSuccessState extends ForgotPasswordState {
  final String message;

  ForgotUserPasswordSuccessState({required this.message});
}

final class ForgotUserPasswordFailedState extends ForgotPasswordState {
  final String message;

  ForgotUserPasswordFailedState({required this.message});
}

final class ForgotUserPasswordLoadingState extends ForgotPasswordState {}
