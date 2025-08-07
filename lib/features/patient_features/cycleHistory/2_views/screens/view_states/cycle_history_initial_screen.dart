import 'package:first_app/features/patient_features/cycleHistory/2_views/widgets/cycle_history_header.dart';
import 'package:first_app/features/patient_features/cycleHistory/2_views/widgets/last_cycle_dates_container.dart';
import 'package:first_app/features/patient_features/periodTracker/0_models/period_tracker_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CycleHistoryInitialScreen extends StatelessWidget {
  final List<PeriodTrackerModel>? cycleHistoryList;
  final int? averageCycleLengthOfPatient;
  final DateTime? getLastPeriodDateOfPatient;
  final int? getLastPeriodLenthOfPatient;

  const CycleHistoryInitialScreen(
      {super.key,
      required this.cycleHistoryList,
      required this.averageCycleLengthOfPatient,
      required this.getLastPeriodDateOfPatient,
      required this.getLastPeriodLenthOfPatient});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CycleHistoryHeader(
              getLastPeriodDateOfPatient: getLastPeriodDateOfPatient,
              getLastPeriodLenthOfPatient: getLastPeriodLenthOfPatient,
            ),
            const Gap(20),
            LastCycleDatesContainer(
              cycleHistoryList: cycleHistoryList,
              averageCycleLengthOfPatient: averageCycleLengthOfPatient,
            )
          ],
        ),
      ),
    );
  }
}
