import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/doctor_rating_badge/doctor_rating_badge.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/patient_features/forums/0_models/forum_models.dart';
import 'package:first_app/features/patient_features/forums/2_views/bloc/forums_bloc.dart';
import 'package:first_app/features/patient_features/myForums/2_views/screens/view_states/my_forums_post_empty_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ForumsScreenLoaded extends StatelessWidget {
  final List<ForumModel> forumsPosts;
  final List<int> doctorRatingIds;
  const ForumsScreenLoaded(
      {super.key, required this.forumsPosts, required this.doctorRatingIds});

  @override
  Widget build(BuildContext context) {
    final forumsBloc = context.read<ForumsBloc>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: forumsPosts.isEmpty
          ? const MyForumsEmptyScreenState()
          : RefreshIndicator(
              onRefresh: () async {
                forumsBloc.add(ForumsFetchRequestedEvent());
              },
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: forumsPosts.length,
                itemBuilder: (context, index) {
                  final forumPost = forumsPosts[index];
                  final doctorRatingId = doctorRatingIds[index];
                  return BlocBuilder<ForumsBloc, ForumsState>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          forumsBloc.add(NavigateToForumsDetailedPostEvent(
                            forumPost: forumPost,
                            doctorRatingId: doctorRatingId,
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 15.0),
                              child: Column(
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
                                  const Spacer(),
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
