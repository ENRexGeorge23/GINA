import 'package:equatable/equatable.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/view_states/approvedState/screens/approved_request_state_screen.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/view_states/cancelledState/screens/cancelled_request_state_screen.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/view_states/declinedState/screens/declined_request_state_screen.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/view_states/pendingState/screens/pending_request_state_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
part 'doctor_appointment_request_screen_loaded_event.dart';
part 'doctor_appointment_request_screen_loaded_state.dart';



class DoctorAppointmentRequestScreenLoadedBloc extends Bloc<
    DoctorAppointmentRequestScreenLoadedEvent,
    DoctorAppointmentRequestScreenLoadedState> {
  DoctorAppointmentRequestScreenLoadedBloc()
      : super(const DoctorAppointmentRequestScreenLoadedInitial(
            currentIndex: 0,
            selectedScreen: PendingRequestStateScreenProvider(),
            backgroundColor: GinaAppTheme.pendingTextColor)) {
    on<DoctorAppointmentRequestScreenLoadedEvent>((event, emit) {
      if (event is TabChangedEvent) {
        switch (event.tab) {
          case 0:
            emit(DoctorAppointmentRequestScreenLoadedInitial(
                currentIndex: event.tab,
                backgroundColor: GinaAppTheme.pendingTextColor,
                selectedScreen: const PendingRequestStateScreenProvider()));
            break;
          case 1:
            emit(DoctorAppointmentRequestScreenLoadedInitial(
                currentIndex: event.tab,
                backgroundColor: GinaAppTheme.approvedTextColor,
                selectedScreen: const ApprovedRequestStateScreenProvider()));
          case 2:
            emit(DoctorAppointmentRequestScreenLoadedInitial(
                currentIndex: event.tab,
                backgroundColor: GinaAppTheme.declinedTextColor,
                selectedScreen: const DeclinedRequestStateScreenProvider()));
          case 3:
            emit(DoctorAppointmentRequestScreenLoadedInitial(
                currentIndex: event.tab,
                backgroundColor: GinaAppTheme.cancelledTextColor,
                selectedScreen: const CancelledRequestStateScreenProvider()));
        }
      }
    });
  }
}
