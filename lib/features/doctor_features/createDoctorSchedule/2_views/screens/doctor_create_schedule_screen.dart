import 'package:first_app/core/reusable_widgets/doctor_reusable_widgets/gina_doctor_app_bar.dart';
import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/doctor_features/createDoctorSchedule/2_views/bloc/create_doctor_schedule_bloc.dart';
import 'package:first_app/features/doctor_features/createDoctorSchedule/2_views/screens/view_states/doctor_create_schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorCreateScheduleScreenProvider extends StatelessWidget {
  const DoctorCreateScheduleScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateDoctorScheduleBloc>(
      create: (context) {
        final scheduleBloc = sl<CreateDoctorScheduleBloc>();
        scheduleBloc.add(CreateDoctorScheduleInitialEvent());
        return scheduleBloc;
      },
      child: const CreateDoctorScheduleScreen(),
    );
  }
}

class CreateDoctorScheduleScreen extends StatelessWidget {
  const CreateDoctorScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GinaDoctorAppBar(title: 'Create Schedule'),
      body: BlocConsumer<CreateDoctorScheduleBloc, CreateDoctorScheduleState>(
        listenWhen: (previous, current) => true,
        buildWhen: (previous, current) => true,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CreateDoctorScheduleInitial) {
            return DoctorCreateScheduleScreenLoaded(
              selectedDays: const [],
              endTimes: const [],
              startTimes: const [],
              selectedMode: const [],
            );
          }
          return DoctorCreateScheduleScreenLoaded(
            selectedDays: const [],
            endTimes: const [],
            startTimes: const [],
            selectedMode: const [],
          );
        },
      ),
    );
  }
}
