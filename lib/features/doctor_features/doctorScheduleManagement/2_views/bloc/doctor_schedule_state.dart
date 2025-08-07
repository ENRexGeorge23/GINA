part of 'doctor_schedule_bloc.dart';

sealed class DoctorScheduleState extends Equatable {
  const DoctorScheduleState();

  @override
  List<Object> get props => [];
}

abstract class DoctorScheduleActionState extends DoctorScheduleState {}

class DoctorScheduleInitial extends DoctorScheduleState {}

class GetScheduleLoadingState extends DoctorScheduleState {}

class GetScheduleSuccessState extends DoctorScheduleState {
  final ScheduleModel schedule;

  const GetScheduleSuccessState({required this.schedule});

  @override
  List<Object> get props => [schedule];
}

class GetScheduleFailedState extends DoctorScheduleState {
  final String message;

  const GetScheduleFailedState({required this.message});

  @override
  List<Object> get props => [message];
}
