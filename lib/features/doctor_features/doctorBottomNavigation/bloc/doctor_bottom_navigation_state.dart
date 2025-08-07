part of 'doctor_bottom_navigation_bloc.dart';

abstract class DoctorBottomNavigationState extends Equatable {
  final int currentIndex;
  final Widget selectedScreen;

  const DoctorBottomNavigationState(
      {required this.currentIndex, required this.selectedScreen});

  @override
  List<Object> get props => [currentIndex];
}

final class DoctorBottomNavigationInitial extends DoctorBottomNavigationState {
  const DoctorBottomNavigationInitial(
      {required super.currentIndex, required super.selectedScreen});

  @override
  List<Object> get props => [currentIndex];
}
