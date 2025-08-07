import 'package:first_app/core/reusable_widgets/doctor_reusable_widgets/gina_doctor_app_bar.dart';
import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/doctor_features/createDoctorSchedule/2_views/bloc/create_doctor_schedule_bloc.dart';
import 'package:first_app/features/doctor_features/doctorScheduleManagement/2_views/bloc/doctor_schedule_bloc.dart';
import 'package:first_app/features/doctor_features/doctorScheduleManagement/2_views/screens/view_states/doctor_schedule_screen_loaded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorScheduleScreenProvider extends StatelessWidget {
  const DoctorScheduleScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DoctorScheduleBloc>(
      create: (context) {
        final scheduleBloc = sl<DoctorScheduleBloc>();
        scheduleBloc.add(DoctorScheduleInitialEvent());
        return scheduleBloc;
      },
      child: const DoctorScheduleScreen(),
    );
  }
}

class DoctorScheduleScreen extends StatelessWidget {
  const DoctorScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GinaDoctorAppBar(
        leading: isFromCreateDoctorSchedule
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, '/doctorBottomNavigation');
                  isFromCreateDoctorSchedule = false;
                },
              )
            : null,
        title: 'Schedule Management',
      ),
      body: BlocConsumer<DoctorScheduleBloc, DoctorScheduleState>(
        listenWhen: (previous, current) => true,
        buildWhen: (previous, current) => true,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetScheduleSuccessState) {
            final schedule = state.schedule;
            return DoctorScheduleScreenLoaded(
              schedule: schedule,
            );
          } else if (state is GetScheduleFailedState) {
            return Center(child: Text(state.message));
          } else if (state is GetScheduleLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return const SizedBox();
        },
      ),
    );
  }
}
