import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/appointment_filled_button/appointment_filled_button.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/patient_features/appointmentDetails/2_views/widgets/doctor_card_container.dart';
import 'package:first_app/features/patient_features/find/2_views/bloc/find_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AppointmentDetailsInitialScreen extends StatelessWidget {
  const AppointmentDetailsInitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            DoctorCardContainer(
              doctor: doctorDetails!,
            ),
            const Gap(20),
            Text('There is no set of appointments yet.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: GinaAppTheme.lightOutline,
                    )),
            Text('You have to book an appointment first.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: GinaAppTheme.lightOutline,
                    )),
            const Spacer(),
            const BookAppointmentFilledButton(),
            const Gap(30),
          ],
        ),
      ),
    );
  }
}
