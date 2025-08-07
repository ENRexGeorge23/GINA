import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:first_app/features/admin_features/adminDashboard/1_controllers/admin_dashboard_controller.dart';
import 'package:first_app/features/admin_features/adminDoctorVerification/1_controllers/admin_doctor_verification_controller.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:first_app/features/auth/0_model/doctor_verification_model.dart';
import 'package:first_app/features/auth/0_model/user_model.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_dashboard_event.dart';
part 'admin_dashboard_state.dart';

List<DoctorModel> doctorList = [];
List<UserModel> patientList = [];
bool isFromAdminDashboard = false;

class AdminDashboardBloc
    extends Bloc<AdminDashboardEvent, AdminDashboardState> {
  final AdminDashboardController adminDashboardController;
  final AdminDoctorVerificationController adminDoctorVerificationController;

  AdminDashboardBloc({
    required this.adminDashboardController,
    required this.adminDoctorVerificationController,
  }) : super(AdminDashboardInitial()) {
    on<AdminDashboardGetRequestedEvent>(adminDashboaredGetRequestedEvent);
    on<PendingDoctorVerificationListEvent>(pendingDoctorVerificationListEvent);
    on<ApprovedDoctorVerificationListEvent>(
        approvedDoctorVerificationListEvent);
    on<DeclinedDoctorVerificationListEvent>(
        declinedDoctorVerificationListEvent);

    on<NavigateToDoctorDetailsPendingEvent>(
        navigateToDoctorDetailsPendingEvent);

    on<NavigateToDoctorDetailsApprovedEvent>(
        navigateToDoctorDetailsApprovedEvent);

    on<NavigateToDoctorDetailsDeclinedEvent>(
        navigateToDoctorDetailsDeclinedEvent);

    on<AdminDashboardApproveEvent>(adminDashboardApproveEvent);

    on<AdminDashboardDeclineEvent>(adminDashboardDeclineEvent);

    on<AdminDashboardNavigatetoListofAllAppointmentsEvent>(
        navigateToListofAllAppointmentsEvent);

    on<AdminDashboardNavigatetoListofAllPatientsEvent>(
        navigateToListofAllPatientsEvent);
  }

  FutureOr<void> adminDashboaredGetRequestedEvent(
      AdminDashboardGetRequestedEvent event,
      Emitter<AdminDashboardState> emit) async {
    emit(AdminDashboardLoading());

    final doctors = await adminDashboardController.getAllDoctors();
    final patients = await adminDashboardController.getAllPatients();

    doctors.fold((failure) {
      emit(AdminDashboardError(errorMessage: failure.toString()));
    }, (doctors) {
      doctorList = doctors;
      patients.fold(
        (failure) {
          emit(AdminDashboardError(errorMessage: failure.toString()));
        },
        (patients) {
          patientList = patients;

          emit(AdminDashboardLoaded(
            doctors: doctors,
            patients: patients,
          ));
          emit(PendingDoctorVerificationListState());
        },
      );
    });
  }

  FutureOr<void> pendingDoctorVerificationListEvent(
      PendingDoctorVerificationListEvent event,
      Emitter<AdminDashboardState> emit) {
    emit(PendingDoctorVerificationListState());
  }

  FutureOr<void> approvedDoctorVerificationListEvent(
      ApprovedDoctorVerificationListEvent event,
      Emitter<AdminDashboardState> emit) {
    emit(ApprovedDoctorVerificationListState());
  }

  FutureOr<void> declinedDoctorVerificationListEvent(
      DeclinedDoctorVerificationListEvent event,
      Emitter<AdminDashboardState> emit) {
    emit(DeclinedDoctorVerificationListState());
  }

  FutureOr<void> navigateToDoctorDetailsPendingEvent(
      NavigateToDoctorDetailsPendingEvent event,
      Emitter<AdminDashboardState> emit) async {
    final doctorSubmittedDocuments = await adminDoctorVerificationController
        .getDoctorSubmittedMedicalLicense(
            doctorId: event.pendingDoctorDetails.uid);

    doctorSubmittedDocuments.fold((failure) {
      emit(AdminDashboardError(errorMessage: failure.toString()));
    }, (doctorSubmittedDocuments) {
      emit(NavigateToDoctorDetailsPendingState(
          pendingDoctorDetails: event.pendingDoctorDetails,
          doctorVerification: doctorSubmittedDocuments));
    });
  }

  FutureOr<void> navigateToDoctorDetailsApprovedEvent(
      NavigateToDoctorDetailsApprovedEvent event,
      Emitter<AdminDashboardState> emit) async {
    final doctorSubmittedDocuments = await adminDoctorVerificationController
        .getDoctorSubmittedMedicalLicense(
            doctorId: event.approvedDoctorDetails.uid);

    doctorSubmittedDocuments.fold((failure) {
      emit(AdminDashboardError(errorMessage: failure.toString()));
    }, (doctorSubmittedDocuments) {
      emit(NavigateToDoctorDetailsApprovedState(
          approvedDoctorDetails: event.approvedDoctorDetails,
          doctorVerification: doctorSubmittedDocuments));
    });
  }

  FutureOr<void> navigateToDoctorDetailsDeclinedEvent(
      NavigateToDoctorDetailsDeclinedEvent event,
      Emitter<AdminDashboardState> emit) async {
    final doctorSubmittedDocuments = await adminDoctorVerificationController
        .getDoctorSubmittedMedicalLicense(
            doctorId: event.declinedDoctorDetails.uid);

    doctorSubmittedDocuments.fold((failure) {
      emit(AdminDashboardError(errorMessage: failure.toString()));
    }, (doctorSubmittedDocuments) {
      emit(NavigateToDoctorDetailsDeclinedState(
          declinedDoctorDetails: event.declinedDoctorDetails,
          doctorVerification: doctorSubmittedDocuments));
    });
  }

  FutureOr<void> adminDashboardApproveEvent(AdminDashboardApproveEvent event,
      Emitter<AdminDashboardState> emit) async {
    final result =
        await adminDoctorVerificationController.approveDoctorVerification(
      doctorId: event.doctorId,
      doctorVerificationId: event.doctorVerificationId,
    );

    result.fold((failure) {
      emit(AdminDashboardError(errorMessage: failure.toString()));
    }, (result) async {
      emit(AdminDashboardLoaded(
        doctors: doctorList,
        patients: patientList,
      ));

      emit(PendingDoctorVerificationListState());
      emit(AdminDashboardApproveSuccessState());
    });
  }

  FutureOr<void> adminDashboardDeclineEvent(AdminDashboardDeclineEvent event,
      Emitter<AdminDashboardState> emit) async {
    final result =
        await adminDoctorVerificationController.declineDoctorVerification(
      doctorId: event.doctorId,
      doctorVerificationId: event.doctorVerificationId,
      declineReason: event.declinedReason,
    );

    result.fold((failure) {
      emit(AdminDashboardError(errorMessage: failure.toString()));
    }, (result) async {
      emit(AdminDashboardLoaded(
        doctors: doctorList,
        patients: patientList,
      ));

      emit(PendingDoctorVerificationListState());
      emit(AdminDashboardDeclineSuccessState());
    });
  }

  FutureOr<void> navigateToListofAllAppointmentsEvent(
      AdminDashboardNavigatetoListofAllAppointmentsEvent event,
      Emitter<AdminDashboardState> emit) async {
    final appointments = await adminDashboardController.getAllAppointments();

    appointments.fold((failure) {
      emit(AdminDashboardError(errorMessage: failure.toString()));
    }, (appointments) {
      emit(NavigateToAppointmentsBookedList(appointments: appointments));
    });
  }

  FutureOr<void> navigateToListofAllPatientsEvent(
      AdminDashboardNavigatetoListofAllPatientsEvent event,
      Emitter<AdminDashboardState> emit) async {
    final patients = await adminDashboardController.getAllPatients();

    patients.fold((failure) {
      emit(AdminDashboardError(errorMessage: failure.toString()));
    }, (patients) {
      emit(NavigateToPatientsList(patients: patients));
    });
  }
}
