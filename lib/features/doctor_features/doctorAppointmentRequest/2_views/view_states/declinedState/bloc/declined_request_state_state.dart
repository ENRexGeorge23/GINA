part of 'declined_request_state_bloc.dart';

abstract class DeclinedRequestStateState extends Equatable {
  const DeclinedRequestStateState();

  @override
  List<Object> get props => [];
}

abstract class DeclinedRequestActionState extends DeclinedRequestStateState {
  const DeclinedRequestActionState();
}

class DeclinedRequestStateInitial extends DeclinedRequestStateState {}

class DeclinedRequestLoadingState extends DeclinedRequestStateState {}

class GetDeclinedRequestSuccessState extends DeclinedRequestStateState {
  final Map<DateTime, List<AppointmentModel>> declinedRequests;

  const GetDeclinedRequestSuccessState({required this.declinedRequests});

  @override
  List<Object> get props => [declinedRequests];
}

class GetDeclinedRequestFailedState extends DeclinedRequestStateState {
  final String message;

  const GetDeclinedRequestFailedState({required this.message});

  @override
  List<Object> get props => [message];
}

class NavigateToDeclinedRequestDetailState extends DeclinedRequestActionState {
  final AppointmentModel appointment;

  const NavigateToDeclinedRequestDetailState({required this.appointment});

  @override
  List<Object> get props => [appointment];
}
