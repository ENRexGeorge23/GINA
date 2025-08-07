import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:first_app/features/doctor_features/doctorEmergencyAnnouncements/0_model/emergency_announcements_model.dart';
import 'package:first_app/features/patient_features/emergencyAnnouncements/1_controllers/emergency_announcement_controllers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'emergency_announcements_event.dart';
part 'emergency_announcements_state.dart';

String? docterMedicalSpeciality;

class EmergencyAnnouncementsBloc
    extends Bloc<EmergencyAnnouncementsEvent, EmergencyAnnouncementsState> {
  final EmergencyAnnouncementsController emergencyController;
  EmergencyAnnouncementsBloc({
    required this.emergencyController,
  }) : super(EmergencyAnnouncementsInitial()) {
    on<GetEmergencyAnnouncements>(getEmergencyAnnouncements);
  }

  FutureOr<void> getEmergencyAnnouncements(GetEmergencyAnnouncements event,
      Emitter<EmergencyAnnouncementsState> emit) async {
    emit(EmergencyAnnouncementsLoading());

    final emergencyAnnouncements =
        await emergencyController.getNearestEmergencyAnnouncement();

    emergencyAnnouncements.fold(
      (error) => emit(EmergencyAnnouncementsError(error.toString())),
      (emergencyAnnouncement) => emit(EmergencyAnnouncementsLoaded(
          emergencyAnnouncement: emergencyAnnouncement,
          doctorMedicalSpeciality: docterMedicalSpeciality!)),
    );
  }
}
