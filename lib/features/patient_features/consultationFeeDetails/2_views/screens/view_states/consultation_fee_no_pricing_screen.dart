import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/appointment_filled_button/appointment_filled_button.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/patient_features/appointmentDetails/2_views/widgets/doctor_card_container.dart';
import 'package:first_app/features/patient_features/find/2_views/bloc/find_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ConsultationFeeNoPricingScreen extends StatelessWidget {
  const ConsultationFeeNoPricingScreen({super.key});

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
            const Gap(10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(10),
                  Image.asset(Images.consultationPlant),
                  const Gap(30),
                  Text(
                    'Unfortunately,',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Text("the doctor's pricing information is not available",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium),
                  const Gap(30),
                  Text(
                      'We understand the importance of price transparency and encourage you to ask the doctor about their fees during your consultation.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: GinaAppTheme.lightOutline,
                          )),
                ],
              ),
            ),
            const Spacer(),
            const BookAppointmentFilledButton(),
            const Gap(30),
          ],
        ),
      ),
    );
  }
}
