import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:first_app/features/patient_features/forums/0_models/forum_models.dart';
import 'package:first_app/features/patient_features/myForums/1_controllers/my_forums_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_forums_event.dart';
part 'my_forums_state.dart';

class MyForumsBloc extends Bloc<MyForumsEvent, MyForumsState> {
  final MyForumsController myForumsController;
  MyForumsBloc({
    required this.myForumsController,
  }) : super(MyForumsInitial()) {
    on<GetMyForumsPostEvent>(getMyForumsPostEvent);
  }

  FutureOr<void> getMyForumsPostEvent(
      GetMyForumsPostEvent event, Emitter<MyForumsState> emit) async {
    emit(MyForumsLoadingState());

    final getMyForumsPost = await myForumsController.getListOfMyForumsPost();

    getMyForumsPost.fold(
      (failure) => emit(MyForumsErrorState(message: failure.toString())),
      (myForumsPost) => emit(MyForumsLoadedState(myForumsPosts: myForumsPost)),
    );
  }
}
