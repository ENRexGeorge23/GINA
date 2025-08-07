import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:first_app/features/auth/0_model/user_model.dart';
import 'package:first_app/features/doctor_features/doctorConsultation/2_views/bloc/doctor_consultation_bloc.dart';
import 'package:first_app/features/doctor_features/doctorEConsult/2_views/bloc/doctor_e_consult_bloc.dart';
import 'package:first_app/features/doctor_features/doctorUpcomingAppointments/1_controllers/doctor_upcoming_appointments_controller.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'doctor_upcoming_appointments_event.dart';
part 'doctor_upcoming_appointments_state.dart';

UserModel? patientDataFromDoctorUpcomingAppointmentsBloc;
AppointmentModel? appointmentDataFromDoctorUpcomingAppointmentsBloc;

class DoctorUpcomingAppointmentsBloc extends Bloc<
    DoctorUpcomingAppointmentsEvent, DoctorUpcomingAppointmentsState> {
  final DoctorUpcomingAppointmentControllers
      doctorUpcomingAppointmentControllers;
  DoctorUpcomingAppointmentsBloc({
    required this.doctorUpcomingAppointmentControllers,
  }) : super(DoctorUpcomingAppointmentsInitial()) {
    on<GetDoctorUpcomingAppointmentsEvent>(
        _onGetDoctorUpcomingAppointmentsEvent);
    on<UpcomingAppointmentsFilterEvent>(_onUpcomingAppointmentsFilterEvent);
    on<PastAppointmentsFilterEvent>(_onPastAppointmentsFilterEvent);
    on<NavigateToApprovedRequestDetailEvent>(
        _onNavigateToApprovedRequestDetailEvent);
    on<NavigateToCompletedRequestDetailEvent>(
        _onNavigateToCompletedRequestDetailEvent);
  }

  FutureOr<void> _onGetDoctorUpcomingAppointmentsEvent(
      GetDoctorUpcomingAppointmentsEvent event,
      Emitter<DoctorUpcomingAppointmentsState> emit) {}

  FutureOr<void> _onUpcomingAppointmentsFilterEvent(
      UpcomingAppointmentsFilterEvent event,
      Emitter<DoctorUpcomingAppointmentsState> emit) async {
    emit(UpcomingEventsState());
    emit(DoctorUpcomingAppointmentsLoading());

    final upcomingAppointments = await doctorUpcomingAppointmentControllers
        .getConfirmedDoctorAppointmentRequest();

    upcomingAppointments.fold(
        (error) =>
            emit(DoctorUpcomingAppointmentsError(message: error.toString())),
        (appointments) {
      emit(DoctorUpcomingAppointmentsLoaded(appointments: appointments));
    });
  }

  FutureOr<void> _onPastAppointmentsFilterEvent(
      PastAppointmentsFilterEvent event,
      Emitter<DoctorUpcomingAppointmentsState> emit) async {
    emit(PastEventsState());
    emit(DoctorPastAppointmentsLoading());

    final pastAppointments = await doctorUpcomingAppointmentControllers
        .getCompletedDoctorAppointmentRequest();

    pastAppointments.fold(
        (error) =>
            emit(DoctorUpcomingAppointmentsError(message: error.toString())),
        (appointments) {
      emit(DoctorPastAppointmentsLoaded(appointments: appointments));
    });
  }

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  FutureOr<void> _onNavigateToApprovedRequestDetailEvent(
      NavigateToApprovedRequestDetailEvent event,
      Emitter<DoctorUpcomingAppointmentsState> emit) async {
    final patientData = await doctorUpcomingAppointmentControllers
        .getPatientData(patientUid: event.appointment.patientUid!);
    isFromChatRoomLists = false;

    selectedPatientUid = event.appointment.patientUid!;
    selectedPatientName = event.appointment.patientName!;
    selectedPatientAppointment = event.appointment.appointmentUid!;

    patientData.fold((failure) {
      emit(DoctorUpcomingAppointmentsError(message: failure.toString()));
    }, (patientData) {
      patientDataFromDoctorUpcomingAppointmentsBloc = patientData;
      appointmentDataFromDoctorUpcomingAppointmentsBloc = event.appointment;
      emit(NavigateToApprovedRequestDetailState(
          appointment: event.appointment, patientData: patientData));
    });
  }

  FutureOr<void> _onNavigateToCompletedRequestDetailEvent(
      NavigateToCompletedRequestDetailEvent event,
      Emitter<DoctorUpcomingAppointmentsState> emit) async {
    final patientData = await doctorUpcomingAppointmentControllers
        .getPatientData(patientUid: event.appointment.patientUid!);

    selectedPatientUid = event.appointment.patientUid!;
    selectedPatientName = event.appointment.patientName!;
    selectedPatientAppointment = event.appointment.appointmentUid!;

    patientData.fold((failure) {
      emit(DoctorUpcomingAppointmentsError(message: failure.toString()));
    }, (patientData) {
      patientDataFromDoctorUpcomingAppointmentsBloc = patientData;
      appointmentDataFromDoctorUpcomingAppointmentsBloc = event.appointment;
      emit(NavigateToCompletedRequestDetailState(
          appointment: event.appointment, patientData: patientData));
    });
  }
}
