import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/gina_patient_app_bar/gina_patient_app_bar.dart';
import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/patient_features/myForums/2_views/bloc/my_forums_bloc.dart';
import 'package:first_app/features/patient_features/myForums/2_views/screens/view_states/my_forums_post_empty_screen_state.dart';
import 'package:first_app/features/patient_features/myForums/2_views/screens/view_states/my_forums_post_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyForumsScreenProvider extends StatelessWidget {
  const MyForumsScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyForumsBloc>(
      create: (context) {
        final myForumsBloc = sl<MyForumsBloc>();

        myForumsBloc.add(GetMyForumsPostEvent());

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
        appBar: GinaPatientAppBar(title: 'My Forum Posts'),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/forumsCreatePost').then((value) {
              context.read<MyForumsBloc>().add(GetMyForumsPostEvent());
            });
          },
          child: const Icon(Icons.add),
        ),
        body: BlocConsumer<MyForumsBloc, MyForumsState>(
            listenWhen: (previous, current) => current is MyForumsActionState,
            buildWhen: (previous, current) => current is! MyForumsActionState,
            listener: (context, state) {},
            builder: (context, state) {
              if (state is MyForumsLoadedState) {
                final myForumsPosts = state.myForumsPosts;
                return MyForumsPostScreenState(
                  myForumsPosts: myForumsPosts,
                );
              } else if (state is MyForumsEmptyState) {
                return const MyForumsEmptyScreenState();
              } else if (state is MyForumsErrorState) {
                final errorMessage = state.message;
                return Center(
                  child: Text(
                    errorMessage,
                  ),
                );
              } else if (state is MyForumsLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return const SizedBox();
            }));
  }
}
