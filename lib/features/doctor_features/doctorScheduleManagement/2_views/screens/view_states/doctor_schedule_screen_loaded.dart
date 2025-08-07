import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/doctor_features/doctorScheduleManagement/0_models/doctor_schedule_model.dart';
import 'package:first_app/features/doctor_features/doctorScheduleManagement/2_views/bloc/doctor_schedule_bloc.dart';
import 'package:first_app/features/doctor_features/doctorScheduleManagement/2_views/widgets/doctor_card_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DoctorScheduleScreenLoaded extends StatelessWidget {
  final ScheduleModel schedule;
  const DoctorScheduleScreenLoaded({
    super.key,
    required this.schedule,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Gap(5),
          const DoctorDetailsCard(),
          schedule.days.isEmpty ? const SizedBox() : const Gap(20),
          schedule.days.isEmpty
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Schedule',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
          const Gap(10),
          schedule.days.isEmpty
              ? Text(
                  'No schedule set yet',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: GinaAppTheme.lightOutline),
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: GinaAppTheme.lightOnTertiary,
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  // height: MediaQuery.of(context).size.height * 0.38,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 25,
                    ),
                    child: Column(
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
                            BlocBuilder<DoctorScheduleBloc,
                                DoctorScheduleState>(
                              builder: (context, state) {
                                if (state is GetScheduleSuccessState) {
                                  String firstDayString = '';
                                  String lastDayString = '';
                                  switch (state.schedule.days.first) {
                                    case 0:
                                      firstDayString = 'Sunday';
                                      break;
                                    case 1:
                                      firstDayString = 'Monday';
                                      break;
                                    case 2:
                                      firstDayString = 'Tuesday';
                                      break;
                                    case 3:
                                      firstDayString = 'Wednesday';
                                      break;
                                    case 4:
                                      firstDayString = 'Thursday';
                                      break;
                                    case 5:
                                      firstDayString = 'Friday';
                                      break;
                                    case 6:
                                      firstDayString = 'Saturday';
                                      break;
                                  }
                                  switch (state.schedule.days.last) {
                                    case 0:
                                      lastDayString = 'Sunday';
                                      break;
                                    case 1:
                                      lastDayString = 'Monday';
                                      break;
                                    case 2:
                                      lastDayString = 'Tuesday';
                                      break;
                                    case 3:
                                      lastDayString = 'Wednesday';
                                      break;
                                    case 4:
                                      lastDayString = 'Thursday';
                                      break;
                                    case 5:
                                      lastDayString = 'Friday';
                                      break;
                                    case 6:
                                      lastDayString = 'Saturday';
                                      break;
                                  }
                                  return Text(
                                    '$firstDayString to $lastDayString',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                  );
                                }
                                if (state is GetScheduleFailedState) {
                                  return Text(
                                    'Schedule fetch failed: ${state.message}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.red,
                                        ),
                                  );
                                }
                                // Show loading or initial state
                                return const CircularProgressIndicator();
                              },
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
                            BlocBuilder<DoctorScheduleBloc,
                                DoctorScheduleState>(
                              builder: (context, state) {
                                if (state is GetScheduleSuccessState) {
                                  List<Widget> timeSlots = [];
                                  for (int i = 0;
                                      i < state.schedule.startTimes.length;
                                      i++) {
                                    String timeStart =
                                        state.schedule.startTimes[i];
                                    String timeEnd = state.schedule.endTimes[i];
                                    timeSlots
                                        .add(Text('$timeStart - $timeEnd'));
                                  }
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: timeSlots,
                                  );
                                }
                                if (state is GetScheduleFailedState) {
                                  return Text(
                                    'Schedule fetch failed: ${state.message}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.red,
                                        ),
                                  );
                                }
                                // Show loading or initial state
                                return const CircularProgressIndicator();
                              },
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
                                    child: Image.asset(
                                        Images.modeOfAppointmentLogo),
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
                            BlocBuilder<DoctorScheduleBloc,
                                DoctorScheduleState>(
                              builder: (context, state) {
                                if (state is GetScheduleSuccessState) {
                                  final modes =
                                      state.schedule.modeOfAppointment;
                                  if (modes.contains(0) && modes.contains(1)) {
                                    return const Column(
                                      children: [
                                        Text('Online Consultation'),
                                        Text('Face to face Consultation'),
                                      ],
                                    );
                                  } else if (modes.contains(0)) {
                                    return const Text('Online Consultation');
                                  } else if (modes.contains(1)) {
                                    return const Text(
                                        'Face to face Consultation');
                                  } else {
                                    return const Text(
                                        'No Consultation Mode Defined');
                                  }
                                }
                                if (state is GetScheduleFailedState) {
                                  return Text(
                                    'Schedule fetch failed: ${state.message}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.red,
                                        ),
                                  );
                                }
                                // Show loading or initial state
                                return const CircularProgressIndicator();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
          schedule.days.isEmpty ? const Gap(450) : const Gap(80),
          SizedBox(
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
                Navigator.pushNamed(context, '/createDoctorSchedule');
              },
              child: Text(
                'Manage Schedule',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
          const Gap(30),
        ],
      ),
    );
  }
}
