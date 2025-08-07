import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:first_app/features/auth/0_model/user_model.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:first_app/features/patient_features/bookAppointment/1_controllers/appointment_controller.dart';
import 'package:first_app/features/patient_features/bookAppointment/2_views/bloc/book_appointment_bloc.dart';
import 'package:first_app/features/patient_features/find/1_controllers/find_controllers.dart';
import 'package:first_app/features/patient_features/find/2_views/bloc/find_bloc.dart';
import 'package:first_app/features/patient_features/profile/1_controllers/profile_controller.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

String? storedAppointmentUid;
String? storedAppointmentTime;
AppointmentModel? appointmentDetails;
List<String>? storedPrescriptionImages;
bool isUploadPrescriptionMode = false;
bool isFromAppointmentTabs = false;
bool isFromConsultationHistory = false;

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentController appointmentController;
  final ProfileController profileController;
  final FindController findController;

  AppointmentBloc({
    required this.appointmentController,
    required this.profileController,
    required this.findController,
  }) : super(AppointmentInitial()) {
    on<GetAppointmentsEvent>(onGetAppointmentsEvent);
    on<NavigateToAppointmentDetailsEvent>(_navigateToAppointmentDetailsEvent);
    on<NavigateToConsultationHistoryEvent>(_navigateToConsultationHistoryEvent);
    on<ChooseImageEvent>(chooseImageEvent);
    on<RemoveImageEvent>(removeImage);
    on<UploadPrescriptionEvent>(uploadPrescriptionEvent);
    on<CancelAppointmentInAppointmentTabsEvent>(cancelAppointmentEvent);
  }

  List<File> prescriptionImages = [];
  List<File> imageTitles = [];
  List<AppointmentModel> storedAppointments = [];

  FutureOr<void> onGetAppointmentsEvent(
      GetAppointmentsEvent event, Emitter<AppointmentState> emit) async {
    emit(GetAppointmentsLoading());
    final result = await appointmentController.getCurrentPatientAppointment();

    result.fold(
      (failure) {
        emit(GetAppointmentsError(message: failure.toString()));
      },
      (appointments) {
        storedAppointments = appointments;
        emit(GetAppointmentsLoaded(appointments: appointments));
      },
    );
  }

  FutureOr<void> _navigateToAppointmentDetailsEvent(
      NavigateToAppointmentDetailsEvent event,
      Emitter<AppointmentState> emit) async {
    emit(AppointmentDetailsLoading());

    storedAppointmentUid = event.appointmentUid;

    final getDoctorDetails = await appointmentController.getDoctorDetail(
      doctorUid: event.doctorUid,
    );

    DoctorModel? doctorInformation;
    getDoctorDetails.fold(
      (failure) {},
      (getDoctorDetails) {
        doctorInformation = getDoctorDetails;
        doctorDetails = getDoctorDetails;
      },
    );

    final getProfileData = await profileController.getPatientProfile();

    getProfileData.fold(
      (failure) {},
      (patientData) {
        currentActivePatient = patientData;
      },
    );

    final result = await appointmentController.getAppointmentDetails(
      appointmentUid: event.appointmentUid,
    );

    result.fold(
      (failure) {
        emit(AppointmentDetailsError(message: failure.toString()));
      },
      (appointment) {
        emit(AppointmentDetailsState(
          appointment: appointment,
          doctorDetails: doctorInformation!,
          currentPatient: currentActivePatient!,
        ));
      },
    );
  }

  FutureOr<void> _navigateToConsultationHistoryEvent(
      NavigateToConsultationHistoryEvent event,
      Emitter<AppointmentState> emit) async {
    emit(ConsultationHistoryLoading());

    final getDoctorDetails = await appointmentController.getDoctorDetail(
      doctorUid: event.doctorUid,
    );

    DoctorModel? doctorInformation;
    getDoctorDetails.fold(
      (failure) {},
      (getDoctorDetails) {
        doctorDetails = getDoctorDetails;
        doctorInformation = getDoctorDetails;
      },
    );

    final getProfileData = await profileController.getPatientProfile();

    getProfileData.fold(
      (failure) {},
      (patientData) {
        currentActivePatient = patientData;
      },
    );

    final result = await appointmentController.getCompletedAppointment(
      appointmentUid: event.appointmentUid,
    );

    result.fold(
      (failure) {
        emit(AppointmentDetailsError(message: failure.toString()));
      },
      (appointment) async {
        appointmentDetails = appointment;
      },
    );

    final images = await appointmentController.getPrescriptionImages(
      appointmentUid: event.appointmentUid,
    );

    images.fold(
      (failure) {
        emit(GetPrescriptionImagesError(message: failure.toString()));
      },
      (images) {
        storedPrescriptionImages = images;
        emit(ConsultationHistoryState(
          appointment: appointmentDetails!,
          doctorDetails: doctorInformation!,
          currentPatient: currentActivePatient!,
          prescriptionImages: images,
        ));
      },
    );
  }

  FutureOr<void> chooseImageEvent(
      ChooseImageEvent event, Emitter<AppointmentState> emit) async {
    emit(UploadPrescriptionLoading());
    final pickedFiles = await ImagePicker().pickMultiImage();

    if (pickedFiles.isNotEmpty) {
      for (var pickedFile in pickedFiles) {
        prescriptionImages.add(File(pickedFile.path));
        imageTitles.add(File(pickedFile.path));
      }

      emit(UploadPrescriptionState(
        prescriptionImage: prescriptionImages,
        imageTitle: imageTitles,
      ));
    }
  }

  FutureOr<void> removeImage(
      RemoveImageEvent event, Emitter<AppointmentState> emit) {
    emit(UploadPrescriptionLoading());

    prescriptionImages.removeAt(event.index);
    imageTitles.removeAt(event.index);

    emit(UploadPrescriptionState(
      prescriptionImage: prescriptionImages,
      imageTitle: imageTitles,
    ));
  }

  FutureOr<void> uploadPrescriptionEvent(
      UploadPrescriptionEvent event, Emitter<AppointmentState> emit) async {
    emit(UploadingPrescriptionInFirebase());

    final result = await appointmentController.uploadPrescriptionImages(
      appointmentUid: storedAppointmentUid!,
      images: event.images,
    );

    result.fold(
      (failure) {
        emit(UploadPrescriptionError(message: failure.toString()));
      },
      (prescriptionImages) {
        storedPrescriptionImages = prescriptionImages;
        emit(PrescriptionUploadedSuccessfully());
      },
    );
  }

  FutureOr<void> cancelAppointmentEvent(
      CancelAppointmentInAppointmentTabsEvent event,
      Emitter<AppointmentState> emit) async {
    emit(CancelAppointmentLoading());

    final result = await appointmentController.cancelAppointment(
      appointmentUid: event.appointmentUid,
    );

    result.fold((failure) {
      emit(CancelAppointmentError(message: failure.toString()));
    }, (appointment) {
      emit(CancelAppointmentState());
      emit(GetAppointmentsLoaded(appointments: storedAppointments));
    });
  }
}
