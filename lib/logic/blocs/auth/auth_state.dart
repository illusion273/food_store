part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final Auth auth;
  const Authenticated({required this.auth});

  @override
  List<Object> get props => [auth];
}

class Unauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String error;

  const AuthError(this.error);

  @override
  List<Object> get props => [error];
}
