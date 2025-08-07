import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:first_app/features/doctor_features/doctorProfile/1_controllers/doctor_profile_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'doctor_profile_event.dart';
part 'doctor_profile_state.dart';

int? profileDoctorRatingId;

class DoctorProfileBloc extends Bloc<DoctorProfileEvent, DoctorProfileState> {
  final DoctorProfileController docProfileController;
  DoctorProfileBloc({required this.docProfileController})
      : super(DoctorProfileInitial()) {
    on<GetDoctorProfileEvent>(getDocProfileEvent);
    on<NavigateToEditDocotorProfileEvent>(navigateToEditDoctorProfileEvent);
    on<DoctorProfileNavigateToMyForumsPostEvent>(
        profileNavigateToMyForumsPostEvent);
  }

  FutureOr<void> getDocProfileEvent(
      GetDoctorProfileEvent event, Emitter<DoctorProfileState> emit) async {
    emit(DoctorProfileLoading());

    final getProfileData = await docProfileController.getDoctorProfile();

    getProfileData.fold(
      (failure) => emit(DoctorProfileError(message: failure.toString())),
      (doctorData) {
        profileDoctorRatingId = doctorData.doctorRatingId;
        emit(DoctorProfileLoaded(
          doctorData: doctorData,
        ));
      },
    );
  }

  FutureOr<void> navigateToEditDoctorProfileEvent(
      NavigateToEditDocotorProfileEvent event,
      Emitter<DoctorProfileState> emit) async {
    emit(DoctorProfileLoading());

    final getProfileData = await docProfileController.getDoctorProfile();

    getProfileData.fold(
      (failure) => emit(DoctorProfileError(message: failure.toString())),
      (doctorData) => emit(NavigateToEditDoctorProfileState(
        doctorData: doctorData,
      )),
    );
  }

  FutureOr<void> profileNavigateToMyForumsPostEvent(
      DoctorProfileNavigateToMyForumsPostEvent event,
      Emitter<DoctorProfileState> emit) {
    emit(DoctorProfileNavigateToMyForumsPostState());
  }
}
