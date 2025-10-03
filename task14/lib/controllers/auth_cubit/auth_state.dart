part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

// Google States
class AuthGoogleLoading extends AuthState {}

class AuthGoogleSuccess extends AuthState {}

class AuthGoogleFailure extends AuthState {
  final String message;

  AuthGoogleFailure(this.message);
}

// Sign Out States
class AuthSignOutLoading extends AuthState {}

class AuthSignOutSuccess extends AuthState {}

class AuthSignOutFailure extends AuthState {
  final String message;

  AuthSignOutFailure(this.message);
}
