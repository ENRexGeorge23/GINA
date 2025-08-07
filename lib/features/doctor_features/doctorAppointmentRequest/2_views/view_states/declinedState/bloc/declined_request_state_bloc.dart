import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/0_controllers/doctor_appointment_request_controller.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'declined_request_state_event.dart';
part 'declined_request_state_state.dart';

class DeclinedRequestStateBloc
    extends Bloc<DeclinedRequestStateEvent, DeclinedRequestStateState> {
  final DoctorAppointmentRequestController doctorAppointmentRequestController;
  DeclinedRequestStateBloc({required this.doctorAppointmentRequestController})
      : super(DeclinedRequestStateInitial()) {
    on<DeclinedRequestStateInitialEvent>(fetchedDeclinedAppointmentRequest);
    on<NavigateToDeclinedRequestDetailEvent>(navigateToDeclinedRequestDetail);
  }

  FutureOr<void> fetchedDeclinedAppointmentRequest(
      DeclinedRequestStateInitialEvent event,
      Emitter<DeclinedRequestStateState> emit) async {
    emit(DeclinedRequestLoadingState());

    final result = await doctorAppointmentRequestController
        .getDeclinedDoctorAppointmentRequest();
    result.fold((failure) {
      emit(GetDeclinedRequestFailedState(message: failure.toString()));
    }, (declinedRequests) {
      emit(GetDeclinedRequestSuccessState(declinedRequests: declinedRequests));
    });
  }

  FutureOr<void> navigateToDeclinedRequestDetail(
      NavigateToDeclinedRequestDetailEvent event,
      Emitter<DeclinedRequestStateState> emit) {
    emit(NavigateToDeclinedRequestDetailState(appointment: event.appointment));
  }
}
