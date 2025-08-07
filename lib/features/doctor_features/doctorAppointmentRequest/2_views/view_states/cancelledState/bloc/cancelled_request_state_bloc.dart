import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/0_controllers/doctor_appointment_request_controller.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cancelled_request_state_event.dart';
part 'cancelled_request_state_state.dart';

class CancelledRequestStateBloc
    extends Bloc<CancelledRequestStateEvent, CancelledRequestStateState> {
  final DoctorAppointmentRequestController doctorAppointmentRequestController;
  CancelledRequestStateBloc({required this.doctorAppointmentRequestController})
      : super(CancelledRequestStateInitial()) {
    on<CancelledRequestStateInitialEvent>(fetchedCancelledAppointmentRequest);
    on<NavigateToCancelledRequestDetailEvent>(navigateToCancelledRequestDetail);
  }

  FutureOr<void> fetchedCancelledAppointmentRequest(
      CancelledRequestStateInitialEvent event,
      Emitter<CancelledRequestStateState> emit) async {
    emit(CancelledRequestLoadingState());

    final result = await doctorAppointmentRequestController
        .getCancelledDoctorAppointmentRequest();
    result.fold((failure) {
      emit(GetCancelledRequestFailedState(message: failure.toString()));
    }, (cancelledRequests) {
      emit(GetCancelledRequestSuccessState(
          cancelledRequests: cancelledRequests));
    });
  }

  FutureOr<void> navigateToCancelledRequestDetail(
      NavigateToCancelledRequestDetailEvent event,
      Emitter<CancelledRequestStateState> emit) {
    emit(NavigateToCancelledRequestDetailState(appointment: event.appointment));
  }
}
