import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/doctor_features/homeDashboard/2_views/widgets/home_dashboard_calendar_tracker_container.dart';
import 'package:first_app/features/doctor_features/homeDashboard/2_views/widgets/pending_requests_navigation.dart';
import 'package:first_app/features/doctor_features/homeDashboard/2_views/widgets/upcoming_appointment_navigation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeDashboardScreenLoaded extends StatelessWidget {
  final int pendingRequests;
  final int confirmedAppointments;
  const HomeDashboardScreenLoaded(
      {super.key,
      required this.pendingRequests,
      required this.confirmedAppointments});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Gap(20),
            const HomeDashboardCalendarTrackerContainer(),
            const Gap(20),
            Text('Navigation Hub',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    )),
            const Gap(10),

            // TODO
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, '/doctorUpcomingAppointments');
                      },
                      child: Container(
                        width: width * 0.45,
                        height: height * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: UpcomingAppointmentsWidget(
                          confirmedAppointments: confirmedAppointments,
                        ),
                      ),
                    ),
                    const Gap(15),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, '/doctorEmergencyAnnouncements');
                      },
                      child: Container(
                        width: width * 0.45,
                        height: height * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: GinaAppTheme.lightSecondaryContainer,
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  Images.emergencyAnnouncement,
                                  width: width * 0.35,
                                  height: height * 0.15,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'Emergency\nAnnouncement',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: GinaAppTheme.lightOnPrimaryColor,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/doctorRequest');
                      },
                      child: Container(
                        width: width * 0.45,
                        height: height * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: GinaAppTheme.lightSecondaryContainer,
                        ),
                        child: PendingRequestsWidget(
                          pendingRequests: pendingRequests,
                        ),
                      ),
                    ),
                    const Gap(15),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/doctorSchedule');
                      },
                      child: Container(
                        width: width * 0.45,
                        height: height * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            const Gap(20),
                            Image.asset(
                              Images.scheduleManagement,
                              width: width / 3,
                              height: height / 5.5,
                              fit: BoxFit.fill,
                            ),
                            const Gap(25),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Schedule\nManagement',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: GinaAppTheme.lightOnPrimaryColor,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
