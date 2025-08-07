part of 'appointment_bloc.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object> get props => [];
}

abstract class AppointmentActionState extends AppointmentState {}

class AppointmentInitial extends AppointmentState {}

class GetAppointmentsLoading extends AppointmentState {}

class GetAppointmentsLoaded extends AppointmentState {
  final List<AppointmentModel> appointments;

  const GetAppointmentsLoaded({required this.appointments});

  @override
  List<Object> get props => [appointments];
}

class GetAppointmentsError extends AppointmentState {
  final String message;

  const GetAppointmentsError({required this.message});

  @override
  List<Object> get props => [message];
}

class AppointmentDetailsState extends AppointmentState {
  final AppointmentModel appointment;
  final DoctorModel doctorDetails;
  final UserModel currentPatient;

  const AppointmentDetailsState(
      {required this.appointment,
      required this.doctorDetails,
      required this.currentPatient});

  @override
  List<Object> get props => [appointment, doctorDetails, currentPatient];
}

class AppointmentDetailsLoading extends AppointmentState {}

class AppointmentDetailsError extends AppointmentState {
  final String message;

  const AppointmentDetailsError({required this.message});

  @override
  List<Object> get props => [message];
}

class ConsultationHistoryState extends AppointmentState {
  final AppointmentModel appointment;
  final DoctorModel doctorDetails;
  final UserModel currentPatient;
  final List<String> prescriptionImages;

  const ConsultationHistoryState(
      {required this.appointment,
      required this.doctorDetails,
      required this.currentPatient,
      required this.prescriptionImages});

  @override
  List<Object> get props =>
      [appointment, doctorDetails, currentPatient, prescriptionImages];
}

class ConsultationHistoryLoading extends AppointmentState {}

class ConsultationHistoryError extends AppointmentState {
  final String message;

  const ConsultationHistoryError({required this.message});

  @override
  List<Object> get props => [message];
}

class UploadPrescriptionState extends AppointmentState {
  final List<File> prescriptionImage;
  final List<File> imageTitle;

  const UploadPrescriptionState({
    required this.prescriptionImage,
    required this.imageTitle,
  });
}

class UploadPrescriptionLoading extends AppointmentState {}

class UploadPrescriptionError extends AppointmentState {
  final String message;

  const UploadPrescriptionError({required this.message});

  @override
  List<Object> get props => [message];
}

class UploadingPrescriptionInFirebase extends AppointmentActionState {}

class PrescriptionUploadedSuccessfully extends AppointmentActionState {}

class GetPrescriptionImagesState extends AppointmentState {
  final List<String> images;

  const GetPrescriptionImagesState({required this.images});

  @override
  List<Object> get props => [images];
}

class GetPrescriptionImagesError extends AppointmentState {
  final String message;

  const GetPrescriptionImagesError({required this.message});

  @override
  List<Object> get props => [message];
}

class GetPrescriptionImagesLoading extends AppointmentState {}

class NavigateToUploadPrescription extends AppointmentState {}

class CancelAppointmentState extends AppointmentActionState {}

class CancelAppointmentError extends AppointmentActionState {
  final String message;

  CancelAppointmentError({required this.message});

  @override
  List<Object> get props => [message];
}

class CancelAppointmentLoading extends AppointmentActionState {}
