import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:first_app/features/doctor_features/doctorEmergencyAnnouncements/0_model/emergency_announcements_model.dart';
import 'package:first_app/features/doctor_features/doctorEmergencyAnnouncements/1_controller/doctor_emergency_announcements_controller.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'doctor_emergency_announcements_event.dart';
part 'doctor_emergency_announcements_state.dart';

class DoctorEmergencyAnnouncementsBloc extends Bloc<
    DoctorEmergencyAnnouncementsEvent, DoctorEmergencyAnnouncementsState> {
  final DoctorEmergencyAnnouncementsController
      doctorEmergencyAnnouncementsController;

  DoctorEmergencyAnnouncementsBloc(
      {required this.doctorEmergencyAnnouncementsController})
      : super(DoctorEmergencyAnnouncementsInitial()) {
    on<GetDoctorEmergencyAnnouncementsEvent>(
        _onGetDoctorEmergencyAnnouncementsEvent);
    on<NavigateToDoctorEmergencyCreateAnnouncementEvent>(
        _onNavigateToDoctorEmergencyCreateAnnouncementEvent);
    on<NavigateToPatientListEvent>(_onNavigateToPatientListEvent);
    on<SelectPatientEvent>(_onSelectPatientEvent);
    on<CreateEmergencyAnnouncementEvent>(_onCreateEmergencyAnnouncementEvent);
    on<NavigateToDoctorCreatedAnnouncementEvent>(
        _onNavigateToDoctorCreatedAnnouncementEvent);
  }

  FutureOr<void> _onGetDoctorEmergencyAnnouncementsEvent(
      GetDoctorEmergencyAnnouncementsEvent event,
      Emitter<DoctorEmergencyAnnouncementsState> emit) async {
    emit(DoctorEmergencyAnnouncementsLoading());

    final emergencyAnnouncements = await doctorEmergencyAnnouncementsController
        .getEmergencyAnnouncements();

    emergencyAnnouncements.fold(
      (failure) {
        emit(DoctorEmergencyAnnouncementsError(message: failure.toString()));
      },
      (emergencyAnnouncements) {
        emit(DoctorEmergencyAnnouncementsLoaded(
            emergencyAnnouncements: emergencyAnnouncements));
      },
    );
  }

  FutureOr<void> _onNavigateToDoctorEmergencyCreateAnnouncementEvent(
      NavigateToDoctorEmergencyCreateAnnouncementEvent event,
      Emitter<DoctorEmergencyAnnouncementsState> emit) {
    emit(CreateAnnouncementState());
  }

  FutureOr<void> _onNavigateToPatientListEvent(NavigateToPatientListEvent event,
      Emitter<DoctorEmergencyAnnouncementsState> emit) async {
    emit(DoctorEmergencyAnnouncementsLoading());

    final patientList = await doctorEmergencyAnnouncementsController
        .getConfirmedDoctorAppointmentRequest();

    patientList.fold(
      (failure) {
        emit(DoctorEmergencyAnnouncementsError(message: failure.toString()));
      },
      (approvedPatientList) {
        emit(DoctorEmergencyGetApprovedPatientList(
            approvedPatientList: approvedPatientList));
      },
    );
  }

  FutureOr<void> _onSelectPatientEvent(SelectPatientEvent event,
      Emitter<DoctorEmergencyAnnouncementsState> emit) async {
    emit(SelectedAPatientState(appointment: event.appointment));
  }

  FutureOr<void> _onCreateEmergencyAnnouncementEvent(
      CreateEmergencyAnnouncementEvent event,
      Emitter<DoctorEmergencyAnnouncementsState> emit) async {
    final createEmergencyAnnouncement =
        await doctorEmergencyAnnouncementsController
            .createEmergencyAnnouncement(
      patientUid: event.appointment.patientUid!,
      emergencyMessage: event.message,
      patientName: event.appointment.patientName!,
      appointmentUid: event.appointment.appointmentUid!,
    );

    createEmergencyAnnouncement.fold(
      (failure) {
        emit(DoctorEmergencyAnnouncementsError(message: failure.toString()));
      },
      (success) {
        emit(CreateEmergencyAnnouncementPostSuccessState());
      },
    );
  }

  FutureOr<void> _onNavigateToDoctorCreatedAnnouncementEvent(
      NavigateToDoctorCreatedAnnouncementEvent event,
      Emitter<DoctorEmergencyAnnouncementsState> emit) {
    emit(NavigateToDoctorCreatedAnnouncementState(
        emergencyAnnouncement: event.emergencyAnnouncement));
  }
}
