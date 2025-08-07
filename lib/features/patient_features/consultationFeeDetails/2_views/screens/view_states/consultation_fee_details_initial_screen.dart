import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/appointment_filled_button/appointment_filled_button.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/patient_features/appointmentDetails/2_views/widgets/doctor_card_container.dart';
import 'package:first_app/features/patient_features/consultationFeeDetails/2_views/screens/view_states/consultation_fee_no_pricing_screen.dart';
import 'package:first_app/features/patient_features/find/2_views/bloc/find_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class ConsultationFeeDetailsInitialScreen extends StatelessWidget {
  final bool isPricingShown;
  const ConsultationFeeDetailsInitialScreen(
      {super.key, required this.isPricingShown});

  @override
  Widget build(BuildContext context) {
    return doctorDetails!.f2fInitialConsultationPrice == null
        ? const ConsultationFeeNoPricingScreen()
        : isPricingShown == false
            ? const ConsultationFeeNoPricingScreen()
            : Center(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Face-to-face consultation',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const Gap(5),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.19,
                              child: Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Initial Consultation'),
                                        Text(
                                          '₱ ${NumberFormat("#,##0.00", "en_US").format(doctorDetails!.f2fInitialConsultationPrice)}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.w700,
                                              ),
                                        ),
                                      ],
                                    ),
                                    const Gap(20),
                                    const Divider(),
                                    const Gap(20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Follow-up Consultation'),
                                        Text(
                                          '₱ ${NumberFormat("#,##0.00").format(doctorDetails!.f2fFollowUpConsultationPrice)}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.w700,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const Gap(10),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Online consultation',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const Gap(5),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.19,
                              child: Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Initial Consultation'),
                                        Text(
                                          '₱ ${NumberFormat("#,##0.00", "en_US").format(doctorDetails!.olInitialConsultationPrice)}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.w700,
                                              ),
                                        ),
                                      ],
                                    ),
                                    const Gap(20),
                                    const Divider(),
                                    const Gap(20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Follow-up Consultation'),
                                        Text(
                                          '₱ ${NumberFormat("#,##0.00", "en_US").format(doctorDetails!.olFollowUpConsultationPrice)}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.w700,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const Gap(10),
                      Text(
                          'Please note that the price list is for information only and there will \nbe no payment handling inside the app.',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
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
