part of 'application_information_cubit.dart';

abstract class ApplicationInformationState extends Equatable {
  final Object? property;
  const ApplicationInformationState({this.property});

  @override
  List<Object> get props => [property ?? []];
}

class ApplicationInformationInitial extends ApplicationInformationState {}

class ApplicationInformationFail extends ApplicationInformationState {
  final APIFailure failure;

  const ApplicationInformationFail(this.failure) : super(property: failure);
}

class ApplicationInformationSuccess extends ApplicationInformationState {
  final ApplicationInformation information;

  const ApplicationInformationSuccess(this.information)
      : super(property: information);
}
