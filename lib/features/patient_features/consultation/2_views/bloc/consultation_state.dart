part of 'consultation_bloc.dart';

abstract class ConsultationState extends Equatable {
  const ConsultationState();

  @override
  List<Object> get props => [];
}

abstract class ConsultationActionState extends Equatable {}

class ConsultationInitial extends ConsultationState {}

class ConsultationLoadingState extends ConsultationState {}

class ConsultationLoadedAppointmentState extends ConsultationState {
  final String chatRoomId;
  final String recipientUid;

  const ConsultationLoadedAppointmentState({
    required this.chatRoomId,
    required this.recipientUid,
  });

  @override
  List<Object> get props => [chatRoomId, recipientUid];
}

class ConsultationNoAppointmentState extends ConsultationState {}

class ConsultationWaitingAppointmentState extends ConsultationState {}

class ConsultationFailedAppointmentState extends ConsultationState {
  final String message;

  const ConsultationFailedAppointmentState({required this.message});

  @override
  List<Object> get props => [message];
}
