import 'package:first_app/core/reusable_widgets/doctor_reusable_widgets/gina_doctor_app_bar.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/bloc/doctor_appointment_request_bloc.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/screens/view_states/doctor_appointment_request_screen_loaded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorAppointmentRequestProvider extends StatelessWidget {
  const DoctorAppointmentRequestProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DoctorAppointmentRequestBloc>(
      create: (context) => DoctorAppointmentRequestBloc(),
      child: const DoctorAppointmentRequestScreen(),
    );
  }
}

class DoctorAppointmentRequestScreen extends StatelessWidget {
  const DoctorAppointmentRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GinaDoctorAppBar(title: 'Appointment Requests'),
      body: BlocConsumer<DoctorAppointmentRequestBloc,
          DoctorAppointmentRequestState>(
        listenWhen: (previous, current) =>
            current is DoctorAppointmentRequestActionState,
        buildWhen: (previous, current) =>
            current is! DoctorAppointmentRequestActionState,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is DoctorAppointmentRequestInitial) {
            return const DoctorAppointmentRequestScreenLoaded();
          }

          return const DoctorAppointmentRequestScreenLoaded();
        },
      ),
    );
  }
}
