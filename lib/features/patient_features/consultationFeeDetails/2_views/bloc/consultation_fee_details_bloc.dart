import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:first_app/features/patient_features/consultationFeeDetails/1_controller/consultation_fee_details_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'consultation_fee_details_event.dart';
part 'consultation_fee_details_state.dart';

bool? isPricingFeeShown;

class ConsultationFeeDetailsBloc
    extends Bloc<ConsultationFeeDetailsEvent, ConsultationFeeDetailsState> {
  final ConsultationFeeDetailsController consultationFeeDetailsController;

  ConsultationFeeDetailsBloc({
    required this.consultationFeeDetailsController,
  }) : super(ConsultationFeeDetailsInitial(
            isPricingShown: isPricingFeeShown ?? false)) {
    on<ToggleConsultationPricingEvent>(toggleConsultationPricingEvent);
  }

  FutureOr<void> toggleConsultationPricingEvent(
      ToggleConsultationPricingEvent event,
      Emitter<ConsultationFeeDetailsState> emit) async {
    final isPricingShown =
        await consultationFeeDetailsController.getConsultationFeeData();

    isPricingFeeShown = isPricingShown;

    emit(ConsultationFeeDetailsInitial(isPricingShown: isPricingShown));
  }
}
