part of 'doctor_my_forums_bloc.dart';

abstract class DoctorMyForumsState extends Equatable {
  const DoctorMyForumsState();

  @override
  List<Object> get props => [];
}

abstract class DoctorMyForumsActionState extends DoctorMyForumsState {}

class DoctorMyForumsInitial extends DoctorMyForumsState {}

class GetMyForumsPostState extends DoctorMyForumsState {
  final List<ForumModel> myForumPosts;

  const GetMyForumsPostState({required this.myForumPosts});

  @override
  List<Object> get props => [myForumPosts];
}

class GetMyForumsPostErrorState extends DoctorMyForumsState {
  final String error;

  const GetMyForumsPostErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class GetMyForumsPostLoadingState extends DoctorMyForumsState {}

class GetMyForumsPostEmptyState extends DoctorMyForumsState {}
