part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent {}

final class ForgotUserPasswordEvent extends ForgotPasswordEvent {
  final String email;

  ForgotUserPasswordEvent({required this.email});
}
