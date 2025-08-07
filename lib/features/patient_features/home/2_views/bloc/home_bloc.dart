import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:first_app/core/enum/enum.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:first_app/features/patient_features/bookAppointment/1_controllers/appointment_controller.dart';
import 'package:first_app/features/patient_features/periodTracker/0_models/period_tracker_model.dart';
import 'package:first_app/features/patient_features/periodTracker/1_controllers/period_tracker_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geodesy/geodesy.dart' as geo;

part 'home_event.dart';
part 'home_state.dart';

List<PeriodTrackerModel>? periodTrackerModelList;
LatLng? storePatientCurrentLatLng;
geo.LatLng? storePatientCurrentGeoLatLng;

bool consultationHistoryIsLoading = false;

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PeriodTrackerController periodTrackerController;
  final AppointmentController appointmentController;
  HomeBloc({
    required this.periodTrackerController,
    required this.appointmentController,
  }) : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<GetPatientCurrentLocationEvent>(getPatientCurrentLocationEvent);
    on<HomeNavigateToFindDoctorEvent>(homeNavigateInitialEvent);
    on<HomeNavigateToForumEvent>(homeNavigateToForumEvent);
    on<HomeGetPeriodTrackerDataAndConsultationHistoryEvent>(
        homeGetPeriodTrackerDataEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeInitial());
  }

  FutureOr<void> getPatientCurrentLocationEvent(
      GetPatientCurrentLocationEvent event, Emitter<HomeState> emit) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();

    try {
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      LatLng patientLatLng = LatLng(position.latitude, position.longitude);

      storePatientCurrentLatLng = patientLatLng;
      storePatientCurrentGeoLatLng = geo.LatLng(
          storePatientCurrentLatLng!.latitude,
          storePatientCurrentLatLng!.longitude);

      debugPrint('Patient current location: $storePatientCurrentLatLng');
      debugPrint('Patient current GeoLocation: $storePatientCurrentGeoLatLng');
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  FutureOr<void> homeNavigateInitialEvent(
      HomeNavigateToFindDoctorEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToFindDoctorActionState());
  }

  FutureOr<void> homeNavigateToForumEvent(
      HomeNavigateToForumEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToForumActionState());
  }

  FutureOr<void> homeGetPeriodTrackerDataEvent(
      HomeGetPeriodTrackerDataAndConsultationHistoryEvent event,
      Emitter<HomeState> emit) async {
    emit(HomeGetPeriodTrackerDataAndConsultationHistoryLoadingState());
    List<AppointmentModel> completedAppointments = [];
    final consultaionHistory =
        await appointmentController.getCurrentPatientAppointment();

    consultaionHistory
        .fold((error) => emit(HomeInitialError(errorMessage: error.toString())),
            (consultationHistory) {
      var filteredConsultationHistory = consultationHistory
          .where((appointment) =>
              appointment.appointmentStatus ==
                  AppointmentStatus.completed.index ||
              appointment.appointmentStatus ==
                  AppointmentStatus.cancelled.index ||
              appointment.appointmentStatus == AppointmentStatus.declined.index)
          .toList();

      completedAppointments = filteredConsultationHistory;
    });

    try {
      final periodTrackerData = await periodTrackerController.getAllPeriods();
      periodTrackerData.fold(
          (error) => emit(
              HomeGetPeriodTrackerDataAndConsultationHistoryDataError(
                  errorMessage: error.toString())), (data) {
        periodTrackerModelList = data;

        // Create an empty list to store all start dates and period lengths
        List<DateTime> dateRange = [];

        // Iterate over the periodTrackerModelList to extract start dates and period lengths
        for (var period in periodTrackerModelList!) {
          // Extract start date and period length
          DateTime startDate = period.startDate;
          int periodLength = period.endDate.difference(period.startDate).inDays;

          // Add each date in the period range to the dateRange list
          for (int i = 0; i <= periodLength; i++) {
            dateRange.add(startDate.add(Duration(days: i)));
          }
        }

        emit(HomeGetPeriodTrackerDataAndConsultationHistorySuccess(
            periodTrackerModel: dateRange,
            consultationHistory: completedAppointments));
      });
    } catch (e) {
      emit(HomeGetPeriodTrackerDataAndConsultationHistoryDataError(
          errorMessage: e.toString()));
    }
  }
}
