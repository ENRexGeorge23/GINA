import 'package:equatable/equatable.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/screens/doctor_appointment_request_screen.dart';
import 'package:first_app/features/doctor_features/doctorEConsult/2_views/screens/doctor_e_consult_screen.dart';
import 'package:first_app/features/doctor_features/doctorForums/2_views/screens/doctor_forums_screen.dart';
import 'package:first_app/features/doctor_features/doctorProfile/2_views/screens/doctor_profile_screen.dart';
import 'package:first_app/features/doctor_features/homeDashboard/2_views/screens/home_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'doctor_bottom_navigation_event.dart';
part 'doctor_bottom_navigation_state.dart';

class DoctorBottomNavigationBloc
    extends Bloc<DoctorBottomNavigationEvent, DoctorBottomNavigationState> {
  DoctorBottomNavigationBloc()
      : super(const DoctorBottomNavigationInitial(
            currentIndex: 0, selectedScreen: HomeScreenDashBoardProvider())) {
    on<DoctorBottomNavigationEvent>((event, emit) {
      if (event is TabChangedEvent) {
        switch (event.tab) {
          case 0:
            emit(DoctorBottomNavigationInitial(
                currentIndex: event.tab,
                selectedScreen: const HomeScreenDashBoardProvider()));
            break;
          case 1:
            emit(DoctorBottomNavigationInitial(
                currentIndex: event.tab,
                selectedScreen: const DoctorAppointmentRequestProvider()));
            break;
          case 2:
            emit(DoctorBottomNavigationInitial(
                currentIndex: event.tab,
                selectedScreen: const DoctorEConsultScreenProvider()));
            break;
          case 3:
            emit(DoctorBottomNavigationInitial(
                currentIndex: event.tab,
                selectedScreen: const DoctorForumsScreenProvider()));
            break;
          case 4:
            emit(DoctorBottomNavigationInitial(
                currentIndex: event.tab,
                selectedScreen: const DoctorProfileScreenProvider()));
            break;
        }
      }
    });
  }
}
