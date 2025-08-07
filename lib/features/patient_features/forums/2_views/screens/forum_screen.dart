import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/gina_patient_app_bar/gina_patient_app_bar.dart';
import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/patient_features/forums/2_views/bloc/forums_bloc.dart';
import 'package:first_app/features/patient_features/forums/2_views/screens/view_states/forums_details_post_state.dart';
import 'package:first_app/features/patient_features/forums/2_views/screens/view_states/forums_screen_loaded.dart';
import 'package:first_app/features/patient_features/forums/2_views/screens/view_states/reply_post_screen_state.dart';
import 'package:first_app/features/patient_features/forums/2_views/widgets/posted_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForumScreenProvider extends StatelessWidget {
  const ForumScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForumsBloc>(
      create: (context) {
        final forumsBloc = sl<ForumsBloc>();
        forumsBloc.add(ForumsFetchRequestedEvent());
        return forumsBloc;
      },
      child: const ForumScreen(),
    );
  }
}

class ForumScreen extends StatelessWidget {
  const ForumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final forumsBloc = context.read<ForumsBloc>();
    return BlocBuilder<ForumsBloc, ForumsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: GinaPatientAppBar(
              leading: state is NavigateToForumsDetailedPostState ||
                      state is GetRepliesForumsPostSuccessState
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        forumsBloc.add(ForumsFetchRequestedEvent());
                      })
                  : state is NavigateToForumsReplyPostState
                      ? IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            forumsBloc.add(NavigateToForumsDetailedPostEvent(
                              forumPost: state.forumPost,
                              doctorRatingId: state.forumPost.doctorRatingId,
                            ));
                          })
                      : null,
              title:
                  state is NavigateToForumsReplyPostState ? "Reply" : 'Forums'),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              forumsBloc.add(NavigateToForumsCreatePostEvent());
            },
            child: const Icon(Icons.add),
          ),
          body: BlocConsumer<ForumsBloc, ForumsState>(
            listenWhen: (previous, current) => current is ForumsActionState,
            buildWhen: (previous, current) => current is! ForumsActionState,
            listener: (context, state) {
              if (state is NavigateToForumsCreatePostState) {
                Navigator.pushNamed(context, '/forumsCreatePost').then(
                    (value) => forumsBloc.add(ForumsFetchRequestedEvent()));
              } else if (state is NavigateToForumsReplyPostState) {
                Navigator.pushNamed(context, '/forumsReplyPost').then(
                    (value) => forumsBloc.add(ForumsFetchRequestedEvent()));
              } else if (state is CreateReplyForumsPostSuccessState) {
                postedConfirmationDialog(context, 'Reply posted');
              }
            },
            builder: (context, state) {
              if (state is GetForumsPostsSuccessState) {
                final doctorRatingIds = state.doctorRatingIds;
                final forumPosts = state.forumsPosts;
                return ForumsScreenLoaded(
                  forumsPosts: forumPosts,
                  doctorRatingIds: doctorRatingIds,
                );
              } else if (state is GetForumsPostEmpytState) {
                return const Center(
                  child: Text('No Forum Posts'),
                );
              } else if (state is GetForumsPostsLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetForumsPostsFailedState) {
                return Center(child: Text(state.message));
              } else if (state is NavigateToForumsDetailedPostState) {
                final forumPost = state.forumPost;
                final forumReplies = state.forumReplies;
                return ForumsDetailedPostState(
                  forumPost: forumPost,
                  forumReplies: forumReplies,
                  doctorRatingId: state.doctorRatingId,
                );
              } else if (state is NavigateToForumsReplyPostState) {
                final forumPost = state.forumPost;
                return ReplyPostScreenState(
                  forumPost: forumPost,
                );
              } else if (state is GetRepliesForumsPostSuccessState) {
                final forumReplies = state.forumReplies;
                return ForumsDetailedPostState(
                  forumPost: state.forumPost,
                  forumReplies: forumReplies,
                  doctorRatingId: state.doctorRatingId,
                );
              }

              return const SizedBox();
            },
          ),
        );
      },
    );
  }
}
