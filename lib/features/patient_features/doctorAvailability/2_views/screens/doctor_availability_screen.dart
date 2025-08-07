import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/gina_patient_app_bar/gina_patient_app_bar.dart';
import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/patient_features/doctorAvailability/2_views/bloc/doctor_availability_bloc.dart';
import 'package:first_app/features/patient_features/doctorAvailability/2_views/screens/view_states/doctor_availability_initial_screen.dart';
import 'package:first_app/features/patient_features/find/2_views/bloc/find_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorAvailabilityScreenProvider extends StatelessWidget {
  const DoctorAvailabilityScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DoctorAvailabilityBloc>(
      create: (context) {
        final doctorAvailabilityBloc = sl<DoctorAvailabilityBloc>();

        doctorAvailabilityBloc.add(GetDoctorAvailabilityEvent(
          doctorId: doctorDetails!.uid,
        ));

        return doctorAvailabilityBloc;
      },
      child: const DoctorAvailabilityScreen(),
    );
  }
}

class DoctorAvailabilityScreen extends StatelessWidget {
  const DoctorAvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GinaPatientAppBar(title: 'Doctor Availability'),
        body: BlocConsumer<DoctorAvailabilityBloc, DoctorAvailabilityState>(
          listenWhen: (previous, current) =>
              current is DoctorAvailabilityActionState,
          buildWhen: (previous, current) =>
              current is! DoctorAvailabilityActionState,
          listener: (context, state) {},
          builder: (context, state) {
            if (state is DoctorAvailabilityLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DoctorAvailabilityError) {
              return Center(child: Text(state.message));
            } else if (state is DoctorAvailabilityLoaded) {
              final doctorAvailabilityModel = state.doctorAvailabilityModel;
              return DoctorAvailabilityInitialScreen(
                doctorAvailability: doctorAvailabilityModel,
              );
            }
            return const SizedBox();
          },
        ));
  }
}
