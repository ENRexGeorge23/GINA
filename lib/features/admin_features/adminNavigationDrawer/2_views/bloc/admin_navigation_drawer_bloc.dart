import 'package:equatable/equatable.dart';
import 'package:first_app/features/admin_features/adminDashboard/2_views/screens/admin_dashboard_screen.dart';
import 'package:first_app/features/admin_features/adminDoctorList/2_views/screens/admin_doctor_list.screen.dart';
import 'package:first_app/features/admin_features/adminDoctorVerification/2_views/screens/admin_doctor_verification_screen.dart';
import 'package:first_app/features/admin_features/adminPatientList/2_views/screens/admin_patient_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_navigation_drawer_event.dart';
part 'admin_navigation_drawer_state.dart';

class AdminNavigationDrawerBloc
    extends Bloc<AdminNavigationDrawerEvent, AdminNavigationDrawerState> {
  AdminNavigationDrawerBloc()
      : super(const AdminNavigationDrawerInitial(
            currentIndex: 0, selectedScreen: AdminDashboardScreenProvider())) {
    on<AdminNavigationDrawerEvent>((event, emit) {
      if (event is TabChangedEvent) {
        switch (event.tab) {
          case 0:
            emit(AdminNavigationDrawerInitial(
                currentIndex: event.tab,
                selectedScreen: const AdminDashboardScreenProvider()));
            break;
          case 1:
            emit(AdminNavigationDrawerInitial(
                currentIndex: event.tab,
                selectedScreen: const AdminVerifyDoctorScreenProvider()));
            break;
          case 2:
            emit(AdminNavigationDrawerInitial(
                currentIndex: event.tab,
                selectedScreen: const AdminDoctorListScreenProvider()));
            break;
          case 3:
            emit(AdminNavigationDrawerInitial(
                currentIndex: event.tab,
                selectedScreen: const AdminPatientListScreenProvider()));
            break;
        }
      }
    });
  }
}
