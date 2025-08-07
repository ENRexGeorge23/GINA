part of 'appointment_details_bloc.dart';

abstract class AppointmentDetailsState extends Equatable {
  const AppointmentDetailsState();

  @override
  List<Object> get props => [];
}

abstract class AppointmentDetailsActionState extends AppointmentDetailsState {}

class AppointmentDetailsInitial extends AppointmentDetailsState {}

class AppointmentDetailsStatusState extends AppointmentDetailsState {
  final AppointmentModel appointment;

  const AppointmentDetailsStatusState({required this.appointment});

  @override
  List<Object> get props => [appointment];
}

class AppointmentDetailsError extends AppointmentDetailsState {
  final String message;

  const AppointmentDetailsError({required this.message});

  @override
  List<Object> get props => [message];
}

class AppointmentDetailsLoading extends AppointmentDetailsState {}

class CancelAppointmentState extends AppointmentDetailsActionState {}

class CancelAppointmentError extends AppointmentDetailsActionState {
  final String message;

  CancelAppointmentError({required this.message});

  @override
  List<Object> get props => [message];
}

class CancelAppointmentLoading extends AppointmentDetailsActionState {}

class RescheduleAppointmentState extends AppointmentDetailsState {}

class RescheduleAppointmentError extends AppointmentDetailsActionState {
  final String message;

  RescheduleAppointmentError({required this.message});

  @override
  List<Object> get props => [message];
}

class RescheduleAppointmentLoading extends AppointmentDetailsActionState {}
