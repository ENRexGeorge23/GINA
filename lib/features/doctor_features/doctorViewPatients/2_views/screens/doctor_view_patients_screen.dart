import 'package:first_app/core/reusable_widgets/doctor_reusable_widgets/gina_doctor_app_bar.dart';
import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/doctor_features/doctorViewPatients/2_views/bloc/doctor_view_patients_bloc.dart';
import 'package:first_app/features/doctor_features/doctorViewPatients/2_views/screens/view_states/doctor_view_patients_screen_loaded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorViewPatientsScreenProvider extends StatelessWidget {
  const DoctorViewPatientsScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DoctorViewPatientsBloc>(
      create: (context) {
        final patientViewBloc = sl<DoctorViewPatientsBloc>();
        patientViewBloc.add(DoctorViewPatientsInitialEvent());
        return patientViewBloc;
      },
      child: const DoctorViewPatientsScreen(),
    );
  }
}

class DoctorViewPatientsScreen extends StatelessWidget {
  const DoctorViewPatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final patientViewBloc = context.read<DoctorViewPatientsBloc>();
    return Scaffold(
      appBar: GinaDoctorAppBar(title: 'Patient List'),
      body: BlocConsumer<DoctorViewPatientsBloc, DoctorViewPatientsState>(
        listenWhen: (previous, current) =>
            current is DoctorViewPatientsActionState,
        buildWhen: (previous, current) =>
            current is! DoctorViewPatientsActionState,
        listener: (context, state) {
          if (state is FindNavigateToPatientDetailsState) {
            Navigator.pushNamed(context, '/doctorPatientDetails', arguments: {
              state.patient,
              state.patientPeriods,
              state.patientAppointments,
            }).then((value) =>
                patientViewBloc.add(DoctorViewPatientsInitialEvent()));
          }
        },
        builder: (context, state) {
          if (state is GetDoctorViewPatientsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetPatientListFailedState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is GetPatientListSuccessState) {
            final patientAppointmentList = state.patientAppointmentList;
            final patientAppointmentPeriod = state.patientsAppointmentperiod;
            return DoctorViewPatientsScreenLoaded(
              patientAppointments: patientAppointmentList,
              patientList: patientAppointmentPeriod,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
