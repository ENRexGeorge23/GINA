import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/gina_patient_app_bar/gina_patient_app_bar.dart';
import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/patient_features/doctorOfficeAddress/2_views/bloc/doctor_office_address_bloc.dart';
import 'package:first_app/features/patient_features/doctorOfficeAddress/2_views/screens/view_states/doctor_office_address_initial_screen.dart';
import 'package:first_app/features/patient_features/find/2_views/bloc/find_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorOfficeAddressScreenProvider extends StatelessWidget {
  const DoctorOfficeAddressScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DoctorOfficeAddressBloc>(
      create: (context) => sl<DoctorOfficeAddressBloc>(),
      child: const DoctorOfficeAddressScreen(),
    );
  }
}

class DoctorOfficeAddressScreen extends StatelessWidget {
  const DoctorOfficeAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GinaPatientAppBar(title: 'Office Address'),
      body: BlocConsumer<DoctorOfficeAddressBloc, DoctorOfficeAddressState>(
        listenWhen: (previous, current) =>
            current is DoctorOfficeAddressActionState,
        buildWhen: (previous, current) =>
            current is! DoctorOfficeAddressActionState,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is DoctorOfficeAddressInitial) {
            return DoctorOfficeAddressInitialScreen(
              doctor: doctorDetails!,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
