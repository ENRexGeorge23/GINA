import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/doctor_features/doctorEmergencyAnnouncements/0_model/emergency_announcements_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class DoctorEmergencyAnnouncementsLoadedDetailsScreen extends StatelessWidget {
  final EmergencyAnnouncementModel emergencyAnnouncement;
  const DoctorEmergencyAnnouncementsLoadedDetailsScreen(
      {super.key, required this.emergencyAnnouncement});

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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: GinaAppTheme.appbarColorLight,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
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
                      SizedBox(
                        width: 200,
                        child: Text(
                          emergencyAnnouncement
                              .patientName, // replace with your data
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),

                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
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
              const Gap(15),
              Text(
                emergencyAnnouncement.message,
                style: Theme.of(context).textTheme.labelMedium,
                maxLines: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
