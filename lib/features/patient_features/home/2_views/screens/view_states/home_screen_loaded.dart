import 'package:first_app/features/patient_features/home/2_views/bloc/home_bloc.dart';
import 'package:first_app/features/patient_features/home/2_views/widgets/home_calendar_tracker_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:first_app/features/patient_features/home/2_views/widgets/book_appointment_container.dart';
import 'package:first_app/features/patient_features/home/2_views/widgets/consultation_history_container.dart';
import 'package:first_app/features/patient_features/home/2_views/widgets/forums_container.dart';

class HomeScreenLoaded extends StatelessWidget {
  const HomeScreenLoaded({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Gap(20),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state
                    is HomeGetPeriodTrackerDataAndConsultationHistorySuccess) {
                  return HomeCalendarTrackerContainer(
                    periodTrackerModel: state.periodTrackerModel,
                  );
                } else if (state
                    is HomeGetPeriodTrackerDataAndConsultationHistoryLoadingState) {
                  return const HomeCalendarTrackerContainer(
                    periodTrackerModel: [],
                  );
                }
                return const HomeCalendarTrackerContainer(
                  periodTrackerModel: [],
                );
              },
            ),
            const Gap(20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BookAppointmentContainer(),
                Gap(10),
                ForumsContainer(),
              ],
            ),
            const Gap(20),
            const ConsultationHistoryContainer(),
          ],
        ),
      ),
    );
  }
}
