import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:first_app/features/doctor_features/doctorProfile/1_controllers/doctor_profile_controller.dart';
import 'package:first_app/features/doctor_features/doctorScheduleManagement/0_models/doctor_schedule_model.dart';
import 'package:first_app/features/doctor_features/doctorScheduleManagement/1_controllers/doctor_schedule_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'doctor_schedule_event.dart';
part 'doctor_schedule_state.dart';

DoctorModel? currentActiveDoctor;

class DoctorScheduleBloc
    extends Bloc<DoctorScheduleEvent, DoctorScheduleState> {
  final DoctorProfileController doctorProfileController;
  final DoctorScheduleController doctorScheduleController;
  DoctorScheduleBloc(
      {required this.doctorScheduleController,
      required this.doctorProfileController})
      : super(DoctorScheduleInitial()) {
    on<DoctorScheduleInitialEvent>(scheduleFetchRequestedEvent);
  }
  FutureOr<void> scheduleFetchRequestedEvent(DoctorScheduleInitialEvent event,
      Emitter<DoctorScheduleState> emit) async {
    emit(GetScheduleLoadingState());

    final doctorDetails = await doctorProfileController.getDoctorProfile();
    doctorDetails.fold((failure) {
      emit(GetScheduleFailedState(message: failure.toString()));
    }, (doctor) {
      currentActiveDoctor = doctor;
    });

    final result = await doctorScheduleController.getDoctorSchedule();

    result.fold((failure) {
      emit(GetScheduleFailedState(message: failure.toString()));
    }, (schedule) {
      emit(GetScheduleSuccessState(schedule: schedule));
    });
  }
}
