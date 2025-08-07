import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:first_app/features/auth/0_model/user_model.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/0_controllers/doctor_appointment_request_controller.dart';
import 'package:first_app/features/doctor_features/doctorConsultation/1_controllers/doctor_chat_message_controller.dart';
import 'package:first_app/features/doctor_features/doctorEConsult/2_views/bloc/doctor_e_consult_bloc.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:first_app/features/patient_features/consultation/1_controllers/appointment_chat_controller.dart';
import 'package:first_app/features/patient_features/consultation/2_views/bloc/consultation_bloc.dart';
import 'package:first_app/features/patient_features/periodTracker/0_models/period_tracker_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'doctor_consultation_event.dart';
part 'doctor_consultation_state.dart';

String? doctorChatRoom;
String? selectedPatientUid;
String? selectedPatientName;

class DoctorConsultationBloc
    extends Bloc<DoctorConsultationEvent, DoctorConsultationState> {
  final DoctorChatMessageController doctorChatMessageController;
  final AppointmentChatController appointmentChatController;
  final DoctorAppointmentRequestController doctorAppointmentRequestController;
  DoctorConsultationBloc(
      {required this.doctorChatMessageController,
      required this.appointmentChatController,
      required this.doctorAppointmentRequestController})
      : super(DoctorConsultationInitial()) {
    on<DoctorConsultationGetRequestedAppointmentEvent>(
        _getRequestedAppointmentEvent);
    on<DoctorConsultationSendChatMessageEvent>(_sendChatMessageEvent);
    on<DoctorConsultationSendFirstMessageEvent>(_sendFirstMessageEvent);
    on<CompleteDoctorConsultationButtonEvent>(_completeDoctorConsultation);
    on<NavigateToPatientDateEvent>(_navigateToPatientDateEvent);
  }

  FutureOr<void> _getRequestedAppointmentEvent(
      DoctorConsultationGetRequestedAppointmentEvent event,
      Emitter<DoctorConsultationState> emit) async {
    // emit(DoctorConsultationLoadingState());

    if (isFromChatRoomLists) {
      final chatRoomId = await doctorChatMessageController.initChatRoom(
        doctorChatMessageController.generateRoomId(event.recipientUid),
        event.recipientUid,
      );

      doctorChatRoom = chatRoomId;

      emit(DoctorConsultationLoadedAppointmentState(
          chatRoomId: chatRoomId!, recipientUid: event.recipientUid));
    } else {
      final checkAppointmentForOnlineConsultation =
          await appointmentChatController.chatStatusDecider(
        appointmentId: selectedPatientAppointment!,
      );
      if (checkAppointmentForOnlineConsultation == 'canChat') {
        isAppointmentFinished = false;
        isChatWaiting = false;
        final chatRoomId = await doctorChatMessageController.initChatRoom(
          doctorChatMessageController.generateRoomId(event.recipientUid),
          event.recipientUid,
        );

        chatRoom = chatRoomId;
        emit(DoctorConsultationLoadedAppointmentState(
            chatRoomId: chatRoomId!, recipientUid: event.recipientUid));
      } else if (checkAppointmentForOnlineConsultation ==
          'appointmentIsNotStartedYet') {
        emit(DoctorConsultationWaitingAppointmentState());
      } else if (checkAppointmentForOnlineConsultation ==
          'waitingForTheAppointment') {
        isChatWaiting = true;
        isAppointmentFinished = false;
        final chatRoomId = await doctorChatMessageController.initChatRoom(
          doctorChatMessageController.generateRoomId(event.recipientUid),
          event.recipientUid,
        );

        chatRoom = chatRoomId;
        emit(DoctorConsultationLoadedAppointmentState(
            chatRoomId: chatRoomId!, recipientUid: event.recipientUid));
      } else if (checkAppointmentForOnlineConsultation == 'chatIsFinished') {
        isAppointmentFinished = true;
        isChatWaiting = false;

        final chatRoomId = await doctorChatMessageController.initChatRoom(
          doctorChatMessageController.generateRoomId(event.recipientUid),
          event.recipientUid,
        );

        chatRoom = chatRoomId;
        emit(DoctorConsultationLoadedAppointmentState(
            chatRoomId: chatRoomId!, recipientUid: event.recipientUid));
      } else if (checkAppointmentForOnlineConsultation == 'invalid') {
        isAppointmentFinished = false;
        isChatWaiting = false;
        emit(DoctorConsultationNoAppointmentState());
      }
    }
  }

  FutureOr<void> _sendChatMessageEvent(
      DoctorConsultationSendChatMessageEvent event,
      Emitter<DoctorConsultationState> emit) async {
    await doctorChatMessageController.sendMessage(
      message: event.message,
      recipient: event.recipient,
    );
  }

  FutureOr<void> _sendFirstMessageEvent(
      DoctorConsultationSendFirstMessageEvent event,
      Emitter<DoctorConsultationState> emit) async {
    await doctorChatMessageController.sendFirstMessage(
      message: event.message,
      recipient: event.recipient,
    );
  }

  FutureOr<void> _completeDoctorConsultation(
      CompleteDoctorConsultationButtonEvent event,
      Emitter<DoctorConsultationState> emit) async {
    final result = await doctorAppointmentRequestController
        .completePatientAppointment(appointmentId: event.appointmentId);

    result.fold((error) {
      emit(DoctorConsultationErrorAppointmentState(message: error.toString()));
    }, (success) {
      emit(DoctorConsultationCompletedAppointmentState());
    });
  }

  FutureOr<void> _navigateToPatientDateEvent(NavigateToPatientDateEvent event,
      Emitter<DoctorConsultationState> emit) async {
    final patientData = await doctorAppointmentRequestController
        .getDoctorPatients(patientUid: event.appointment.patientUid!);

    patientData.fold((failure) {
      emit(
          DoctorConsultationErrorAppointmentState(message: failure.toString()));
    }, (patientData) {
      emit(NavigateToPatientDataState(
          patientData: event.patientData,
          appointment: event.appointment,
          patientPeriods: patientData.patientPeriods,
          patientAppointments: patientData.patientAppointments));
    });
  }
}
