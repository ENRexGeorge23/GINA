import 'package:equatable/equatable.dart';
import 'package:first_app/features/auth/0_model/user_model.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:first_app/features/patient_features/periodTracker/0_models/period_tracker_model.dart';

class UserAppointmentPeriodModel extends Equatable {
  final List<UserModel> patients;
  final List<PeriodTrackerModel> patientPeriods;
  final List<AppointmentModel> patientAppointments;

  const UserAppointmentPeriodModel({
    required this.patients,
    required this.patientPeriods,
    required this.patientAppointments,
  });

  factory UserAppointmentPeriodModel.fromJson(Map<String, dynamic> json) {
    return UserAppointmentPeriodModel(
      patients: List<UserModel>.from(json['patients'] ?? []),
      patientPeriods:
          List<PeriodTrackerModel>.from(json['patientPeriods'] ?? []),
      patientAppointments:
          List<AppointmentModel>.from(json['patientPeriods'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'patients': patients,
      'patientPeriods': patientPeriods,
      'patientAppointments': patientAppointments
    };
  }

  @override
  List<Object> get props => [patients, patientPeriods, patientAppointments];
}
