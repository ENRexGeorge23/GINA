import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/doctor_rating_badge/doctor_rating_badge.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/doctor_features/doctorForums/2_views/bloc/doctor_forums_bloc.dart';
import 'package:first_app/features/patient_features/forums/0_models/forum_models.dart';
import 'package:first_app/features/patient_features/myForums/2_views/screens/view_states/my_forums_post_empty_screen_state.dart';

import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DoctorForumsScreenLoaded extends StatelessWidget {
  final List<ForumModel> docForumsPosts;
  final List<int> doctorRatingIds;
  const DoctorForumsScreenLoaded(
      {super.key, required this.docForumsPosts, required this.doctorRatingIds});

  @override
  Widget build(BuildContext context) {
    final forumsBloc = context.read<DoctorForumsBloc>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: docForumsPosts.isEmpty
          ? const MyForumsEmptyScreenState()
          : RefreshIndicator(
              onRefresh: () async {
                forumsBloc.add(DoctorForumsFetchRequestedEvent());
              },
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: docForumsPosts.length,
                itemBuilder: (context, index) {
                  final forumPost = docForumsPosts[index];
                  final doctorRatingId = doctorRatingIds[index];
                  return BlocBuilder<DoctorForumsBloc, DoctorForumsState>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          forumsBloc
                              .add(NavigateToDoctorForumsDetailedPostEvent(
                            docForumPost: forumPost,
                            doctorRatingId: doctorRatingId,
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 15.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Gap(10),
                                  forumPost.isDoctor
                                      ? Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 20,
                                              backgroundImage: AssetImage(
                                                  Images.doctorProfileIcon),
                                            ),
                                            const Gap(10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                DoctorRatingBadge(
                                                  doctorRating: doctorRatingId,
                                                  width: 100,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Dr. ${forumPost.postedBy}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge
                                                          ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
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
                                                      ?.copyWith(
                                                          color: GinaAppTheme
                                                              .lightOutline),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 20,
                                              backgroundImage: AssetImage(
                                                  Images.profileIcon),
                                            ),
                                            const Gap(10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  forumPost.postedBy,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w700),
                                                ),
                                                Text(
                                                  "Posted ${timeago.format(forumPost.postedAt.toDate(), locale: 'en')}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                          color: GinaAppTheme
                                                              .lightOutline),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                  const Gap(10),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      forumPost.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    ),
                                  ),
                                  const Gap(10),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: Text(
                                      forumPost.description,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  const Gap(10),
                                  Row(
                                    children: [
                                      const Gap(4),
                                      Image.asset(
                                        Images.forumComment,
                                      ),
                                      const Gap(5),
                                      Text(
                                        forumPost.replies.length == 1
                                            ? "${forumPost.replies.length.toString()} reply"
                                            : "${forumPost.replies.length.toString()} replies",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  ),
                                  const Gap(15),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}
