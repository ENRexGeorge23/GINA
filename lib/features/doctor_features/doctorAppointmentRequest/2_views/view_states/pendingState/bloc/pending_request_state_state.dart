part of 'pending_request_state_bloc.dart';

abstract class PendingRequestStateState extends Equatable {
  const PendingRequestStateState();

  @override
  List<Object> get props => [];
}

abstract class PendingRequestActionState extends PendingRequestStateState {
  const PendingRequestActionState();
}

class PendingRequestStateInitial extends PendingRequestStateState {}

class PendingRequestLoadingState extends PendingRequestStateState {}

class GetPendingRequestSuccessState extends PendingRequestStateState {
  final Map<DateTime, List<AppointmentModel>> pendingRequests;

  const GetPendingRequestSuccessState({required this.pendingRequests});

  @override
  List<Object> get props => [pendingRequests];
}

class GetPendingRequestFailedState extends PendingRequestStateState {
  final String message;

  const GetPendingRequestFailedState({required this.message});

  @override
  List<Object> get props => [message];
}

class NavigateToApprovedRequestDetailState extends PendingRequestActionState {
  final AppointmentModel appointment;
  final UserModel patientDate;

  const NavigateToApprovedRequestDetailState(
      {required this.appointment, required this.patientDate});

  @override
  List<Object> get props => [appointment, patientDate];
}

class NavigateToPendingRequestDetailState extends PendingRequestActionState {
  final AppointmentModel appointment;
  final UserModel patientDate;

  const NavigateToPendingRequestDetailState(
      {required this.appointment, required this.patientDate});

  @override
  List<Object> get props => [appointment, patientDate];
}

class NavigateToDeclinedRequestDetailState extends PendingRequestActionState {
  final AppointmentModel appointment;


  const NavigateToDeclinedRequestDetailState(
      {required this.appointment});

  @override
  List<Object> get props => [appointment];
}

class ApproveAppointmentSuccessState extends PendingRequestActionState {}

class ApproveAppointmentFailedState extends PendingRequestActionState {
  final String message;

  const ApproveAppointmentFailedState({required this.message});

  @override
  List<Object> get props => [message];
}

class ApproveAppointmentLoadingState extends PendingRequestActionState {}


class DeclineAppointmentSuccessState extends PendingRequestActionState {}

class DeclineAppointmentFailedState extends PendingRequestActionState {
  final String message;

  const DeclineAppointmentFailedState({required this.message});

  @override
  List<Object> get props => [message];
}

class DeclineAppointmentLoadingState extends PendingRequestActionState {}