import 'package:first_app/core/reusable_widgets/doctor_reusable_widgets/gina_doctor_app_bar.dart';
import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/doctor_features/doctorCalendarPage/bloc/doctor_calendar_bloc.dart';
import 'package:first_app/features/doctor_features/doctorCalendarPage/screens/view_states/doctor_calendar_initial_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorCalendarScreenProvider extends StatelessWidget {
  const DoctorCalendarScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DoctorCalendarBloc>(
      create: (context) => sl<DoctorCalendarBloc>(),
      child: const DoctorCalendarScreen(),
    );
  }
}

class DoctorCalendarScreen extends StatelessWidget {
  const DoctorCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  GinaDoctorAppBar(title: 'Calendar'),
      body: BlocConsumer<DoctorCalendarBloc, DoctorCalendarState>(
          listenWhen: (previous, current) =>
              current is DoctorCalendarActionState,
          buildWhen: (previous, current) =>
              current is! DoctorCalendarActionState,
          listener: (context, state) {},
          builder: (context, state) {
            if (state is DoctorCalendarInitial) {
              return const DoctorCalendarInitialScreen();
            }
            return const SizedBox.shrink();
          }),
    );
  }
}
