part of 'find_bloc.dart';

abstract class FindState extends Equatable {
  const FindState();

  @override
  List<Object> get props => [];
}

abstract class FindActionState extends FindState {}

class FindInitial extends FindState {}

class FindLoading extends FindState {}

class FindLoaded extends FindState {}

class FindNavigateToDoctorDetailsState extends FindActionState {
  final DoctorModel doctor;

  FindNavigateToDoctorDetailsState({
    required this.doctor,
  });

  @override
  List<Object> get props => [doctor];
}

class GetDoctorNearMeSuccessState extends FindState {
  final List<DoctorModel> doctorLists;

  const GetDoctorNearMeSuccessState({
    required this.doctorLists,
  });

  @override
  List<Object> get props => [doctorLists];
}

class GetDoctorNearMeFailedState extends FindState {
  final String message;

  const GetDoctorNearMeFailedState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class GetDoctorNearMeLoadingState extends FindState {}

class GetDoctorsInTheNearestCityLoadingState extends FindState {}

class GetDoctorsInTheNearestCitySuccessState extends FindState {
final Map<String, List<DoctorModel>> citiesWithDoctors;

  const GetDoctorsInTheNearestCitySuccessState({
    required this.citiesWithDoctors,
  });

  @override
  List<Object> get props => [citiesWithDoctors];
}

class GetDoctorsInTheNearestCityFailedState extends FindState {
  final String message;

  const GetDoctorsInTheNearestCityFailedState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class GetAllDoctorsFailedState extends FindState {
  final String message;

  const GetAllDoctorsFailedState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class GetAllDoctorsLoadingState extends FindState {}
