import 'package:first_app/core/reusable_widgets/doctor_reusable_widgets/gina_doctor_app_bar.dart';
import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/view_states/approvedState/screens/view_states/approved_request_details_screen_state.dart';
import 'package:first_app/features/doctor_features/doctorEConsult/2_views/bloc/doctor_e_consult_bloc.dart';
import 'package:first_app/features/doctor_features/doctorUpcomingAppointments/2_views/bloc/doctor_upcoming_appointments_bloc.dart';
import 'package:first_app/features/doctor_features/doctorUpcomingAppointments/2_views/screens/view_states/completed_appointment_details_screen_state.dart';
import 'package:first_app/features/doctor_features/doctorUpcomingAppointments/2_views/widgets/past_appointments_list.dart';
import 'package:first_app/features/doctor_features/doctorUpcomingAppointments/2_views/widgets/tab_controller.dart';
import 'package:first_app/features/doctor_features/doctorUpcomingAppointments/2_views/widgets/upcoming_appointments_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DoctorUpcomingAppointmentScreenProvider extends StatelessWidget {
  const DoctorUpcomingAppointmentScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DoctorUpcomingAppointmentsBloc>(
      create: (context) {
        final doctorUpcomingAppointmentsBloc =
            sl<DoctorUpcomingAppointmentsBloc>();

        isFromChatRoomLists = false;
        doctorUpcomingAppointmentsBloc
            .add(const UpcomingAppointmentsFilterEvent(isSelected: true));

        return doctorUpcomingAppointmentsBloc;
      },
      child: const DoctorUpcomingAppointmentsScreen(),
    );
  }
}

class DoctorUpcomingAppointmentsScreen extends StatelessWidget {
  const DoctorUpcomingAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GinaDoctorAppBar(
        title: 'Appointments',
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<DoctorUpcomingAppointmentsBloc,
                  DoctorUpcomingAppointmentsState>(
                builder: (context, state) {
                  final upcominngEventsState = state is UpcomingEventsState ||
                      state is DoctorUpcomingAppointmentsLoaded ||
                      state is DoctorUpcomingAppointmentsLoading;
                  final pastEventsState = state is PastEventsState ||
                      state is DoctorPastAppointmentsLoaded ||
                      state is DoctorPastAppointmentsLoading;
                  return Container(
                    width: 220,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6E6E6),
                      borderRadius: BorderRadius.circular(23),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<DoctorUpcomingAppointmentsBloc>().add(
                                  const UpcomingAppointmentsFilterEvent(
                                    isSelected: true,
                                  ),
                                );
                          },
                          child: tabController(
                            label: 'Upcoming',
                            height: 46,
                            isSelected: upcominngEventsState,
                          ),
                        ),
                        const SizedBox(width: 0),
                        GestureDetector(
                          onTap: () {
                            context.read<DoctorUpcomingAppointmentsBloc>().add(
                                  const PastAppointmentsFilterEvent(
                                    isSelected: true,
                                  ),
                                );
                          },
                          child: tabController(
                            label: 'Past',
                            height: 46,
                            isSelected: pastEventsState,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const Gap(10),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: BlocConsumer<DoctorUpcomingAppointmentsBloc,
                    DoctorUpcomingAppointmentsState>(
                  listenWhen: (previous, current) =>
                      current is DoctorUpcomingAppointmentsActionState,
                  buildWhen: (previous, current) =>
                      current is! DoctorUpcomingAppointmentsActionState,
                  listener: (context, state) {
                    if (state is NavigateToApprovedRequestDetailState) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ApprovedRequestDetailsScreenState(
                            appointment: state.appointment,
                            patientData: state.patientData,
                          ),
                        ),
                      ).then((value) => context
                          .read<DoctorUpcomingAppointmentsBloc>()
                          .add(const UpcomingAppointmentsFilterEvent(
                            isSelected: true,
                          )));
                    } else if (state is NavigateToCompletedRequestDetailState) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CompletedAppointmentDetailsScreenState(
                            appointment: state.appointment,
                            patientData: state.patientData,
                          ),
                        ),
                      ).then((value) => context
                          .read<DoctorUpcomingAppointmentsBloc>()
                          .add(const PastAppointmentsFilterEvent(
                            isSelected: true,
                          )));
                    }
                  },
                  builder: (context, state) {
                    if (state is DoctorUpcomingAppointmentsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is DoctorUpcomingAppointmentsError) {
                      return Text(state.message);
                    } else if (state is DoctorUpcomingAppointmentsLoaded) {
                      return UpcomingAppointmentsList(
                          approvedRequests: state.appointments);
                    } else if (state is DoctorPastAppointmentsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is DoctorPastAppointmentsError) {
                      return Text(state.message);
                    } else if (state is DoctorPastAppointmentsLoaded) {
                      return PastAppointmentsList(
                          approvedRequests: state.appointments);
                    }

                    return const SizedBox();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
