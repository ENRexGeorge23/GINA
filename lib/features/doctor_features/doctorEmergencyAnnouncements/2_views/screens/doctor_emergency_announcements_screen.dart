import 'package:first_app/core/reusable_widgets/doctor_reusable_widgets/gina_doctor_app_bar.dart';
import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/doctor_features/doctorEmergencyAnnouncements/2_views/bloc/doctor_emergency_announcements_bloc.dart';
import 'package:first_app/features/doctor_features/doctorEmergencyAnnouncements/2_views/screens/view_states/doctor_emergency_announcement_create_announcement.dart';
import 'package:first_app/features/doctor_features/doctorEmergencyAnnouncements/2_views/screens/view_states/doctor_emergency_announcement_initial.dart';
import 'package:first_app/features/doctor_features/doctorEmergencyAnnouncements/2_views/screens/view_states/doctor_emergency_announcement_loaded_details_screen.dart';
import 'package:first_app/features/doctor_features/doctorEmergencyAnnouncements/2_views/screens/view_states/doctor_emergency_announcement_patient_list.dart';
import 'package:first_app/features/doctor_features/doctorEmergencyAnnouncements/2_views/screens/view_states/doctor_emergency_announcements_loaded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorEmergencyAnnouncementsScreenProvider extends StatelessWidget {
  const DoctorEmergencyAnnouncementsScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DoctorEmergencyAnnouncementsBloc>(
      create: (context) {
        final doctorEmergencyAnnouncementsBloc =
            sl<DoctorEmergencyAnnouncementsBloc>();

        doctorEmergencyAnnouncementsBloc
            .add(GetDoctorEmergencyAnnouncementsEvent());

        return doctorEmergencyAnnouncementsBloc;
      },
      child: const DoctorEmergencyAnnouncementsScreen(),
    );
  }
}

class DoctorEmergencyAnnouncementsScreen extends StatelessWidget {
  const DoctorEmergencyAnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final doctorEmergencyAnnouncementsBloc =
        context.read<DoctorEmergencyAnnouncementsBloc>();
    return BlocBuilder<DoctorEmergencyAnnouncementsBloc,
        DoctorEmergencyAnnouncementsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: GinaDoctorAppBar(
              leading: state is DoctorEmergencyGetApprovedPatientList
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        doctorEmergencyAnnouncementsBloc.add(
                            NavigateToDoctorEmergencyCreateAnnouncementEvent());
                      },
                    )
                  : state is CreateAnnouncementState ||
                          state is NavigateToDoctorCreatedAnnouncementState
                      ? IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            doctorEmergencyAnnouncementsBloc
                                .add(GetDoctorEmergencyAnnouncementsEvent());
                          },
                        )
                      : null,
              title: state is DoctorEmergencyGetApprovedPatientList
                  ? 'Select a patient'
                  : 'Emergency announcements'),
          floatingActionButton: state is DoctorEmergencyAnnouncementsLoaded ||
                  state is DoctorEmergencyAnnouncementsInitial ||
                  state is DoctorEmergencyAnnouncementsLoaded
              ? FloatingActionButton(
                  onPressed: () {
                    doctorEmergencyAnnouncementsBloc.add(
                        NavigateToDoctorEmergencyCreateAnnouncementEvent());
                  },
                  child: const Icon(Icons.add),
                )
              : null,
          body: BlocConsumer<DoctorEmergencyAnnouncementsBloc,
              DoctorEmergencyAnnouncementsState>(
            listenWhen: (previous, current) =>
                current is DoctorEmergencyAnnouncementsActionState,
            buildWhen: (previous, current) =>
                current is! DoctorEmergencyAnnouncementsActionState,
            listener: (context, state) {
              if (state is DoctorEmergencyAnnouncementsError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is DoctorEmergencyAnnouncementsInitial) {
                return const DoctorEmergencyAnnouncementInitialScreen();
              } else if (state is DoctorEmergencyAnnouncementsLoaded) {
                return DoctorEmergencyAnnouncementsLoadedScreen(
                    emergencyAnnouncements: state.emergencyAnnouncements);
              } else if (state is DoctorEmergencyAnnouncementsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is DoctorEmergencyAnnouncementsError) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is CreateAnnouncementState) {
                return DoctorEmergencyAnnouncementsCreateAnnouncementScreen();
              } else if (state is DoctorEmergencyAnnouncementsEmpty) {
                return const Center(
                  child: Text('No emergency announcements'),
                );
              } else if (state is DoctorEmergencyGetApprovedPatientList) {
                return DoctorEmergencyPatientList(
                    approvedPatients: state.approvedPatientList);
              } else if (state is SelectedAPatientState) {
                return DoctorEmergencyAnnouncementsCreateAnnouncementScreen();
              } else if (state is NavigateToDoctorCreatedAnnouncementState) {
                return DoctorEmergencyAnnouncementsLoadedDetailsScreen(
                    emergencyAnnouncement: state.emergencyAnnouncement);
              }
              return const SizedBox();
            },
          ),
        );
      },
    );
  }
}
