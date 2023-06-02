import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final Object properties;

  const Failure(this.properties);

  @override
  List<Object> get props => [properties];
}


class APIFailure extends Failure {
  final String message;
  APIFailure(this.message) : super(message);
}