part of 'create_doctor_schedule_bloc.dart';

sealed class CreateDoctorScheduleState extends Equatable {
  const CreateDoctorScheduleState();

  @override
  List<Object> get props => [];
}

abstract class CreateDoctorScheduleActionState
    extends CreateDoctorScheduleState {}

class CreateDoctorScheduleInitial extends CreateDoctorScheduleState {}

class CreateDoctorScheduleLoadingState extends CreateDoctorScheduleState {}

class CreateDoctorScheduleSuccessState extends CreateDoctorScheduleState {}

class CreateDoctorScheduleFailureState extends CreateDoctorScheduleState {
  final String message;

  const CreateDoctorScheduleFailureState(this.message);

  @override
  List<Object> get props => [message];
}
