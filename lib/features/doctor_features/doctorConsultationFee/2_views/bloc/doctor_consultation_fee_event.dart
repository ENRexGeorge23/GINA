part of 'doctor_consultation_fee_bloc.dart';

sealed class DoctorConsultationFeeEvent extends Equatable {
  const DoctorConsultationFeeEvent();

  @override
  List<Object> get props => [];
}

class DoctorConsultationFeeInitialEvent extends DoctorConsultationFeeEvent {}

class GetDocotorConsultationFeeEvent extends DoctorConsultationFeeEvent {}

class NavigateToEditDoctorConsultationFeeEvent
    extends DoctorConsultationFeeEvent {}

class ToggleDoctorConsultationPriceFeeEvent
    extends DoctorConsultationFeeEvent {}

class SaveEditDoctorConsultationFeeEvent extends DoctorConsultationFeeEvent {
  final double f2fInitialConsultationPrice;
  final double f2fFollowUpConsultationPrice;
  final double olInitialConsultationPrice;
  final double olFollowUpConsultationPrice;

  const SaveEditDoctorConsultationFeeEvent({
    required this.f2fFollowUpConsultationPrice,
    required this.f2fInitialConsultationPrice,
    required this.olInitialConsultationPrice,
    required this.olFollowUpConsultationPrice,
  });

  @override
  List<Object> get props => [
        f2fInitialConsultationPrice,
        f2fFollowUpConsultationPrice,
        olInitialConsultationPrice,
        olFollowUpConsultationPrice,
      ];
}
