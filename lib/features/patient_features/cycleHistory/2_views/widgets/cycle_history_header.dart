import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/patient_features/bookAppointment/2_views/bloc/book_appointment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class CycleHistoryHeader extends StatelessWidget {
  final DateTime? getLastPeriodDateOfPatient;
  final int? getLastPeriodLenthOfPatient;

  const CycleHistoryHeader({
    super.key,
    required this.getLastPeriodDateOfPatient,
    required this.getLastPeriodLenthOfPatient,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(30),
            Text(
              '  Hi ${currentActivePatient!.name.split(' ')[0]},',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const Gap(10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.18,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Your last period began'),
                    const Gap(10),
                    Text(
                      getLastPeriodLenthOfPatient == null
                          ? ''
                          : DateFormat('EEE, MMM d').format(
                              getLastPeriodDateOfPatient ?? DateTime.now()),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: GinaAppTheme.lightSecondary,
                          ),
                    ),
                    const Gap(15),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          color: GinaAppTheme.lightOutline,
                        ),
                        const Gap(5),
                        getLastPeriodLenthOfPatient == null
                            ? const Text('No data',
                                style:
                                    TextStyle(color: GinaAppTheme.lightOutline))
                            : Row(
                                children: [
                                  const Text('Period lasted'),
                                  const Gap(5),
                                  Text(
                                    '$getLastPeriodLenthOfPatient days',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                    const Gap(5),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          right: -20,
          child: Image.asset(
            Images.womanThinking,
          ),
        ),
      ],
    );
  }
}
