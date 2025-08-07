import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:first_app/core/enum/enum.dart';
import 'package:first_app/features/patient_features/doctorAvailability/0_model/doctor_availability_model.dart';
import 'package:first_app/features/patient_features/doctorAvailability/1_controller/doctor_availability_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'doctor_availability_event.dart';
part 'doctor_availability_state.dart';

DoctorAvailabilityModel? storeDoctorAvailabilityModel;
final List<String> dayNames = [
  'Sunday',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday'
];

final List<String> modeOfAppointment = [
  'Face-to-Face',
  'Online Consultation',
];

class DoctorAvailabilityBloc
    extends Bloc<DoctorAvailabilityEvent, DoctorAvailabilityState> {
  final DoctorAvailabilityController doctorAvailabilityController;
  DoctorAvailabilityBloc({required this.doctorAvailabilityController})
      : super(DoctorAvailabilityInitial()) {
    on<GetDoctorAvailabilityEvent>(onGetDoctorAvailabilityEvent);
  }

  FutureOr<void> onGetDoctorAvailabilityEvent(GetDoctorAvailabilityEvent event,
      Emitter<DoctorAvailabilityState> emit) async {
    emit(DoctorAvailabilityLoading());

    final result = await doctorAvailabilityController.getDoctorAvailability(
        doctorId: event.doctorId);

    result.fold(
        (error) => emit(DoctorAvailabilityError(message: error.toString())),
        (doctorAvailabilityModel) {
      storeDoctorAvailabilityModel = doctorAvailabilityModel;
      emit(DoctorAvailabilityLoaded(doctorAvailabilityModel));
    });
  }

  String getDoctorAvailability(
      DoctorAvailabilityModel doctorAvailabilityModel) {
    if (doctorAvailabilityModel.days.isEmpty) {
      return 'Doctor is not available';
    }

    final String firstDay = dayNames[doctorAvailabilityModel.days.first];
    final String lastDay = dayNames[doctorAvailabilityModel.days.last];

    return '$firstDay to $lastDay';
  }

  List<String> getModeOfAppointment(
      DoctorAvailabilityModel doctorAvailabilityModel) {
    final List<String> modeOfAppointmentList = [];

    for (final mode in doctorAvailabilityModel.modeOfAppointment) {
      ModeOfAppointmentId modeOfAppointmentId =
          ModeOfAppointmentId.values[mode];
      switch (modeOfAppointmentId) {
        case ModeOfAppointmentId.onlineConsultation:
          modeOfAppointmentList.add('Online Consultation');
          break;
        case ModeOfAppointmentId.faceToFaceConsultation:
          modeOfAppointmentList.add('Face-to-Face');
          break;
        default:
          modeOfAppointmentList.add('Unknown');
      }
    }

    return modeOfAppointmentList;
  }
}
