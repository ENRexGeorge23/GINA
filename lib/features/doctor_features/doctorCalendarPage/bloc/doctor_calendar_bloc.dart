import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'doctor_calendar_event.dart';
part 'doctor_calendar_state.dart';

class DoctorCalendarBloc
    extends Bloc<DoctorCalendarEvent, DoctorCalendarState> {
  DoctorCalendarBloc() : super(DoctorCalendarInitial()) {
    on<DoctorCalendarEvent>((event, emit) {});
  }
}
