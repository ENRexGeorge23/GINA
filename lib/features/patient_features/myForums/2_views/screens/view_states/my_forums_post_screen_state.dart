import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/doctor_rating_badge/doctor_rating_badge.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/doctor_features/doctorProfile/2_views/bloc/doctor_profile_bloc.dart';
import 'package:first_app/features/patient_features/forums/0_models/forum_models.dart';
import 'package:first_app/features/patient_features/forums/2_views/bloc/forums_bloc.dart';
import 'package:first_app/features/patient_features/myForums/2_views/bloc/my_forums_bloc.dart';
import 'package:first_app/features/patient_features/myForums/2_views/screens/view_states/my_forums_post_empty_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:timeago/timeago.dart' as timeago;

class MyForumsPostScreenState extends StatelessWidget {
  final List<ForumModel> myForumsPosts;
  const MyForumsPostScreenState({super.key, required this.myForumsPosts});

  @override
  Widget build(BuildContext context) {
    final forumsBloc = context.read<ForumsBloc>();
    final myForumsBloc = context.read<MyForumsBloc>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: myForumsPosts.isEmpty
          ? const MyForumsEmptyScreenState()
          : RefreshIndicator(
              onRefresh: () async {
                myForumsBloc.add(GetMyForumsPostEvent());
              },
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: myForumsPosts.length,
                itemBuilder: (context, index) {
                  final forumPost = myForumsPosts[index];
                  return GestureDetector(
                    onTap: () {
                      forumsBloc.add(NavigateToForumsDetailedPostEvent(
                        forumPost: forumPost,
                        doctorRatingId: forumPost.doctorRatingId,
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
                                              doctorRating:
                                                  profileDoctorRatingId!,
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
                                                              FontWeight.w700),
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
                                          backgroundImage:
                                              AssetImage(Images.profileIcon),
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
                              Text(
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
                              const Gap(10),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Text(
                                  forumPost.description,
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
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
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
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
              ),
            ),
    );
  }
}
