part of 'doctor_office_address_bloc.dart';

abstract class DoctorOfficeAddressState extends Equatable {
  const DoctorOfficeAddressState();

  @override
  List<Object> get props => [];
}

abstract class DoctorOfficeAddressActionState
    extends DoctorOfficeAddressState {}

class DoctorOfficeAddressInitial extends DoctorOfficeAddressState {}
