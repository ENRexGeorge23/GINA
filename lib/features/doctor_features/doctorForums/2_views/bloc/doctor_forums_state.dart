part of 'doctor_forums_bloc.dart';

abstract class DoctorForumsState extends Equatable {
  const DoctorForumsState();

  @override
  List<Object> get props => [];
}

abstract class DoctorForumsActionState extends DoctorForumsState {}

class DoctorForumsInitial extends DoctorForumsState {}

class GetDoctorForumsPostsSuccessState extends DoctorForumsState {
  final List<ForumModel> forumsPosts;
  final List<int> doctorRatingIds;

  const GetDoctorForumsPostsSuccessState(
      {required this.forumsPosts, required this.doctorRatingIds});

  @override
  List<Object> get props => [forumsPosts, doctorRatingIds];
}

class GetDoctorForumsPostsFailedState extends DoctorForumsState {
  final String message;

  const GetDoctorForumsPostsFailedState({required this.message});

  @override
  List<Object> get props => [message];
}

class GetDoctorForumsPostsLoadingState extends DoctorForumsState {}

class GetDoctorForumsPostEmpytState extends DoctorForumsState {}

class NavigateToDoctorForumsDetailedPostState extends DoctorForumsState {
  final ForumModel docForumPost;
  final List<ForumModel> forumReplies;
  final int doctorRatingId;

  const NavigateToDoctorForumsDetailedPostState(
      {required this.docForumPost,
      required this.forumReplies,
      required this.doctorRatingId});

  @override
  List<Object> get props => [docForumPost, forumReplies, doctorRatingId];
}

class NavigateToDoctorForumsCreatePostState extends DoctorForumsActionState {}

class NavigateToDoctorForumsReplyPostState extends DoctorForumsState {
  final ForumModel docForumPost;

  const NavigateToDoctorForumsReplyPostState({required this.docForumPost});

  @override
  List<Object> get props => [
        docForumPost,
      ];
}

class CreateDoctorForumsPostSuccessState extends DoctorForumsActionState {}

class CreateDoctorForumsPostFailedState extends DoctorForumsActionState {}

class CreateDoctorForumsPostLoadingState extends DoctorForumsActionState {}

class CreateReplyDoctorForumsPostSuccessState extends DoctorForumsActionState {}

class CreateReplyDoctorForumsPostFailedState extends DoctorForumsActionState {}

class CreateReplyDoctorForumsPostLoadingState extends DoctorForumsActionState {}

class GetRepliesDoctoForumsPostSuccessState extends ForumsState {
  final ForumModel forumPost;
  final List<ForumModel> forumReplies;
  final int doctorRatingId;

  const GetRepliesDoctoForumsPostSuccessState(
      {required this.forumReplies,
      required this.forumPost,
      required this.doctorRatingId});

  @override
  List<Object> get props => [forumReplies, forumPost];
}

class GetRepliesDoctorForumsPostLoadingState extends DoctorForumsState {}

class GetRepliesDoctorForumsPostFailedState extends DoctorForumsState {
  final String message;

  const GetRepliesDoctorForumsPostFailedState({required this.message});

  @override
  List<Object> get props => [message];
}

class GetRepliesDoctorForumsPostEmpytState extends DoctorForumsState {}

class GetRepliesDoctorForumsPostSuccessState extends DoctorForumsState {
  final ForumModel forumPost;
  final List<ForumModel> forumReplies;
  final int doctorRatingId;

  const GetRepliesDoctorForumsPostSuccessState(
      {required this.forumReplies,
      required this.forumPost,
      required this.doctorRatingId});

  @override
  List<Object> get props => [forumReplies, forumPost];
}
