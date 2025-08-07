part of 'doctor_schedule_bloc.dart';

sealed class DoctorScheduleEvent extends Equatable {
  const DoctorScheduleEvent();

  @override
  List<Object> get props => [];
}

class DoctorScheduleInitialEvent extends DoctorScheduleEvent {}
