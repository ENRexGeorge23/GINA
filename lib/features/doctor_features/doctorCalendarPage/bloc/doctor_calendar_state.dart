part of 'doctor_calendar_bloc.dart';

sealed class DoctorCalendarState extends Equatable {
  const DoctorCalendarState();

  @override
  List<Object> get props => [];
}

abstract class DoctorCalendarActionState extends DoctorCalendarState {}

class DoctorCalendarInitial extends DoctorCalendarState {}
