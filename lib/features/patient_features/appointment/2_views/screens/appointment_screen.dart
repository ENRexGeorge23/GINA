// ignore_for_file: unused_import

import 'package:first_app/core/enum/enum.dart';
import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/gina_patient_app_bar/gina_patient_app_bar.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/patient_features/appointment/2_views/bloc/appointment_bloc.dart';
import 'package:first_app/features/patient_features/appointment/2_views/screens/view_states/appointment_sceen_loaded.dart';
import 'package:first_app/features/patient_features/appointment/2_views/screens/view_states/consultation_history_details.dart';
import 'package:first_app/features/patient_features/appointment/2_views/widgets/upload_successfully_dialog.dart';
import 'package:first_app/features/patient_features/appointmentDetails/2_views/screens/appointment_details_screen.dart';
import 'package:first_app/features/patient_features/appointmentDetails/2_views/screens/view_states/appointment_details_status_screen.dart';
import 'package:first_app/features/patient_features/appointmentDetails/2_views/widgets/cancel_appointment_widgets/cancellation_success_modal.dart';
import 'package:first_app/features/patient_features/bookAppointment/2_views/bloc/book_appointment_bloc.dart';
import 'package:first_app/features/patient_features/find/2_views/bloc/find_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AppointmentScreenProvider extends StatelessWidget {
  const AppointmentScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppointmentBloc>(
      create: (context) {
        final appointmentBLoc = sl<AppointmentBloc>();

        if (isUploadPrescriptionMode) {
          appointmentBLoc.add(NavigateToConsultationHistoryEvent(
              doctorUid: doctorDetails!.uid,
              appointmentUid: storedAppointmentUid!));
        } else {
          appointmentBLoc.add(GetAppointmentsEvent());
        }

        return appointmentBLoc;
      },
      child: const AppointmentScreen(),
    );
  }
}

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appointmentBloc = context.read<AppointmentBloc>();
    return BlocBuilder<AppointmentBloc, AppointmentState>(
      builder: (context, state) {
        return Scaffold(
            appBar: GinaPatientAppBar(
                title: state is AppointmentDetailsState ||
                        state is AppointmentDetailsLoading
                    ? 'Appointment Details'
                    : state is ConsultationHistoryState ||
                            state is ConsultationHistoryLoading
                        ? 'Consultation History'
                        : 'Appointments',
                leading: state is AppointmentDetailsState ||
                        state is ConsultationHistoryState
                    ? IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          isFromAppointmentTabs = false;
                          appointmentBloc.add(GetAppointmentsEvent());
                        },
                      )
                    : isUploadPrescriptionMode
                        ? IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              isUploadPrescriptionMode = false;
                              Navigator.pushReplacementNamed(
                                  context, '/bottomNavigation');
                            },
                          )
                        : null),
            floatingActionButton: state is ConsultationHistoryState &&
                    state.appointment.appointmentStatus ==
                        AppointmentStatus.completed.index
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          isFromConsultationHistory = true;
                          Navigator.pushNamed(context, '/consultation');
                        },
                        child: Image.asset(
                          Images.messageIcon,
                          width: 25,
                        ),
                      ),
                      const Gap(10),
                      FloatingActionButton(
                        heroTag: 'uploadPrescription',
                        onPressed: () {
                          Navigator.pushNamed(context, '/uploadPrescription');
                        },
                        child: Image.asset(
                          Images.uploadIcon,
                          width: 25,
                        ),
                      ),
                    ],
                  )
                : state is AppointmentDetailsState
                    ? FloatingActionButton(
                        onPressed: () {
                          isFromConsultationHistory = false;
                          Navigator.pushNamed(context, '/consultation');
                        },
                        child: Image.asset(
                          Images.messageIcon,
                          width: 25,
                        ),
                      )
                    : const SizedBox(),
            body: BlocConsumer<AppointmentBloc, AppointmentState>(
              listenWhen: (previous, current) =>
                  state is AppointmentActionState,
              buildWhen: (previous, current) =>
                  state is! AppointmentActionState,
              listener: (context, state) {
                if (state is CancelAppointmentState) {
                  showCancellationSuccessDialog(context).then(
                      (value) => appointmentBloc.add(GetAppointmentsEvent()));
                }
              },
              builder: (context, state) {
                if (state is GetAppointmentsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ConsultationHistoryLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetAppointmentsLoaded) {
                  final appointments = state.appointments;
                  return AppointmentScreenLoaded(
                    appointments: appointments,
                  );
                } else if (state is GetAppointmentsError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else if (state is AppointmentDetailsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is AppointmentDetailsState) {
                  final appointmentDetails = state.appointment;
                  final doctorDetails = state.doctorDetails;
                  final currentActivePatient = state.currentPatient;
                  return AppointmentDetailsStatusScreen(
                    appointment: appointmentDetails,
                    doctorDetails: doctorDetails,
                    currentPatient: currentActivePatient,
                  );
                } else if (state is ConsultationHistoryState) {
                  final appointmentDetails = state.appointment;
                  final doctorDetails = state.doctorDetails;
                  final currentActivePatient = state.currentPatient;
                  final prescriptionImages = state.prescriptionImages;
                  return ConsultationHistoryDetailScreen(
                    appointment: appointmentDetails,
                    doctorDetails: doctorDetails,
                    currentPatient: currentActivePatient,
                    prescriptionImages: prescriptionImages,
                  );
                }

                return const SizedBox();
              },
            ));
      },
    );
  }
}
