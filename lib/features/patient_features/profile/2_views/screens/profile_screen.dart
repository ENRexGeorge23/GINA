import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/gina_patient_app_bar/gina_patient_app_bar.dart';
import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/patient_features/profile/2_views/bloc/profile_bloc.dart';
import 'package:first_app/features/patient_features/profile/2_views/screens/view_states/edit_profile_screen.dart';
import 'package:first_app/features/patient_features/profile/2_views/screens/view_states/profile_screen_loaded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreenProvider extends StatelessWidget {
  const ProfileScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) {
        final profileBloc = sl<ProfileBloc>();
        profileBloc.add(GetProfileEvent());
        return profileBloc;
      },
      child: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileBloc = context.read<ProfileBloc>();
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: GinaPatientAppBar(
            title: state is NavigateToEditProfileState
                ? 'Edit Profile'
                : 'Profile',
          ),
          body: BlocConsumer<ProfileBloc, ProfileState>(
            listenWhen: (previous, current) => current is ProfileActionState,
            buildWhen: (previous, current) => current is! ProfileActionState,
            listener: (context, state) {
              if (state is ProfileNavigateToCycleHistoryState) {
                Navigator.pushNamed(context, '/cycleHistory')
                    .then((value) => profileBloc.add(GetProfileEvent()));
              } else if (state is ProfileNavigateToMyForumsPostState) {
                Navigator.pushNamed(context, '/myForumsPost')
                    .then((value) => profileBloc.add(GetProfileEvent()));
              }
            },
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProfileLoaded) {
                final patientData = state.patientData;
                return ProfileScreenLoaded(
                  patientData: patientData,
                );
              } else if (state is NavigateToEditProfileState) {
                final patientData = state.patientData;
                return EditProfileScreen(
                  patientData: patientData,
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
