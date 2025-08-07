part of 'doctor_forums_bloc.dart';

sealed class DoctorForumsEvent extends Equatable {
  const DoctorForumsEvent();

  @override
  List<Object> get props => [];
}

class DoctorForumsFetchRequestedEvent extends DoctorForumsEvent {}

class CreateDoctorForumsPostEvent extends DoctorForumsEvent {
  final String title;
  final String description;
  final Timestamp postedAt;

  const CreateDoctorForumsPostEvent({
    required this.title,
    required this.description,
    required this.postedAt,
  });
  @override
  List<Object> get props => [title, description, postedAt];
}

class NavigateToDoctorForumsDetailedPostEvent extends DoctorForumsEvent {
  final ForumModel docForumPost;
  final int doctorRatingId;

  const NavigateToDoctorForumsDetailedPostEvent({
    required this.docForumPost,
    required this.doctorRatingId,
  });

  @override
  List<Object> get props => [docForumPost];
}

class NavigateToDoctorForumsCreatePostEvent extends DoctorForumsEvent {}

class NavigateToDoctorForumsReplyPostEvent extends DoctorForumsEvent {
  final ForumModel docForumPost;

  const NavigateToDoctorForumsReplyPostEvent({
    required this.docForumPost,
  });

  @override
  List<Object> get props => [docForumPost];

  get forumPost => null;
}

class CreateReplyDoctorForumsPostEvent extends DoctorForumsEvent {
  final ForumModel docForumPost;
  final String replyContent;
  final Timestamp repliedAt;

  const CreateReplyDoctorForumsPostEvent({
    required this.docForumPost,
    required this.replyContent,
    required this.repliedAt,
  });

  @override
  List<Object> get props => [docForumPost, replyContent, repliedAt];
}

class GetRepliesDoctorForumsPostRequestedEvent extends DoctorForumsEvent {
  final ForumModel docForumPost;

  const GetRepliesDoctorForumsPostRequestedEvent({
    required this.docForumPost,
  });

  @override
  List<Object> get props => [docForumPost];
}