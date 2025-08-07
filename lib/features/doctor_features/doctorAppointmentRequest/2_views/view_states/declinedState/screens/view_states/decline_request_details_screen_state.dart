import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/reusable_widgets/doctor_reusable_widgets/gina_doctor_app_bar.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/patient_features/appointment/2_views/widgets/appointment_status.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class DeclineRequestDetailScreenState extends StatelessWidget {
  final AppointmentModel appointment;

  const DeclineRequestDetailScreenState({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: GinaDoctorAppBar(title: 'Appointment Request'),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Text(
              DateFormat('MMMM d, yyyy EEEE').format(DateFormat('MMMM d, yyyy')
                  .parse(appointment.appointmentDate!)),
              style: textTheme.bodyMedium?.copyWith(
                color: GinaAppTheme.lightSecondary,
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Gap(5),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: GinaAppTheme.appbarColorLight,
              ),
              height: MediaQuery.of(context).size.height * 0.455,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          Images.profileIcon,
                          height: 40,
                          width: 40,
                        ),
                        const Gap(5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appointment.patientName!,
                              style: textTheme.bodyMedium?.copyWith(
                                color: GinaAppTheme.lightOnBackground,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'Appointment ID: ${appointment.appointmentUid}',
                              style: textTheme.labelSmall?.copyWith(
                                color: GinaAppTheme.lightOutline,
                                fontSize: 10.0,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.16,
                          child: const AppointmentStatusContainer(
                            appointmentStatus: 4,
                          ),
                        )
                      ],
                    ),
                    const Gap(10),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Birth Date',
                                    style: textTheme.bodySmall?.copyWith(
                                        color: GinaAppTheme.lightOutline),
                                    textAlign: TextAlign.start,
                                  ),
                                  const Text(
                                    '',
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Gender',
                                    style: textTheme.bodySmall?.copyWith(
                                        color: GinaAppTheme.lightOutline),
                                    textAlign: TextAlign.start,
                                  ),
                                  const Text(
                                    '',
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Gap(3),
                          const Divider(
                            thickness: 0.5,
                            color: GinaAppTheme.lightOutline,
                          ),
                          const Gap(5),
                          Text(
                            'Address',
                            style: textTheme.bodySmall
                                ?.copyWith(color: GinaAppTheme.lightOutline),
                            textAlign: TextAlign.start,
                          ),
                          const Gap(3),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: const Text(
                              '',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const Gap(3),
                          const Divider(
                            thickness: 0.5,
                            color: GinaAppTheme.lightOutline,
                          ),
                          const Gap(5),
                          Text(
                            'Email Address',
                            style: textTheme.bodySmall
                                ?.copyWith(color: GinaAppTheme.lightOutline),
                            textAlign: TextAlign.start,
                          ),
                          const Gap(3),
                          const Text(
                            '',
                            textAlign: TextAlign.start,
                          ),
                          const Gap(3),
                          const Divider(
                            thickness: 0.5,
                            color: GinaAppTheme.lightOutline,
                          ),
                          const Gap(10),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: GinaAppTheme.lightOutline,
                                width: 0.3,
                              ),
                            ),
                            height: MediaQuery.of(context).size.height * 0.055,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  appointment.modeOfAppointment == 0
                                      ? 'ONLINE CONSULTATION'
                                      : 'FACE-TO-FACE CONSULTATION',
                                  style: textTheme.bodySmall?.copyWith(
                                      color: GinaAppTheme.lightSecondary),
                                ),
                                const Gap(3),
                                Text(
                                  appointment.appointmentTime!,
                                  style: textTheme.bodySmall?.copyWith(
                                      color: GinaAppTheme.lightOutline),
                                ),
                              ],
                            ),
                          ),
                          const Gap(20),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: double.infinity,
                            child: FilledButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    GinaAppTheme.declinedTextColor),
                              ),
                              onPressed: () {},
                              child: const Text('Declined',
                                  style: TextStyle(
                                      color: GinaAppTheme.appbarColorLight)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(20),
            Text(
              'You have declined this appointment request\nPatient data is not available',
              style: textTheme.labelMedium,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
