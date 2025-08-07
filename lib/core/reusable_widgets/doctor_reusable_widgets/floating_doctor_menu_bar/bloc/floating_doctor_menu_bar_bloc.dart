import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:first_app/features/doctor_features/doctorProfile/1_controllers/doctor_profile_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'floating_doctor_menu_bar_event.dart';
part 'floating_doctor_menu_bar_state.dart';

class FloatingDoctorMenuBarBloc
    extends Bloc<FloatingDoctorMenuBarEvent, FloatingDoctorMenuBarState> {
  final DoctorProfileController doctorProfileController;
  FloatingDoctorMenuBarBloc({
    required this.doctorProfileController,
  }) : super(FloatingDoctorMenuBarInitial()) {
    on<GetDoctorNameEvent>(getDoctorName);
  }

  FutureOr<void> getDoctorName(GetDoctorNameEvent event,
      Emitter<FloatingDoctorMenuBarState> emit) async {
    final currentDoctorName =
        await doctorProfileController.getCurrentDoctorName();
    emit(GetDoctorName(doctorName: currentDoctorName));
  }
}
