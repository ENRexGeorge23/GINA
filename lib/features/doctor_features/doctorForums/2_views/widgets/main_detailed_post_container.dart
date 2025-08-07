import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/doctor_rating_badge/doctor_rating_badge.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/patient_features/forums/0_models/forum_models.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:timeago/timeago.dart' as timeago;

class MainDetailedDoctorPostContainer extends StatelessWidget {
  final ForumModel forumPost;
  final int doctorRatingId;
  const MainDetailedDoctorPostContainer({
    super.key,
    required this.forumPost,
    required this.doctorRatingId,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                forumPost.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    
              ),
            ),
            const Gap(20),
            forumPost.isDoctor
                ? Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(Images.doctorProfileIcon),
                      ),
                      const Gap(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DoctorRatingBadge(
                            doctorRating: doctorRatingId,
                            width: 80,
                          ),
                          Row(
                            children: [
                              Text(
                                "Dr. ${forumPost.postedBy}",
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
                            "Posted ${timeago.format(forumPost.postedAt.toDate(), locale: 'en')}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: GinaAppTheme.lightOutline),
                          ),
                        ],
                      ),
                    ],
                  )
                : Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(Images.profileIcon),
                      ),
                      const Gap(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            forumPost.postedBy,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Posted ${timeago.format(forumPost.postedAt.toDate(), locale: 'en')}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: GinaAppTheme.lightOutline),
                          ),
                        ],
                      ),
                    ],
                  ),
            const Gap(20),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(forumPost.description)),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
