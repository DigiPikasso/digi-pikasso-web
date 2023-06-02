part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  final Object? property;
  const AuthState({this.property});

  @override
  List<Object> get props => [property ?? []];
}

class AuthInitial extends AuthState {}

class AuthLoginInitiate extends AuthState {}

class AuthLoginInProgress extends AuthState {}

class AuthLoginFailed extends AuthState {
  final String message;

  const AuthLoginFailed(this.message) : super(property: message);
}

class AuthLoginSuccess extends AuthState {
  final String code;

  const AuthLoginSuccess({required this.code}) : super(property: code);
}

class AuthenticationSuccess extends AuthState {
  final String redirectUrl;

  const AuthenticationSuccess({required this.redirectUrl})
      : super(property: redirectUrl);
}
