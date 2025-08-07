import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:first_app/features/patient_features/find/1_controllers/find_controllers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'find_event.dart';
part 'find_state.dart';

List<DoctorModel>? doctorNearMeLists;
Map<String, List<DoctorModel>>? storedCitiesWithDoctors;
List<DoctorModel>? getAllDoctors;
DoctorModel? doctorDetails;

class FindBloc extends Bloc<FindEvent, FindState> {
  final FindController findController;
  FindBloc({
    required this.findController,
  }) : super(FindInitial()) {
    on<FindInitialEvent>(findIntitalEvent);
    on<FindNavigateToDoctorDetailsEvent>(findNavigateToDoctorDetailsEvent);
    on<GetAllDoctorsEvent>(getAllDoctorsEvent);
    on<GetDoctorsNearMeEvent>(getDoctorsNearMeEvent);
    on<GetDoctorsInTheNearestCityEvent>(getDoctorsInTheNearestCityEvent);
  }

  FutureOr<void> findIntitalEvent(
      FindInitialEvent event, Emitter<FindState> emit) {
    emit(FindLoaded());
  }

  FutureOr<void> findNavigateToDoctorDetailsEvent(
      FindNavigateToDoctorDetailsEvent event, Emitter<FindState> emit) {
    doctorDetails = event.doctor;
    emit(FindNavigateToDoctorDetailsState(
      doctor: event.doctor,
    ));
  }

  FutureOr<void> getDoctorsNearMeEvent(
      GetDoctorsNearMeEvent event, Emitter<FindState> emit) async {
    emit(GetDoctorNearMeLoadingState());
    final doctorLists = await findController.getDoctorsNearMe();
    doctorLists.fold(
        (failure) =>
            emit(GetDoctorNearMeFailedState(message: failure.toString())),
        (doctorLists) {
      doctorNearMeLists = doctorLists;
      emit(GetDoctorNearMeSuccessState(doctorLists: doctorLists));
      emit(GetDoctorsInTheNearestCitySuccessState(
        citiesWithDoctors: storedCitiesWithDoctors ?? {},
      ));
    });
  }

  FutureOr<void> getDoctorsInTheNearestCityEvent(
      GetDoctorsInTheNearestCityEvent event, Emitter<FindState> emit) async {
    emit(GetDoctorsInTheNearestCityLoadingState());

    final citiesWithDoctors = await findController.getDoctorsInCities();

    citiesWithDoctors.fold(
        (failure) =>
            emit(GetDoctorNearMeFailedState(message: failure.toString())),
        (citiesWithDoctors) {
      storedCitiesWithDoctors = citiesWithDoctors;
      emit(GetDoctorsInTheNearestCitySuccessState(
        citiesWithDoctors: citiesWithDoctors,
      ));
    });
  }

  FutureOr<void> getAllDoctorsEvent(
      GetAllDoctorsEvent event, Emitter<FindState> emit) async {
    final allDoctors = await findController.getDoctors();

    allDoctors.fold(
        (failure) =>
            emit(GetAllDoctorsFailedState(message: failure.toString())),
        (doctorLists) {
      getAllDoctors = doctorLists;
    });
  }
}
