import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:first_app/features/auth/0_model/user_model.dart';
import 'package:first_app/features/patient_features/appointment/2_views/bloc/appointment_bloc.dart';
import 'package:first_app/features/patient_features/appointmentDetails/2_views/widgets/appointment_information_container.dart';
import 'package:first_app/features/patient_features/appointmentDetails/2_views/widgets/appointment_status_card.dart';
import 'package:first_app/features/patient_features/appointmentDetails/2_views/widgets/cancel_appointment_widgets/cancel_modal_dialog.dart';
import 'package:first_app/features/patient_features/appointmentDetails/2_views/widgets/doctor_card_container.dart';
import 'package:first_app/features/patient_features/appointmentDetails/2_views/widgets/reschedule_filled_button.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AppointmentDetailsStatusScreen extends StatelessWidget {
  final DoctorModel doctorDetails;
  final AppointmentModel appointment;
  final UserModel currentPatient;
  const AppointmentDetailsStatusScreen({
    super.key,
    required this.doctorDetails,
    required this.appointment,
    required this.currentPatient,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DoctorCardContainer(
                doctor: doctorDetails,
              ),
              const Gap(20),
              AppointmentStatusCard(
                appointmentStatus: appointment.appointmentStatus,
              ),
              const Gap(10),
              [2, 1].contains(appointment.appointmentStatus)
                  ? const SizedBox()
                  : RescheduleFilledButton(
                      appointmentUid:
                          appointment.appointmentUid ?? storedAppointmentUid!,
                    ),
              const Gap(10),
              AppointmentInformationContainer(
                appointmentModel: appointment,
                currentPatient: currentPatient,
              ),
              const Gap(15),
              [2, 3, 4].contains(appointment.appointmentStatus)
                  ? const SizedBox()
                  : Text(
                      'To ensure a smooth online appointment, please be prepared 15 \nminutes before the scheduled time.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: GinaAppTheme.lightOutline,
                          ),
                    ),
              const Gap(15),
              [2, 3, 4].contains(appointment.appointmentStatus)
                  ? const SizedBox()
                  : SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: OutlinedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          onPressed: () {
                            showCancelModalDialog(context,
                                appointmentId: appointment.appointmentUid!);
                          },
                          child: Text(
                            'Cancel Appointment',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          )),
                    ),
                    const Gap(15),
            ],
          ),
        ),
      ),
    );
  }
}
