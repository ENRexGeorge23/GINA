import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/patient_features/appointment/2_views/widgets/appointment_status.dart';
import 'package:first_app/features/patient_features/home/2_views/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class ConsultationHistoryContainer extends StatelessWidget {
  const ConsultationHistoryContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/appointment');
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: GinaAppTheme.lightOnTertiary,
            ),
            height: 225,
            width: MediaQuery.of(context).size.width / 1.05,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0, top: 12),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text('Consultation History',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontSize: 20,
                                )),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/appointment');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 14.0, top: 12),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text('See all',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color: GinaAppTheme.lightOutline,
                                  )),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(15),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state
                        is HomeGetPeriodTrackerDataAndConsultationHistorySuccess) {
                      final completedAppointments = state.consultationHistory;

                      return completedAppointments.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: Text(
                                "No History,\n Your consultation history will appear here.",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: GinaAppTheme.lightOutline),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 8),
                                        child: Divider(
                                          color: GinaAppTheme.lightOutline,
                                        ),
                                      ),
                              itemCount: 2,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final completedAppointment =
                                    completedAppointments[index];

                                String appointmentData =
                                    completedAppointment.appointmentDate!;
                                DateTime appointmentDate =
                                    DateFormat('MMMM dd, yyyy')
                                        .parse(appointmentData);
                                String abbreviatedMonth =
                                    DateFormat('MMM').format(appointmentDate);
                                int day = appointmentDate.day;

                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Column(
                                        children: [
                                          Text(abbreviatedMonth,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall
                                                  ?.copyWith(
                                                    fontSize: 22,
                                                  )),
                                          Text(day.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall
                                                  ?.copyWith(
                                                    fontSize: 20,
                                                  )),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Dr. ${completedAppointment.doctorName}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall
                                                ?.copyWith(
                                                  fontSize: 20,
                                                )),
                                        Row(
                                          children: [
                                            Text(
                                                completedAppointment
                                                    .appointmentTime!
                                                    .split(' - ')[0],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    )),
                                            const Gap(5),
                                            Text('•',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium),
                                            const Gap(5),
                                            Text(
                                                completedAppointment
                                                            .modeOfAppointment ==
                                                        1
                                                    ? 'Online'
                                                    : 'F2F',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: GinaAppTheme
                                                            .lightTertiaryContainer)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    AppointmentStatusContainer(
                                      appointmentStatus: completedAppointment
                                          .appointmentStatus,
                                    ),
                                  ],
                                );
                              });
                    } else if (state
                        is HomeGetPeriodTrackerDataAndConsultationHistoryLoadingState) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 40.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
