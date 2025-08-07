part of 'doctor_profile_update_bloc.dart';

sealed class DoctorProfileUpdateEvent extends Equatable {
  const DoctorProfileUpdateEvent();

  @override
  List<Object> get props => [];
}

class EditDoctorProfileSaveButtonEvent extends DoctorProfileUpdateEvent {
  final String name;
  final String phoneNo;
  final String address;

  const EditDoctorProfileSaveButtonEvent({
    required this.name,
    required this.phoneNo,
    required this.address,
  });

  @override
  List<Object> get props => [name, address];
}
