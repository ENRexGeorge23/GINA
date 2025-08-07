import 'package:first_app/features/patient_features/appointment/2_views/bloc/appointment_bloc.dart';
import 'package:first_app/features/patient_features/appointmentDetails/2_views/bloc/appointment_details_bloc.dart';
import 'package:flutter/material.dart';

String? appointmentUidToReschedule;

class RescheduleFilledButton extends StatelessWidget {
  final String appointmentUid;
  const RescheduleFilledButton({
    super.key,
    required this.appointmentUid,
  });

  @override
  Widget build(BuildContext context) {
    appointmentUidToReschedule = appointmentUid;
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: FilledButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        onPressed: () {
          isRescheduleMode = true;
          if (isFromAppointmentTabs) {
            Navigator.pushNamed(context, '/bookAppointment');
          } else {
            Navigator.pushReplacementNamed(context, '/bookAppointment');
          }
        },
        child: Text(
          'Reschedule',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
