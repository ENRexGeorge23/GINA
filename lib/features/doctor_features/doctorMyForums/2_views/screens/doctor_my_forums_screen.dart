import 'package:first_app/core/reusable_widgets/doctor_reusable_widgets/gina_doctor_app_bar.dart';
import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/doctor_features/doctorMyForums/2_views/bloc/doctor_my_forums_bloc.dart';
import 'package:first_app/features/patient_features/myForums/2_views/screens/view_states/my_forums_post_empty_screen_state.dart';
import 'package:first_app/features/patient_features/myForums/2_views/screens/view_states/my_forums_post_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorMyForumsScreenProvider extends StatelessWidget {
  const DoctorMyForumsScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DoctorMyForumsBloc>(
      create: (context) {
        final myForumsBloc = sl<DoctorMyForumsBloc>();

        myForumsBloc.add(GetMyDoctorForumsPostEvent());

        return myForumsBloc;
      },
      child: const MyForumsScreen(),
    );
  }
}

class MyForumsScreen extends StatelessWidget {
  const MyForumsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GinaDoctorAppBar(title: 'My Forum Posts'),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/doctorForumsCreatePost')
                .then((value) => context.read<DoctorMyForumsBloc>().add(
                      GetMyDoctorForumsPostEvent(),
                    ));
          },
          child: const Icon(Icons.add),
        ),
        body: BlocConsumer<DoctorMyForumsBloc, DoctorMyForumsState>(
            listenWhen: (previous, current) =>
                current is DoctorMyForumsActionState,
            buildWhen: (previous, current) =>
                current is! DoctorMyForumsActionState,
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetMyForumsPostState) {
                final myForumsPosts = state.myForumPosts;
                return MyForumsPostScreenState(
                  myForumsPosts: myForumsPosts,
                );
              } else if (state is GetMyForumsPostEmptyState) {
                return const MyForumsEmptyScreenState();
              } else if (state is GetMyForumsPostErrorState) {
                final errorMessage = state.error;
                return Center(
                  child: Text(
                    errorMessage,
                  ),
                );
              } else if (state is GetMyForumsPostLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return const SizedBox();
            }));
  }
}
