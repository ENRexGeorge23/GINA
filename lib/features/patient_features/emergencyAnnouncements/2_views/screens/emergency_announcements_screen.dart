import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/gina_patient_app_bar/gina_patient_app_bar.dart';
import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/patient_features/emergencyAnnouncements/2_views/bloc/emergency_announcements_bloc.dart';
import 'package:first_app/features/patient_features/emergencyAnnouncements/2_views/screens/view_states/emergency_announcement_loaded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmergencyAnnouncementScreenProvider extends StatelessWidget {
  const EmergencyAnnouncementScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmergencyAnnouncementsBloc>(
      create: (context) {
        final emergencyAnnouncements = sl<EmergencyAnnouncementsBloc>();
        emergencyAnnouncements.add(GetEmergencyAnnouncements());
        return emergencyAnnouncements;
      },
      child: const EmergencyAnnouncementsScreen(),
    );
  }
}

class EmergencyAnnouncementsScreen extends StatelessWidget {
  const EmergencyAnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GinaPatientAppBar(title: 'Emergency Announcements'),
      body:
          BlocConsumer<EmergencyAnnouncementsBloc, EmergencyAnnouncementsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is EmergencyAnnouncementsLoaded) {
            return EmergencyAnnouncementScreenLoaded(
              doctorMedicalSpeciality: state.doctorMedicalSpeciality,
              emergencyAnnouncement: state.emergencyAnnouncement,
            );
          } else if (state is EmergencyAnnouncementsError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is EmergencyAnnouncementsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
