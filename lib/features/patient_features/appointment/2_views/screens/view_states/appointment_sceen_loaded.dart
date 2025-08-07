import 'package:first_app/core/enum/enum.dart';
import 'package:first_app/features/patient_features/appointment/2_views/bloc/appointment_bloc.dart';
import 'package:first_app/features/patient_features/appointment/2_views/widgets/appointment_consultation_history_container.dart';
import 'package:first_app/features/patient_features/appointment/2_views/widgets/upcoming_appointments_container.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AppointmentScreenLoaded extends StatelessWidget {
  final List<AppointmentModel> appointments;
  const AppointmentScreenLoaded({
    super.key,
    required this.appointments,
  });

  @override
  Widget build(BuildContext context) {
    double itemHeight = MediaQuery.of(context).size.height * 0.12;
    final appointmentBloc = context.read<AppointmentBloc>();

    final upcomingAppointments = appointments
        .where((appointment) =>
            appointment.appointmentStatus ==
                AppointmentStatus.confirmed.index ||
            appointment.appointmentStatus == AppointmentStatus.pending.index)
        .toList();
    final completedAppointments = appointments
        .where((appointment) =>
            appointment.appointmentStatus !=
                AppointmentStatus.confirmed.index &&
            appointment.appointmentStatus != AppointmentStatus.pending.index)
        .toList();
    return RefreshIndicator(
      onRefresh: () async {
        appointmentBloc.add(GetAppointmentsEvent());
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Upcoming Appointments',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const Gap(10),
                    SizedBox(
                      height: upcomingAppointments.isEmpty
                          ? MediaQuery.of(context).size.height * 0.2
                          : upcomingAppointments.length * itemHeight,
                      child: UpcomingAppointmentsContainer(
                        appointments: upcomingAppointments,
                      ),
                    ),
                    const Gap(20),
                    Text(
                      'Consultation History',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const Gap(10),
                    SizedBox(
                      height: completedAppointments.isEmpty
                          ? MediaQuery.of(context).size.height * 0.2
                          : completedAppointments.length * itemHeight,
                      child: AppointmentConsultationHistoryContainer(
                        appointments: completedAppointments,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
