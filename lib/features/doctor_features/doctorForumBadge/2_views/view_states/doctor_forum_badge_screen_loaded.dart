import 'package:first_app/core/enum/enum.dart';
import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:first_app/features/doctor_features/doctorForumBadge/2_views/widgets/badges_list.dart';
import 'package:first_app/features/doctor_features/doctorForumBadge/2_views/widgets/doctor_forum_badge_card.dart';
//import 'package:first_app/gina_app.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class DoctorForumBadgeScreenLoaded extends StatelessWidget {
  final DoctorModel doctorPost;
  const DoctorForumBadgeScreenLoaded({
    super.key,
    required this.doctorPost,
  });

  @override
  Widget build(BuildContext context) {
    DateTime firstDayOfNextMonth = DateTime.now().add(const Duration(days: 30));
    firstDayOfNextMonth =
        DateTime(firstDayOfNextMonth.year, firstDayOfNextMonth.month, 1);
    String formattedDate =
        DateFormat('MMMM dd, yyyy').format(firstDayOfNextMonth);
    double progress =
        doctorPost.createdPosts != null && doctorPost.repliedPosts != null
            ? doctorPost.createdPosts!.length.toDouble() +
                doctorPost.repliedPosts!.length.toDouble()
            : 0;
    int progressInt =
        doctorPost.createdPosts != null && doctorPost.repliedPosts != null
            ? doctorPost.createdPosts!.length + doctorPost.repliedPosts!.length
            : 0;
    return SingleChildScrollView(
      child: Column(
        children: [
          const Gap(20),
          // 0 == 0
          doctorPost.doctorRatingId == DoctorRating.newDoctor.index
              ? DoctorForumBadgeCard(
                  formattedDate: formattedDate,
                  badgeName: 'New Doctor',
                  backgroundImage: Images.newDoctorForumBadgeBackground,
                  nextBadgeName: 'Contributing\nDoctor',
                  currentBadgeColor: Colors.grey[500],
                  nextBadgeColor: GinaAppTheme.lightTertiary,
                  progress: progressInt,
                  progressValue: progress,
                  nextBadgeQuota: 1,
                )
              : Container(),
          // 2 == 2
          doctorPost.doctorRatingId == DoctorRating.contributingDoctor.index
              ? DoctorForumBadgeCard(
                  formattedDate: formattedDate,
                  badgeName: 'Contributing Doctor',
                  backgroundImage:
                      Images.contributingDoctorForumBadgeBackground,
                  nextBadgeName: 'Active Doctor',
                  currentBadgeColor: GinaAppTheme.lightTertiary,
                  nextBadgeColor: GinaAppTheme.pendingTextColor,
                  progress: progressInt,
                  progressValue: progress,
                  nextBadgeQuota: 10,
                )
              : Container(),
          // 1 == 1
          doctorPost.doctorRatingId == DoctorRating.activeDoctor.index
              ? DoctorForumBadgeCard(
                  formattedDate: formattedDate,
                  badgeName: 'Active Doctor',
                  backgroundImage: Images.activeDoctorForumBadgeBackground,
                  nextBadgeName: 'Top Doctor',
                  currentBadgeColor: GinaAppTheme.pendingTextColor,
                  nextBadgeColor: const Color(0xffD14633),
                  progress: progressInt,
                  progressValue: progress,
                  nextBadgeQuota: 50,
                )
              : Container(),
          // 2 == 2
          doctorPost.doctorRatingId == DoctorRating.topDoctor.index
              ? DoctorForumBadgeCard(
                  formattedDate: formattedDate,
                  badgeName: 'Top Doctor',
                  backgroundImage: Images.topDoctorForumBadgeBackground,
                  nextBadgeName: 'Top Doctor',
                  currentBadgeColor: const Color(0xffD14633),
                  nextBadgeColor: const Color(0xffD14633),
                  progress: progressInt,
                  progressValue: progress,
                  nextBadgeQuota: 0,
                )
              : Container(),

          const Gap(30),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Badges',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BadgesList(
                badgeName: 'Top Doctor',
                badgeDescription:
                    'Earned by making at least 50 forum posts or replies in a month.',
                badgeColor: Color(0xffD14633),
              ),
              BadgesList(
                badgeName: 'Active Doctor',
                badgeDescription:
                    'Earned by making at least 10 forum posts or replies in a month.',
                badgeColor: GinaAppTheme.pendingTextColor,
              ),
              BadgesList(
                badgeName: 'Contributing Doctor',
                badgeDescription:
                    'Earned by joining the forum and making at least 1 post or reply.',
                badgeColor: GinaAppTheme.lightTertiary,
              ),
            ],
          ),
          const Gap(300),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.9,
            child: FilledButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/doctorForumsPost');
              },
              child: const Text(
                'Go to Forums',
                style: TextStyle(
                  color: GinaAppTheme.lightOnSecondary,
                  fontFamily: "SF UI Display",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
