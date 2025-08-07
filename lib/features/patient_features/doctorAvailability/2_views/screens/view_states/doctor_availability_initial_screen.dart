import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/appointment_filled_button/appointment_filled_button.dart';
import 'package:first_app/features/patient_features/appointmentDetails/2_views/widgets/doctor_card_container.dart';
import 'package:first_app/features/patient_features/doctorAvailability/0_model/doctor_availability_model.dart';
import 'package:first_app/features/patient_features/doctorAvailability/2_views/widgets/availability_details_container.dart';
import 'package:first_app/features/patient_features/find/2_views/bloc/find_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DoctorAvailabilityInitialScreen extends StatelessWidget {
  final DoctorAvailabilityModel doctorAvailability;
  const DoctorAvailabilityInitialScreen({
    super.key,
    required this.doctorAvailability,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(10),
            DoctorCardContainer(
              doctor: doctorDetails!,
            ),
            const Gap(20),
            Text(
              'Availability',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const Gap(10),
            AvailabilityDetailsContainer(
              doctorAvailability: doctorAvailability,
            ),
            const Spacer(),
            doctorAvailability.days.isEmpty
                ? const SizedBox()
                : const BookAppointmentFilledButton(),
            const Gap(30),
          ],
        ),
      ),
    );
  }
}
