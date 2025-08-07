import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:first_app/features/auth/0_model/user_model.dart';
import 'package:first_app/features/doctor_features/doctorViewPatients/1_controllers/doctor_view_patients_controller.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:first_app/features/patient_features/periodTracker/0_models/period_tracker_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'doctor_view_patients_event.dart';
part 'doctor_view_patients_state.dart';

UserModel? patient;
List<PeriodTrackerModel>? patientPeriods;
List<AppointmentModel>? patientAppointments;

class DoctorViewPatientsBloc
    extends Bloc<DoctorViewPatientsEvent, DoctorViewPatientsState> {
  final DoctorViewPatientsController doctorViewPatientsController;
  DoctorViewPatientsBloc({required this.doctorViewPatientsController})
      : super(DoctorViewPatientsStateInitial()) {
    on<DoctorViewPatientsInitialEvent>(getPatientsList);
    on<FindNavigateToPatientDetailsEvent>(findNavigateToPatientDetailsEvent);
  }

  FutureOr<void> getPatientsList(DoctorViewPatientsInitialEvent event,
      Emitter<DoctorViewPatientsState> emit) async {
    emit(GetDoctorViewPatientsLoadingState());

    List<UserModel>? listOfPatients;
    List<AppointmentModel>? listOfPatientAppointment;

    final getListofAppointments =
        await doctorViewPatientsController.getListOfPatientsAppointment();

    getListofAppointments.fold((failure) {
      emit(GetPatientListFailedState(message: failure.toString()));
    }, (appointments) {
      listOfPatientAppointment = appointments;
    });

    final getListOfPatientsResult =
        await doctorViewPatientsController.getListOfPatients();

    getListOfPatientsResult.fold((failure) {
      emit(GetPatientListFailedState(message: failure.toString()));
    }, (patients) {
      listOfPatients = patients;

      emit(GetPatientListSuccessState(
          patientsAppointmentperiod: listOfPatients!,
          patientAppointmentList: listOfPatientAppointment!));
    });
  }

  FutureOr<void> findNavigateToPatientDetailsEvent(
      FindNavigateToPatientDetailsEvent event,
      Emitter<DoctorViewPatientsState> emit) async {
    final result = await doctorViewPatientsController.getDoctorPatients(
      patientUid: event.patient.uid,
    );

    result.fold((failure) {
      emit(GetPatientListFailedState(message: failure.toString()));
    }, (patientData) {
      patient = event.patient;
      patientAppointments = patientData.patientAppointments;
      patientPeriods = patientData.patientPeriods;

      emit(FindNavigateToPatientDetailsState(
        patient: event.patient,
        patientAppointments: patientAppointments!,
        patientPeriods: patientPeriods!,
      ));
    });
  }
}
