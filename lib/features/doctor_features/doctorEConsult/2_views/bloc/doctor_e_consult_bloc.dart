import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/0_controllers/doctor_appointment_request_controller.dart';
import 'package:first_app/features/doctor_features/doctorConsultation/2_views/bloc/doctor_consultation_bloc.dart';
import 'package:first_app/features/doctor_features/doctorEConsult/1_controllers/doctor_e_consult_controller.dart';
import 'package:first_app/features/doctor_features/doctorUpcomingAppointments/2_views/bloc/doctor_upcoming_appointments_bloc.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:first_app/features/patient_features/consultation/0_model/chat_message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'doctor_e_consult_event.dart';
part 'doctor_e_consult_state.dart';

String? selectedPatientAppointment;
bool isFromChatRoomLists = false;

class DoctorEConsultBloc
    extends Bloc<DoctorEConsultEvent, DoctorEConsultState> {
  final DoctorEConsultController doctorEConsultController;
  final DoctorAppointmentRequestController doctorAppointmentRequestController;
  DoctorEConsultBloc({
    required this.doctorEConsultController,
    required this.doctorAppointmentRequestController,
  }) : super(DoctorEConsultInitial()) {
    on<GetRequestedEConsultsDiplayEvent>(onGetRequestedEConsultsDiplayEvent);
    on<GetPatientDataEvent>(_getPatientDataEvent);
  }

  FutureOr<void> onGetRequestedEConsultsDiplayEvent(
      GetRequestedEConsultsDiplayEvent event,
      Emitter<DoctorEConsultState> emit) async {
    emit(DoctorEConsultLoadingState());

    final upcomingAppointment =
        await doctorEConsultController.getUpcomingDoctorAppointments();

    final doctorChatRooms =
        await doctorEConsultController.getDoctorChatroomsAndMessages();

    upcomingAppointment.fold(
      (failure) {
        emit(DoctorEConsultErrorState(message: failure.toString()));
      },
      (appointment) {
        selectedPatientAppointment = appointment.appointmentUid;
        selectedPatientUid = appointment.patientUid ?? '';
        selectedPatientName = appointment.patientName ?? '';

        if (doctorChatRooms.isRight()) {
          emit(DoctorEConsultLoadedState(
              upcomingAppointment: appointment,
              chatRooms: doctorChatRooms.getOrElse(() => [])));
        } else {
          emit(DoctorEConsultErrorState(message: 'Error getting chatrooms'));
        }
      },
    );
  }

  FutureOr<void> _getPatientDataEvent(
      GetPatientDataEvent event, Emitter<DoctorEConsultState> emit) async {
    final patientData = await doctorAppointmentRequestController.getPatientData(
        patientUid: event.patientUid);

    final appointmentData = await doctorAppointmentRequestController
        .getDoctorPatients(patientUid: event.patientUid);

    appointmentData.fold((failure) {}, (appointmentData) {
      appointmentDataFromDoctorUpcomingAppointmentsBloc =
          appointmentData.patientAppointments.first;

      selectedPatientAppointment = appointmentData.patientAppointments
          .where((element) => element.modeOfAppointment == 0)
          .where((element) => element.appointmentStatus == 1)
          .first
          .appointmentUid;
    });

    patientData.fold((failure) {}, (patientData) {
      patientDataFromDoctorUpcomingAppointmentsBloc = patientData;
    });
  }
}
