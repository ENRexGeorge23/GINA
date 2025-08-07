import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/doctor_features/doctorEmergencyAnnouncements/0_model/emergency_announcements_model.dart';
import 'package:first_app/features/doctor_features/doctorEmergencyAnnouncements/2_views/bloc/doctor_emergency_announcements_bloc.dart';
import 'package:first_app/features/doctor_features/doctorEmergencyAnnouncements/2_views/screens/view_states/doctor_emergency_announcement_initial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class DoctorEmergencyAnnouncementsLoadedScreen extends StatelessWidget {
  final List<EmergencyAnnouncementModel> emergencyAnnouncements;
  const DoctorEmergencyAnnouncementsLoadedScreen(
      {super.key, required this.emergencyAnnouncements});

  @override
  Widget build(BuildContext context) {
    final doctorEmergencyAnnouncementBloc =
        context.read<DoctorEmergencyAnnouncementsBloc>();
    return emergencyAnnouncements.isEmpty
        ? const DoctorEmergencyAnnouncementInitialScreen()
        : Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: ListView.builder(
              itemCount: emergencyAnnouncements
                  .length, // replace with your list length
              itemBuilder: (context, index) {
                final emergencyAnnouncement = emergencyAnnouncements[index];
                DateTime now = DateTime.now();
                DateTime createdAt = emergencyAnnouncement.createadAt.toDate();
                String time;
                if (now.difference(createdAt).inHours < 24) {
                  time = DateFormat.jm().format(createdAt);
                } else if (now.difference(createdAt).inDays == 1) {
                  time = 'Yesterday';
                } else if (now.difference(createdAt).inDays <= 7) {
                  time = DateFormat('EEEE').format(createdAt);
                } else {
                  time = DateFormat.yMd().format(createdAt);
                }
                return GestureDetector(
                  onTap: () {
                    doctorEmergencyAnnouncementBloc.add(
                      NavigateToDoctorCreatedAnnouncementEvent(
                        emergencyAnnouncement: emergencyAnnouncement,
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: GinaAppTheme.appbarColorLight,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 23.0,
                                          backgroundImage: AssetImage(
                                            Images.profileIcon,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Gap(10),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 200,
                                              child: Text(
                                                emergencyAnnouncement
                                                    .patientName, // replace with your data
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),

                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 200,
                                              child: Text(
                                                emergencyAnnouncement
                                                    .message, // replace with your data
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium,

                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Gap(20),
                                    Text(
                                      time,
                                      style: const TextStyle(
                                        color: GinaAppTheme.cancelledTextColor,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "SF UI Display",
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
