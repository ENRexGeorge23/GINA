part of 'doctor_e_consult_bloc.dart';

abstract class DoctorEConsultState extends Equatable {
  const DoctorEConsultState();

  @override
  List<Object> get props => [];
}

abstract class DoctorEConsultActionState extends DoctorEConsultState {}

class DoctorEConsultInitial extends DoctorEConsultState {}

class DoctorEConsultLoadingState extends DoctorEConsultActionState {}

class DoctorEConsultLoadedState extends DoctorEConsultActionState {
  final AppointmentModel upcomingAppointment;
  final List<ChatMessageModel> chatRooms;

  DoctorEConsultLoadedState(
      {required this.upcomingAppointment, required this.chatRooms});

  @override
  List<Object> get props => [upcomingAppointment, chatRooms];
}

class DoctorEConsultErrorState extends DoctorEConsultActionState {
  final String message;

  DoctorEConsultErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
