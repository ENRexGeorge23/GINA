import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:first_app/core/enum/enum.dart';
import 'package:first_app/features/auth/0_model/user_model.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:first_app/features/patient_features/bookAppointment/1_controllers/appointment_controller.dart';
import 'package:first_app/features/patient_features/doctorAvailability/1_controller/doctor_availability_controller.dart';
import 'package:first_app/features/patient_features/doctorAvailability/2_views/bloc/doctor_availability_bloc.dart';
import 'package:first_app/features/patient_features/profile/1_controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../doctorAvailability/0_model/doctor_availability_model.dart';

part 'book_appointment_event.dart';
part 'book_appointment_state.dart';

DoctorAvailabilityModel? bookDoctorAvailabilityModel;
UserModel? currentActivePatient;
AppointmentModel? currentAppointmentModel;

class BookAppointmentBloc
    extends Bloc<BookAppointmentEvent, BookAppointmentState> {
  final DoctorAvailabilityController doctorAvailabilityController;
  final AppointmentController appointmentController;
  final ProfileController profileController;
  int selectedTimeIndex = -1;
  int selectedModeofAppointmentIndex = -1;
  TextEditingController dateController = TextEditingController();

  BookAppointmentBloc(
      {required this.doctorAvailabilityController,
      required this.appointmentController,
      required this.profileController})
      : super(BookAppointmentInitial()) {
    on<GetDoctorAvailabilityEvent>(onGetDoctorAvailabilityEvent);
    on<NavigateToReviewAppointmentEvent>(navigateToReviewAppointmentEvent);
    on<SelectTimeEvent>(onSelectTimeEvent);
    on<SelectedModeOfAppointmentEvent>(onSelectedModeOfAppointmentEvent);
    on<BookForAnAppointmentEvent>(bookForAnAppointmentEvent);
  }

  FutureOr<void> onGetDoctorAvailabilityEvent(GetDoctorAvailabilityEvent event,
      Emitter<BookAppointmentState> emit) async {
    emit(GetDoctorAvailabilityLoading());

    final getProfileData = await profileController.getPatientProfile();

    getProfileData.fold(
      (failure) {},
      (patientData) {
        currentActivePatient = patientData;
      },
    );

    final result = await doctorAvailabilityController.getDoctorAvailability(
        doctorId: event.doctorId);

    result.fold(
        (error) => emit(GetDoctorAvailabilityError(message: error.toString())),
        (doctorAvailabilityModel) {
      bookDoctorAvailabilityModel = doctorAvailabilityModel;
      emit(GetDoctorAvailabilityLoaded(
          doctorAvailabilityModel: doctorAvailabilityModel,
          selectedTimeIndex: null,
          selectedModeofAppointmentIndex: null));
    });
  }

  FutureOr<void> onSelectTimeEvent(
      SelectTimeEvent event, Emitter<BookAppointmentState> emit) {
    emit(SelectTimeState(
        index: event.index,
        startingTime: event.startingTime,
        endingTime: event.endingTime));

    selectedTimeIndex = event.index;

    emit(GetDoctorAvailabilityLoaded(
        doctorAvailabilityModel: bookDoctorAvailabilityModel!,
        selectedTimeIndex: event.index,
        selectedModeofAppointmentIndex: selectedModeofAppointmentIndex));
  }

  FutureOr<void> onSelectedModeOfAppointmentEvent(
      SelectedModeOfAppointmentEvent event,
      Emitter<BookAppointmentState> emit) {
    emit(SelectedModeOfAppointmentState(
        index: event.index, modeOfAppointment: modeOfAppointment[event.index]));

    selectedModeofAppointmentIndex = event.index;

    emit(GetDoctorAvailabilityLoaded(
        doctorAvailabilityModel: bookDoctorAvailabilityModel!,
        selectedTimeIndex: selectedTimeIndex,
        selectedModeofAppointmentIndex: event.index));
  }

  FutureOr<void> navigateToReviewAppointmentEvent(
      NavigateToReviewAppointmentEvent event,
      Emitter<BookAppointmentState> emit) {
    // emit(ReviewAppointmentState());
  }

  FutureOr<void> bookForAnAppointmentEvent(BookForAnAppointmentEvent event,
      Emitter<BookAppointmentState> emit) async {
    emit(BookAppoinmentRequestLoading());

    String dateString = dateController.text;
    DateTime parsedDate = DateFormat('EEEE, d of MMMM yyyy').parse(dateString);
    String reformattedDate = DateFormat('MMMM d, yyyy').format(parsedDate);

    final result = await appointmentController.requestAnAppointment(
      doctorId: event.doctorId,
      doctorName: event.doctorName,
      doctorClinicAddress: event.doctorClinicAddress,
      appointmentDate: reformattedDate,
      appointmentTime: event.appointmentTime,
      modeOfAppointment: selectedModeofAppointmentIndex,
    );

    result.fold(
        (error) => emit(BookAppointmentError(
              message: error.toString(),
            )), (snapId) {
      currentAppointmentModel = AppointmentModel(
          appointmentUid: snapId,
          doctorUid: event.doctorId,
          doctorName: event.doctorName,
          doctorClinicAddress: event.doctorClinicAddress,
          appointmentDate: dateString,
          appointmentTime: event.appointmentTime,
          modeOfAppointment: selectedModeofAppointmentIndex);

      emit(ReviewAppointmentState(
          appointmentModel: AppointmentModel(
              appointmentUid: snapId,
              doctorUid: event.doctorId,
              doctorName: event.doctorName,
              doctorClinicAddress: event.doctorClinicAddress,
              appointmentDate: dateString,
              appointmentTime: event.appointmentTime,
              modeOfAppointment: selectedModeofAppointmentIndex)));
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

  int calculateAge(String dateOfBirth) {
    final birthDate = DateFormat('MMMM dd, yyyy').parse(dateOfBirth);
    int age = DateTime.now().year - birthDate.year;

    // If the birthday hasn't occurred yet this year, subtract one from age
    if (DateTime.now().month < birthDate.month ||
        (DateTime.now().month == birthDate.month &&
            DateTime.now().day < birthDate.day)) {
      age--;
    }

    return age;
  }
}


