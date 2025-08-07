import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/gina_patient_app_bar/gina_patient_app_bar.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/patient_features/appointment/2_views/bloc/appointment_bloc.dart'
    as appointment_bloc;
import 'package:first_app/features/patient_features/appointmentDetails/2_views/bloc/appointment_details_bloc.dart';
import 'package:first_app/features/patient_features/appointmentDetails/2_views/screens/view_states/appointment_details_initial_screen.dart';
import 'package:first_app/features/patient_features/appointmentDetails/2_views/screens/view_states/appointment_details_status_screen.dart';
import 'package:first_app/features/patient_features/appointmentDetails/2_views/widgets/cancel_appointment_widgets/cancellation_success_modal.dart';
import 'package:first_app/features/patient_features/bookAppointment/2_views/bloc/book_appointment_bloc.dart';
import 'package:first_app/features/patient_features/find/2_views/bloc/find_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AppointmentDetailsScreenProvider extends StatelessWidget {
  const AppointmentDetailsScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppointmentDetailsBloc>(
      create: (context) {
        final appointmentDetailsBloc = sl<AppointmentDetailsBloc>();

        appointmentDetailsBloc.add(NavigateToAppointmentDetailsStatusEvent());

        return appointmentDetailsBloc;
      },
      child: const AppointmentDetailsScreen(),
    );
  }
}

class AppointmentDetailsScreen extends StatelessWidget {
  const AppointmentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GinaPatientAppBar(
          title: 'Appointment Details',
          leading: appointment_bloc.isFromAppointmentTabs
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              : null,
        ),
        floatingActionButton:
            BlocBuilder<AppointmentDetailsBloc, AppointmentDetailsState>(
          builder: (context, state) {
            if (state is AppointmentDetailsStatusState) {
              return FloatingActionButton(
                onPressed: () {
                  appointment_bloc.isFromConsultationHistory = false;
                  Navigator.pushNamed(context, '/consultation');
                },
                child: Image.asset(
                  Images.messageIcon,
                  width: 25,
                ),
              );
            }
            return const SizedBox();
          },
        ),
        body: BlocConsumer<AppointmentDetailsBloc, AppointmentDetailsState>(
          listenWhen: (previous, current) =>
              current is AppointmentDetailsActionState,
          buildWhen: (previous, current) =>
              current is! AppointmentDetailsActionState,
          listener: (context, state) {
            if (state is CancelAppointmentState) {
              showCancellationSuccessDialog(context)
                  .then((value) => Navigator.pop(context));
            } else if (state is CancelAppointmentError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            } else if (state is CancelAppointmentLoading) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: GinaAppTheme.appbarColorLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 200,
                      width: 300,
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          const Gap(30),
                          Text(
                            'Cancelling Appointment...',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ).then((value) => Navigator.pop(context));
            }
          },
          builder: (context, state) {
            if (state is AppointmentDetailsStatusState) {
              final appointment = state.appointment;
              return appointment.appointmentUid == null
                  ? const AppointmentDetailsInitialScreen()
                  : AppointmentDetailsStatusScreen(
                      doctorDetails: doctorDetails!,
                      appointment: appointment,
                      currentPatient: currentActivePatient!,
                    );
            } else if (state is AppointmentDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AppointmentDetailsError) {
              return Center(
                child: Text(state.message),
              );
            }

            return const SizedBox();
          },
        ));
  }
}
