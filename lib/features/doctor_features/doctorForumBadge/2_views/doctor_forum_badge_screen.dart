import 'package:first_app/core/reusable_widgets/doctor_reusable_widgets/gina_doctor_app_bar.dart';
import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/doctor_features/doctorForumBadge/2_views/bloc/doctor_forum_badge_bloc.dart';
import 'package:first_app/features/doctor_features/doctorForumBadge/2_views/view_states/doctor_forum_badge_screen_loaded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorForumBadgeScreenProvider extends StatelessWidget {
  const DoctorForumBadgeScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DoctorForumBadgeBloc>(
      create: (context) {
        final profileBloc = sl<DoctorForumBadgeBloc>();
        profileBloc.add(GetForumBadgeEvent());
        return profileBloc;
      },
      child: const DoctorForumBadgeScreen(),
    );
  }
}

class DoctorForumBadgeScreen extends StatelessWidget {
  const DoctorForumBadgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorForumBadgeBloc, DoctorForumBadgeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: GinaDoctorAppBar(
            title: "Forum badge",
          ),
          body: BlocConsumer<DoctorForumBadgeBloc, DoctorForumBadgeState>(
            listenWhen: (previous, current) =>
                current is DoctorForumBadgeActionState,
            buildWhen: (previous, current) =>
                current is! DoctorForumBadgeActionState,
            listener: (context, state) {},
            builder: (context, state) {
              if (state is DoctorForumBadgeLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DoctorForumBadgeScuccessState) {
                final doctorPosts = state.doctorPost;
                return DoctorForumBadgeScreenLoaded(
                  doctorPost: doctorPosts,
                );
              } else if (state is DoctorForumBadgeFailedState) {
                return Center(child: Text(state.message));
              }
              return const SizedBox();
            },
          ),
        );
      },
    );
  }
}
