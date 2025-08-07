import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:first_app/features/doctor_features/doctorConsultationFee/1_controllers/doctor_consultation_fee_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'doctor_consultation_fee_event.dart';
part 'doctor_consultation_fee_state.dart';

class DoctorConsultationFeeBloc
    extends Bloc<DoctorConsultationFeeEvent, DoctorConsultationFeeState> {
  final DoctorConsultationFeeController doctorConsultationFeeController;
  DoctorConsultationFeeBloc({
    required this.doctorConsultationFeeController,
  }) : super(DoctorConsultationFeeInitial()) {
    on<GetDocotorConsultationFeeEvent>(getCurrentDoctor);
    on<NavigateToEditDoctorConsultationFeeEvent>(
        navigateToEditDoctorConsultationFeeEvent);
    on<SaveEditDoctorConsultationFeeEvent>(saveEditDoctorConsultationFeeEvent);
    on<ToggleDoctorConsultationPriceFeeEvent>(
        toggleDoctorConsultationPriceFeeEvent);
  }

  FutureOr<void> getCurrentDoctor(GetDocotorConsultationFeeEvent event,
      Emitter<DoctorConsultationFeeState> emit) async {
    emit(DoctorConsultationFeeLoadingState());

    final getCurrentDoctorData =
        await doctorConsultationFeeController.getCurrentDoctor();

    getCurrentDoctorData.fold(
      (failure) =>
          emit(DoctorConsultationFeeErrorState(message: failure.toString())),
      (doctorData) {
        //profileDoctorRatingId = doctorData.doctorRatingId;
        emit(DoctorConsultationFeeLoadedState(
          doctor: doctorData,
        ));
      },
    );
  }

  FutureOr<void> navigateToEditDoctorConsultationFeeEvent(
      NavigateToEditDoctorConsultationFeeEvent event,
      Emitter<DoctorConsultationFeeState> emit) async {
    emit(DoctorConsultationFeeLoadingState());

    final getCurrentDoctorData =
        await doctorConsultationFeeController.getCurrentDoctor();

    getCurrentDoctorData.fold(
      (failure) =>
          emit(DoctorConsultationFeeErrorState(message: failure.toString())),
      (doctorData) => emit(NavigateToEditDoctorConsultationFeeState(
        doctorData: doctorData,
      )),
    );
  }

  FutureOr<void> saveEditDoctorConsultationFeeEvent(
      SaveEditDoctorConsultationFeeEvent event,
      Emitter<DoctorConsultationFeeState> emit) async {
    //emit(DoctorConsultationFeeLoadingState());
    try {
      await doctorConsultationFeeController.updateDoctorConsultationFee(
        f2fFollowUpConsultationPrice: event.f2fFollowUpConsultationPrice,
        f2fInitialConsultationPrice: event.f2fInitialConsultationPrice,
        olFollowUpConsultationPrice: event.olFollowUpConsultationPrice,
        olInitialConsultationPrice: event.olInitialConsultationPrice,
      );
    } catch (e) {
      emit(DoctorConsultationFeeErrorState(
        message: e.toString(),
      ));
    }
  }

  FutureOr<void> toggleDoctorConsultationPriceFeeEvent(
      ToggleDoctorConsultationPriceFeeEvent event,
      Emitter<DoctorConsultationFeeState> emit) async {
    await doctorConsultationFeeController.toggleDoctorConsultationPriceFee();
  }
}
