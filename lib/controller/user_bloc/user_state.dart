part of 'user_bloc.dart';

abstract class UserState {}

final class UserInitial extends UserState {}

class UserTokenFoundState extends UserState {
  String token;
  UserTokenFoundState({required this.token});
}

class UserTokenNotFoundState extends UserState {}
