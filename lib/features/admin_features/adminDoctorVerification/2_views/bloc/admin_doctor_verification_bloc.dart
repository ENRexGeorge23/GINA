import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:first_app/features/admin_features/adminDashboard/2_views/bloc/admin_dashboard_bloc.dart';
import 'package:first_app/features/admin_features/adminDoctorVerification/1_controllers/admin_doctor_verification_controller.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:first_app/features/auth/0_model/doctor_verification_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_doctor_verification_event.dart';
part 'admin_doctor_verification_state.dart';

class AdminDoctorVerificationBloc
    extends Bloc<AdminDoctorVerificationEvent, AdminDoctorVerificationState> {
  final AdminDoctorVerificationController adminDoctorVerificationController;
  AdminDoctorVerificationBloc({required this.adminDoctorVerificationController})
      : super(AdminDoctorVerificationInitial()) {
    on<AdminDoctorVerificationGetRequestedEvent>(
        getRequestedDoctorVerificationListEvent);
    on<AdminVerificationPendingDoctorVerificationListEvent>(
        pendingDoctorVerificationListEvent);
    on<AdminVerificationApprovedDoctorVerificationListEvent>(
        approvedDoctorVerificationListEvent);
    on<AdminVerificationDeclinedDoctorVerificationListEvent>(
        declinedDoctorVerificationListEvent);
    on<NavigateToAdminDoctorDetailsPendingEvent>(
        navigateToDoctorDetailsPendingEvent);
    on<NavigateToAdminDoctorDetailsApprovedEvent>(
        navigateToDoctorDetailsApprovedEvent);
    on<NavigateToAdminDoctorDetailsDeclinedEvent>(
        navigateToDoctorDetailsDeclinedvent);
    on<AdminDoctorVerificationApproveEvent>(
        adminDoctorVerificationApprovedEvent);
    on<AdminDoctorVerificationDeclineEvent>(
        adminDoctorVerificationDeclineEvent);
  }

  FutureOr<void> getRequestedDoctorVerificationListEvent(
      AdminDoctorVerificationGetRequestedEvent event,
      Emitter<AdminDoctorVerificationState> emit) async {
    emit(AdminDoctorVerificationLoading());

    final doctors = await adminDoctorVerificationController.getAllDoctors();

    doctors.fold((failure) {
      emit(AdminDoctorVerificationError(errorMessage: failure.toString()));
    }, (doctors) {
      doctorList = doctors;
      emit(AdminDoctorVerificationLoaded(doctors: doctors));
      emit(AdminVerificationPendingDoctorVerificationListState());
    });
  }

  FutureOr<void> pendingDoctorVerificationListEvent(
      AdminVerificationPendingDoctorVerificationListEvent event,
      Emitter<AdminDoctorVerificationState> emit) {
    emit(AdminVerificationPendingDoctorVerificationListState());
  }

  FutureOr<void> approvedDoctorVerificationListEvent(
      AdminVerificationApprovedDoctorVerificationListEvent event,
      Emitter<AdminDoctorVerificationState> emit) {
    emit(AdminVerificationApprovedDoctorVerificationListState());
  }

  FutureOr<void> declinedDoctorVerificationListEvent(
      AdminVerificationDeclinedDoctorVerificationListEvent event,
      Emitter<AdminDoctorVerificationState> emit) {
    emit(AdminVerificationDeclinedDoctorVerificationListState());
  }

  FutureOr<void> navigateToDoctorDetailsPendingEvent(
      NavigateToAdminDoctorDetailsPendingEvent event,
      Emitter<AdminDoctorVerificationState> emit) async {
    final doctorSubmittedDocuments = await adminDoctorVerificationController
        .getDoctorSubmittedMedicalLicense(
            doctorId: event.pendingDoctorDetails.uid);

    doctorSubmittedDocuments.fold((failure) {
      emit(AdminDoctorVerificationError(errorMessage: failure.toString()));
    }, (doctorSubmittedDocuments) {
      emit(NavigateToAdminDoctorDetailsPendingState(
          pendingDoctorDetails: event.pendingDoctorDetails,
          doctorVerification: doctorSubmittedDocuments));
    });
  }

  FutureOr<void> navigateToDoctorDetailsApprovedEvent(
      NavigateToAdminDoctorDetailsApprovedEvent event,
      Emitter<AdminDoctorVerificationState> emit) async {
    final doctorSubmittedDocuments = await adminDoctorVerificationController
        .getDoctorSubmittedMedicalLicense(
            doctorId: event.approvedDoctorDetails.uid);

    doctorSubmittedDocuments.fold((failure) {
      emit(AdminDoctorVerificationError(errorMessage: failure.toString()));
    }, (doctorSubmittedDocuments) {
      emit(NavigateToAdminDoctorDetailsApprovedState(
          approvedDoctorDetails: event.approvedDoctorDetails,
          doctorVerification: doctorSubmittedDocuments));
    });
  }

  FutureOr<void> navigateToDoctorDetailsDeclinedvent(
      NavigateToAdminDoctorDetailsDeclinedEvent event,
      Emitter<AdminDoctorVerificationState> emit) async {
    final doctorSubmittedDocuments = await adminDoctorVerificationController
        .getDoctorSubmittedMedicalLicense(
            doctorId: event.declinedDoctorDetails.uid);

    doctorSubmittedDocuments.fold((failure) {
      emit(AdminDoctorVerificationError(errorMessage: failure.toString()));
    }, (doctorSubmittedDocuments) {
      emit(NavigateToAdminDoctorDetailsDeclinedState(
          declinedDoctorDetails: event.declinedDoctorDetails,
          doctorVerification: doctorSubmittedDocuments));
    });
  }

  FutureOr<void> adminDoctorVerificationApprovedEvent(
      AdminDoctorVerificationApproveEvent event,
      Emitter<AdminDoctorVerificationState> emit) async {
    final result =
        await adminDoctorVerificationController.approveDoctorVerification(
            doctorId: event.doctorId,
            doctorVerificationId: event.doctorVerificationId);

    result.fold((failure) {
      emit(AdminDoctorVerificationApproveError(
          errorMessage: failure.toString()));
    }, (result) {
      emit(AdminDoctorVerificationApproveState());
      emit(AdminDoctorVerificationLoaded(doctors: doctorList));
      emit(AdminVerificationPendingDoctorVerificationListState());
    });
  }

  FutureOr<void> adminDoctorVerificationDeclineEvent(
      AdminDoctorVerificationDeclineEvent event,
      Emitter<AdminDoctorVerificationState> emit) async {
    final result =
        await adminDoctorVerificationController.declineDoctorVerification(
            doctorId: event.doctorId,
            doctorVerificationId: event.doctorVerificationId,
            declineReason: event.declinedReason);

    result.fold((failure) {
      emit(AdminDoctorVerificationDeclineError(
          errorMessage: failure.toString()));
    }, (result) {
      emit(AdminDoctorVerificationDeclineSuccess());
      emit(AdminDoctorVerificationLoaded(doctors: doctorList));
      emit(AdminVerificationPendingDoctorVerificationListState());
    });
  }
}
