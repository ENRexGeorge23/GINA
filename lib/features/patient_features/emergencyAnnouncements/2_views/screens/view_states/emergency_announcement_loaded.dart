import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/doctor_features/doctorEmergencyAnnouncements/0_model/emergency_announcements_model.dart';
import 'package:first_app/features/patient_features/emergencyAnnouncements/2_views/screens/view_states/emergency_announcement_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class EmergencyAnnouncementScreenLoaded extends StatelessWidget {
  final EmergencyAnnouncementModel emergencyAnnouncement;
  final String doctorMedicalSpeciality;
  const EmergencyAnnouncementScreenLoaded(
      {super.key,
      required this.emergencyAnnouncement,
      required this.doctorMedicalSpeciality});

  @override
  Widget build(BuildContext context) {
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
    return emergencyAnnouncement.appointmentUid == ''
        ? const EmergencyAnnouncementEmptyState()
        : Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(Images.doctorProfileIcon),
                        ),
                        const Gap(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Dr. ${emergencyAnnouncement.createdBy}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                const Gap(5),
                                const Icon(
                                  Icons.verified,
                                  color: Colors.blue,
                                  size: 15,
                                ),
                              ],
                            ),
                            Text(
                              doctorMedicalSpeciality,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: GinaAppTheme.lightOutline),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          time,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: GinaAppTheme.lightOutline),
                        ),
                      ],
                    ),
                    const Gap(20),
                    Text(
                      emergencyAnnouncement.message,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
