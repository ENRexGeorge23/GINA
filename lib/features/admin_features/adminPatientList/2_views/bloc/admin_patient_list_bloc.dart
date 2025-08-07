import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:first_app/features/admin_features/adminPatientList/1_controllers/admin_patient_list_controller.dart';
import 'package:first_app/features/auth/0_model/user_model.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_patient_list_event.dart';
part 'admin_patient_list_state.dart';

class AdminPatientListBloc
    extends Bloc<AdminPatientListEvent, AdminPatientListState> {
  final AdminPatientListController adminPatientListController;
  AdminPatientListBloc({
    required this.adminPatientListController,
  }) : super(AdminPatientListInitial()) {
    on<AdminPatientListGetRequestedEvent>(onAdminPatientListGetRequestedEvent);
    on<AdminPatientDetailsEvent>(onAdminPatientDetailsEvent);
  }

  FutureOr<void> onAdminPatientListGetRequestedEvent(
      AdminPatientListGetRequestedEvent event,
      Emitter<AdminPatientListState> emit) async {
    emit(AdminPatientListLoadingState());

    final patients = await adminPatientListController.getAllPatients();

    patients.fold((failure) {
      emit(AdminPatientListErrorState(message: failure.toString()));
    }, (patients) {
      emit(AdminPatientListLoadedState(patients: patients));
    });
  }

  FutureOr<void> onAdminPatientDetailsEvent(AdminPatientDetailsEvent event,
      Emitter<AdminPatientListState> emit) async {
    final patientUid = event.patientDetails.uid;
    final appointments =
        await adminPatientListController.getCurrentPatientAppointment(
      patientUid: patientUid,
    );

    appointments.fold((failure) {
      emit(AdminPatientListErrorState(message: failure.toString()));
    }, (appointments) {
      emit(AdminPatientListPatientDetailsState(
        patientDetails: event.patientDetails,
        appointmentDetails: appointments,
      ));
    });
  }
}
