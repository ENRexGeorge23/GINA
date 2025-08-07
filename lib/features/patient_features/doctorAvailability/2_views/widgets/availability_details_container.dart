import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/patient_features/doctorAvailability/0_model/doctor_availability_model.dart';
import 'package:first_app/features/patient_features/doctorAvailability/2_views/bloc/doctor_availability_bloc.dart';
import 'package:first_app/features/patient_features/find/2_views/bloc/find_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AvailabilityDetailsContainer extends StatelessWidget {
  final DoctorAvailabilityModel doctorAvailability;

  const AvailabilityDetailsContainer({
    super.key,
    required this.doctorAvailability,
  });

  @override
  Widget build(BuildContext context) {
    final doctorAvailabilityBloc = context.read<DoctorAvailabilityBloc>();
    final modeOfAppointmentList =
        doctorAvailabilityBloc.getModeOfAppointment(doctorAvailability);
    final startTimes = doctorAvailability.startTimes;
    final endTimes = doctorAvailability.endTimes;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: GinaAppTheme.lightOnTertiary,
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 25,
        ),
        child: doctorAvailability.days.isEmpty
            ? Center(
                child: Text(
                  'Dr. ${doctorDetails!.name} has not set any availability yet.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.38,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: GinaAppTheme.lightOutline,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                color: GinaAppTheme.lightOnTertiary,
                              ),
                              width: 32,
                              height: 32,
                              child: Image.asset(Images.officeDaysLogo),
                            ),
                            const Gap(15),
                            Text(
                              'OFFICE DAYS',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      Text(
                        storeDoctorAvailabilityModel != null
                            ? doctorAvailabilityBloc
                                .getDoctorAvailability(doctorAvailability)
                            : '',
                      ),
                    ],
                  ),
                  const Gap(20),
                  const Divider(),
                  const Gap(20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.38,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: GinaAppTheme.lightOutline,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                color: GinaAppTheme.lightOnTertiary,
                              ),
                              width: 32,
                              height: 32,
                              child: Image.asset(Images.officeHoursLogo),
                            ),
                            const Gap(15),
                            Text(
                              'OFFICE HOURS',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            List<Widget>.generate(startTimes.length, (index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Gap(2),
                              Text('${startTimes[index]} - ${endTimes[index]}',
                                  style: Theme.of(context).textTheme.bodySmall),
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                  const Gap(20),
                  const Divider(),
                  const Gap(20),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.38,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: GinaAppTheme.lightOutline,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                color: GinaAppTheme.lightOnTertiary,
                              ),
                              width: 32,
                              height: 32,
                              child: Image.asset(Images.modeOfAppointmentLogo),
                            ),
                            const Gap(15),
                            Text(
                              'MODE OF \nAPPOINTMENT',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: modeOfAppointmentList
                            .map((mode) => Text(mode))
                            .toList(),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
