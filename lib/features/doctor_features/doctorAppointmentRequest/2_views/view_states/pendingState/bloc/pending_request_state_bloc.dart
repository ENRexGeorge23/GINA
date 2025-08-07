import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:first_app/features/auth/0_model/user_model.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/0_controllers/doctor_appointment_request_controller.dart';
import 'package:first_app/features/doctor_features/doctorConsultation/2_views/bloc/doctor_consultation_bloc.dart';
import 'package:first_app/features/doctor_features/doctorEConsult/2_views/bloc/doctor_e_consult_bloc.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pending_request_state_event.dart';
part 'pending_request_state_state.dart';

UserModel? storedPatientData;
AppointmentModel? storedAppointment;
bool isFromPendingRequest = false;

class PendingRequestStateBloc
    extends Bloc<PendingRequestStateEvent, PendingRequestStateState> {
  final DoctorAppointmentRequestController doctorAppointmentRequestController;

  PendingRequestStateBloc({required this.doctorAppointmentRequestController})
      : super(PendingRequestStateInitial()) {
    on<PendingRequestStateInitialEvent>(fetchedPendingAppointmentRequest);
    on<NavigateToPendingRequestDetailEvent>(navigateToPendingRequestDetail);
    on<ApproveAppointmentEvent>(approveAppointment);
    on<DeclineAppointmentEvent>(declineAppointment);
  }

  FutureOr<void> fetchedPendingAppointmentRequest(
      PendingRequestStateInitialEvent event,
      Emitter<PendingRequestStateState> emit) async {
    emit(PendingRequestLoadingState());

    final result = await doctorAppointmentRequestController
        .getPendingDoctorAppointmentRequest();
    result.fold((failure) {
      emit(GetPendingRequestFailedState(message: failure.toString()));
    }, (pendingRequests) {
      emit(GetPendingRequestSuccessState(pendingRequests: pendingRequests));
    });
  }

  FutureOr<void> navigateToPendingRequestDetail(
      NavigateToPendingRequestDetailEvent event,
      Emitter<PendingRequestStateState> emit) async {
    final patientData = await doctorAppointmentRequestController.getPatientData(
        patientUid: event.appointment.patientUid!);

    patientData.fold((failure) {
      emit(GetPendingRequestFailedState(message: failure.toString()));
    }, (patientData) {
      storedAppointment = event.appointment;
      storedPatientData = patientData;
      emit(NavigateToPendingRequestDetailState(
          appointment: event.appointment, patientDate: patientData));
    });
  }

  FutureOr<void> approveAppointment(ApproveAppointmentEvent event,
      Emitter<PendingRequestStateState> emit) async {
    emit(ApproveAppointmentLoadingState());

    final result = await doctorAppointmentRequestController
        .approvePendingPatientRequest(appointmentId: event.appointmentId);

    selectedPatientUid = storedPatientData!.uid;
    selectedPatientAppointment = storedAppointment!.appointmentUid;
    selectedPatientName = storedPatientData!.name;
    result.fold((failure) {
      emit(ApproveAppointmentFailedState(message: failure.toString()));
    }, (success) {
      emit(NavigateToApprovedRequestDetailState(
          appointment: storedAppointment!, patientDate: storedPatientData!));
    });
  }

  FutureOr<void> declineAppointment(DeclineAppointmentEvent event,
      Emitter<PendingRequestStateState> emit) async {
    emit(DeclineAppointmentLoadingState());

    final result = await doctorAppointmentRequestController
        .declinePendingPatientRequest(appointmentId: event.appointmentId);

    result.fold((failure) {
      emit(DeclineAppointmentFailedState(message: failure.toString()));
    }, (success) {
      emit(NavigateToDeclinedRequestDetailState(
          appointment: storedAppointment!));
    });
  }
}
