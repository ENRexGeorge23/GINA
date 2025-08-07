import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/doctor_rating_badge/doctor_rating_badge.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/doctor_features/doctorForums/2_views/bloc/doctor_forums_bloc.dart';
import 'package:first_app/features/doctor_features/doctorForums/2_views/widgets/main_detailed_post_container.dart';
import 'package:first_app/features/patient_features/forums/0_models/forum_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:timeago/timeago.dart' as timeago;

class DoctorForumsDetailedPostState extends StatelessWidget {
  final ForumModel forumPost;
  final List<ForumModel> forumReplies;
  final int doctorRatingId;
  const DoctorForumsDetailedPostState({
    super.key,
    required this.forumPost,
    required this.forumReplies,
    required this.doctorRatingId,
  });

  @override
  Widget build(BuildContext context) {
    final forumsBloc = context.read<DoctorForumsBloc>();
    return RefreshIndicator(
      onRefresh: () async {
        forumsBloc.add(GetRepliesDoctorForumsPostRequestedEvent(
          docForumPost: forumPost,
        ));
      },
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainDetailedDoctorPostContainer(
                  forumPost: forumPost,
                  doctorRatingId: doctorRatingId,
                ),
                const Gap(10),
                Text(
                  'Replies (${forumReplies.length})',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                BlocBuilder<DoctorForumsBloc, DoctorForumsState>(
                  builder: (context, state) {
                    if (state is GetRepliesDoctorForumsPostLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is GetRepliesDoctorForumsPostFailedState) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        reverse: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: forumReplies.length,
                        itemBuilder: (context, index) {
                          final reply = forumReplies[index];
                          return Column(
                            children: [
                              const Gap(10),
                              // const DoctorReplyContainer(),
                              // const Gap(10),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0),
                                  child: Column(
                                    children: [
                                      const Gap(10),
                                      reply.isDoctor
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
                                                          reply.doctorRatingId,
                                                      width: 80,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Dr. ${reply.postedBy}",
                                                          style: Theme.of(
                                                                  context)
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
                                                      "Posted ${timeago.format(reply.postedAt.toDate(), locale: 'en')}",
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
                                                      reply.postedBy,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge
                                                          ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                    ),
                                                    Text(
                                                      "Posted ${timeago.format(reply.postedAt.toDate(), locale: 'en')}",
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
                                      const Gap(20),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          reply.description,
                                        ),
                                      ),
                                      const Gap(20),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                ),
                const Gap(10),
                Center(
                    child: FilledButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {
                    forumsBloc.add(NavigateToDoctorForumsReplyPostEvent(
                      docForumPost: forumPost,
                    ));
                  },
                  child: const Text('Add Reply',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      )),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
