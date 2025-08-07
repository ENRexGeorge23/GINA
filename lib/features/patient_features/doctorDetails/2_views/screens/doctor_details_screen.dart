import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/gina_patient_app_bar/gina_patient_app_bar.dart';
import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/patient_features/appointment/2_views/bloc/appointment_bloc.dart';
import 'package:first_app/features/patient_features/doctorDetails/2_views/bloc/doctor_details_bloc.dart';
import 'package:first_app/features/patient_features/doctorDetails/2_views/screens/view_states/doctor_details_screen_loaded.dart';
import 'package:first_app/features/patient_features/find/2_views/bloc/find_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorDetailsScreenProvider extends StatelessWidget {
  const DoctorDetailsScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DoctorDetailsBloc>(
      create: (context) {
        final doctorDetailsBloc = sl<DoctorDetailsBloc>();

        doctorDetailsBloc.add(DoctorDetailsFetchRequestedEvent());
        return doctorDetailsBloc;
      },
      child: const DoctorDetailsScreen(),
    );
  }
}

class DoctorDetailsScreen extends StatelessWidget {
  const DoctorDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final doctorDetailsBloc = context.read<DoctorDetailsBloc>();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: GinaPatientAppBar(
          title: 'Doctor Details',
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            doctorDetailsBloc.add(DoctorDetailsNavigateToConsultationEvent());
          },
          child: Image.asset(
            Images.messageIcon,
            width: 25,
          ),
        ),
        body: BlocConsumer<DoctorDetailsBloc, DoctorDetailsState>(
          listenWhen: (previous, current) =>
              current is DoctorDetailsActionState,
          buildWhen: (previous, current) =>
              current is! DoctorDetailsActionState,
          listener: (context, state) {
            if (state is DoctorDetailsNavigateToConsultationState) {
              isFromConsultationHistory = false;
              Navigator.pushNamed(context, '/consultation').then((value) {
                doctorDetailsBloc.add(DoctorDetailsFetchRequestedEvent());
              });
            }
          },
          builder: (context, state) {
            if (state is DoctorDetailsLoading) {
              return const CircularProgressIndicator();
            } else if (state is DoctorDetailsLoaded) {
              return DoctorDetailsScreenLoaded(
                doctor: doctorDetails!,
              );
            }
            return const SizedBox();
          },
        ));
  }
}
