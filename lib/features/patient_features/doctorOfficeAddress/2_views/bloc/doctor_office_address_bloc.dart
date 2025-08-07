import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'doctor_office_address_event.dart';
part 'doctor_office_address_state.dart';

class DoctorOfficeAddressBloc
    extends Bloc<DoctorOfficeAddressEvent, DoctorOfficeAddressState> {
  DoctorOfficeAddressBloc() : super(DoctorOfficeAddressInitial()) {
    on<DoctorOfficeAddressEvent>((event, emit) {});
  }
}
