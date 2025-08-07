import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:first_app/features/patient_features/forums/0_models/forum_models.dart';
import 'package:first_app/features/patient_features/forums/1_controllers/forums_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forums_event.dart';
part 'forums_state.dart';

int? doctorRatingStatus;
String? currentPosterUid;
List<int> listDoctorRatingIds = [];

class ForumsBloc extends Bloc<ForumsEvent, ForumsState> {
  final ForumsController forumsController;
  ForumsBloc({required this.forumsController}) : super(ForumsInitial()) {
    on<ForumsFetchRequestedEvent>(forumsFetchRequestedEvent);
    on<CreateForumsPostEvent>(createForumsPostEvent);
    on<CreateReplyForumsPostEvent>(createReplyForumsPostEvent);
    on<NavigateToForumsDetailedPostEvent>(navigateToForumsDetailedPostEvent);
    on<NavigateToForumsCreatePostEvent>(navigateToForumsCreatePostEvent);
    on<NavigateToForumsReplyPostEvent>(navigateToForumsReplyPostEvent);
    on<GetRepliesForumsPostEvent>(getRepliesForumsPostEvent);
  }

  FutureOr<void> forumsFetchRequestedEvent(
      ForumsFetchRequestedEvent event, Emitter<ForumsState> emit) async {
    emit(GetForumsPostsLoadingState());

    final getDoctorRatingIds = await forumsController.getDoctorRatingIds();
    getDoctorRatingIds.fold((failure) {}, (doctorRatingIds) {
      listDoctorRatingIds = doctorRatingIds;
    });

    final result = await forumsController.getForumsPosts();
    result.fold((failure) {
      emit(GetForumsPostsFailedState(message: failure.toString()));
    }, (forumsPosts) {
      if (forumsPosts.isEmpty) {
        emit(GetForumsPostEmpytState());
      }
      emit(GetForumsPostsSuccessState(
          forumsPosts: forumsPosts, doctorRatingIds: listDoctorRatingIds));
    });
  }

  FutureOr<void> createForumsPostEvent(
      CreateForumsPostEvent event, Emitter<ForumsState> emit) async {
    emit(CreateForumsPostLoadingState());

    final result = await forumsController.createForumPost(
      title: event.title,
      content: event.description,
      postedAt: event.postedAt,
    );
    result.fold((failure) {
      emit(CreateForumsPostFailedState());
    }, (success) {
      emit(CreateForumsPostSuccessState());
    });
  }

  FutureOr<void> createReplyForumsPostEvent(
      CreateReplyForumsPostEvent event, Emitter<ForumsState> emit) async {
    emit(CreateForumsPostLoadingState());
    int? doctorRatingIdForCreate;
    final result = await forumsController.addReplyToPost(
      forumPost: event.forumPost,
      replyContent: event.replyContent,
      repliedAt: event.repliedAt,
    );

    final getDoctorRatingId = await forumsController.getDoctorRating(
      doctorUid: event.forumPost.posterUid,
    );

    getDoctorRatingId.fold((failure) {}, (doctorRatingId) {
      doctorRatingIdForCreate = doctorRatingId;
    });

    final repliesPost = await forumsController.getRepliesPost(
      postId: event.forumPost.postId,
    );

    result.fold((failure) {
      emit(CreateForumsPostFailedState());
    }, (success) {
      emit(CreateReplyForumsPostSuccessState());
      if (repliesPost.isRight()) {
        emit(GetRepliesForumsPostSuccessState(
            forumPost: event.forumPost,
            forumReplies: repliesPost.getOrElse(() => []),
            doctorRatingId: doctorRatingIdForCreate ?? 0));
      }
    });
  }

  FutureOr<void> navigateToForumsDetailedPostEvent(
      NavigateToForumsDetailedPostEvent event,
      Emitter<ForumsState> emit) async {
    final forumPost = event.forumPost;

    final repliesPost = await forumsController.getRepliesPost(
      postId: forumPost.postId,
    );

    repliesPost.fold((failure) {
      emit(GetForumsPostsFailedState(message: failure.toString()));
    }, (replies) {
      emit(NavigateToForumsDetailedPostState(
        forumPost: forumPost,
        forumReplies: replies,
        doctorRatingId: event.doctorRatingId,
      ));
    });
  }

  FutureOr<void> navigateToForumsCreatePostEvent(
      NavigateToForumsCreatePostEvent event, Emitter<ForumsState> emit) {
    emit(NavigateToForumsCreatePostState());
  }

  FutureOr<void> navigateToForumsReplyPostEvent(
      NavigateToForumsReplyPostEvent event, Emitter<ForumsState> emit) {
    emit(NavigateToForumsReplyPostState(
      forumPost: event.forumPost,
    ));
  }

  FutureOr<void> getRepliesForumsPostEvent(
      GetRepliesForumsPostEvent event, Emitter<ForumsState> emit) async {
    emit(GetForumsPostsLoadingState());
    int? doctorRatingId;

    final forumPostID = event.forumPost.postId;
    final getDoctorRatingId = await forumsController.getDoctorRating(
      doctorUid: event.forumPost.posterUid,
    );

    getDoctorRatingId.fold((failure) {}, (doctorRatingId) {
      doctorRatingId = doctorRatingId;
    });

    final repliesPost = await forumsController.getRepliesPost(
      postId: forumPostID,
    );

    repliesPost.fold((failure) {
      emit(GetForumsPostsFailedState(message: failure.toString()));
    }, (replies) {
      emit(GetRepliesForumsPostSuccessState(
          forumPost: event.forumPost,
          forumReplies: replies,
          doctorRatingId: doctorRatingId ?? 0));
    });
  }
}
