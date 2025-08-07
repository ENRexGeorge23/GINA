part of 'approved_request_state_bloc.dart';

sealed class ApprovedRequestStateEvent extends Equatable {
  const ApprovedRequestStateEvent();

  @override
  List<Object> get props => [];
}

class ApprovedRequestStateInitialEvent extends ApprovedRequestStateEvent {}

class NavigateToApprovedRequestDetailEvent extends ApprovedRequestStateEvent {
  final AppointmentModel appointment;

  const NavigateToApprovedRequestDetailEvent({required this.appointment});

  @override
  List<Object> get props => [appointment];
}

class NavigateToPatientDateEvent extends ApprovedRequestStateEvent {
  final UserModel patientData;
  final AppointmentModel appointment;

  const NavigateToPatientDateEvent(
      {required this.patientData, required this.appointment});

  @override
  List<Object> get props => [patientData, appointment];
}
