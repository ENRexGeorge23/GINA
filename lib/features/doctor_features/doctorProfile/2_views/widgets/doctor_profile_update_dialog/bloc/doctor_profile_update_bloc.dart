import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:first_app/features/doctor_features/doctorProfile/1_controllers/doctor_profile_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'doctor_profile_update_event.dart';
part 'doctor_profile_update_state.dart';

class DoctorProfileUpdateBloc
    extends Bloc<DoctorProfileUpdateEvent, DoctorProfileUpdateState> {
  final DoctorProfileController doctorProfileController;
  DoctorProfileUpdateBloc({
    required this.doctorProfileController,
  }) : super(DoctorProfileUpdateInitial()) {
    on<EditDoctorProfileSaveButtonEvent>(editDoctorProfileSaveButtonEvent);
  }

  FutureOr<void> editDoctorProfileSaveButtonEvent(
      EditDoctorProfileSaveButtonEvent event,
      Emitter<DoctorProfileUpdateState> emit) async {
    emit(DoctorProfileUpdating());
    try {
      await doctorProfileController.editDoctorData(
        name: event.name,
        phoneNo: event.phoneNo,
        address: event.address,
      );
      emit(DoctorProfileUpdateSuccess());
    } catch (e) {
      emit(DoctorProfileUpdateError(
        message: e.toString(),
      ));
    }
  }
}
