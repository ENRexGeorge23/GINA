part of 'cancelled_request_state_bloc.dart';

abstract class CancelledRequestStateState extends Equatable {
  const CancelledRequestStateState();

  @override
  List<Object> get props => [];
}

abstract class CancelledRequestActionState extends CancelledRequestStateState {
  const CancelledRequestActionState();
}

class CancelledRequestStateInitial extends CancelledRequestStateState {}

class CancelledRequestLoadingState extends CancelledRequestStateState {}

class GetCancelledRequestSuccessState extends CancelledRequestStateState {
  final Map<DateTime, List<AppointmentModel>> cancelledRequests;

  const GetCancelledRequestSuccessState({required this.cancelledRequests});

  @override
  List<Object> get props => [cancelledRequests];
}

class GetCancelledRequestFailedState extends CancelledRequestStateState {
  final String message;

  const GetCancelledRequestFailedState({required this.message});

  @override
  List<Object> get props => [message];
}

class NavigateToCancelledRequestDetailState
    extends CancelledRequestActionState {
  final AppointmentModel appointment;

  const NavigateToCancelledRequestDetailState({required this.appointment});

  @override
  List<Object> get props => [appointment];
}
