import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/gina_patient_app_bar/gina_patient_app_bar.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/patient_features/appointment/2_views/bloc/appointment_bloc.dart';
import 'package:first_app/features/patient_features/appointmentDetails/2_views/bloc/appointment_details_bloc.dart';
import 'package:first_app/features/patient_features/bookAppointment/2_views/bloc/book_appointment_bloc.dart';
import 'package:first_app/features/patient_features/bookAppointment/2_views/pages/view_states/book_appointment_initial_screen.dart';
import 'package:first_app/features/patient_features/bookAppointment/2_views/pages/view_states/review_appointment_initial_screen.dart';
import 'package:first_app/features/patient_features/find/2_views/bloc/find_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class BookAppointmentScreenProvider extends StatelessWidget {
  const BookAppointmentScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookAppointmentBloc>(
      create: (context) {
        final bookAppointmentBloc = sl<BookAppointmentBloc>();
        bookAppointmentBloc.add(GetDoctorAvailabilityEvent(
          doctorId: doctorDetails!.uid,
        ));
        return bookAppointmentBloc;
      },
      child: const BookAppointmentScreen(),
    );
  }
}

class BookAppointmentScreen extends StatelessWidget {
  const BookAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
      builder: (context, state) {
        return Scaffold(
          appBar: GinaPatientAppBar(
              leading: isFromAppointmentTabs
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  : null,
              title: state is ReviewAppointmentState
                  ? 'Review Appointment'
                  : isRescheduleMode
                      ? 'Reschedule Appointment'
                      : 'Book Appointment'),
          body: BlocConsumer<BookAppointmentBloc, BookAppointmentState>(
            listenWhen: (previous, current) =>
                current is BookAppointmentActionState,
            buildWhen: (previous, current) =>
                current is! BookAppointmentActionState,
            listener: (context, state) {
              if (state is BookAppoinmentRequestLoading) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.of(context).pop();
                    });
                    return Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: GinaAppTheme.appbarColorLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 200,
                        width: 200,
                        padding: const EdgeInsets.all(15.0),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            Gap(30),
                            Text(
                              'Requesting Appointment...',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
            builder: (context, state) {
              if (state is GetDoctorAvailabilityLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetDoctorAvailabilityError) {
                return Center(child: Text(state.message));
              } else if (state is GetDoctorAvailabilityLoaded) {
                final doctorAvailabilityModel = state.doctorAvailabilityModel;
                return BookAppointmentInitialScreen(
                  doctorAvailabilityModel: doctorAvailabilityModel,
                );
              } else if (state is BookAppointmentLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is BookAppointmentError) {
                return Center(child: Text(state.message));
              } else if (state is ReviewAppointmentState) {
                final appointmentModel = state.appointmentModel;
                return ReviewAppointmentInitialScreen(
                  doctorDetails: doctorDetails!,
                  currentPatient: currentActivePatient!,
                  appointmentModel: appointmentModel,
                );
              }
              return const SizedBox();
            },
          ),
        );
      },
    );
  }
}
