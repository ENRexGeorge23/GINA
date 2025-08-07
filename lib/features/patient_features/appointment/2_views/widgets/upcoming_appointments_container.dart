import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/patient_features/appointment/2_views/bloc/appointment_bloc.dart';
import 'package:first_app/features/patient_features/appointment/2_views/widgets/appointment_status.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class UpcomingAppointmentsContainer extends StatelessWidget {
  final List<AppointmentModel> appointments;

  const UpcomingAppointmentsContainer({
    super.key,
    required this.appointments,
  });

  @override
  Widget build(BuildContext context) {
    final appointmentsBloc = context.read<AppointmentBloc>();

    return appointments.isEmpty
        ? Center(
            child: Text(
              'No upcoming appointments',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: GinaAppTheme.lightOutline,
                  ),
            ),
          )
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              String appointmentData = appointment.appointmentDate!;
              DateTime appointmentDate =
                  DateFormat('MMMM dd, yyyy').parse(appointmentData);
              String abbreviatedMonth =
                  DateFormat('MMM').format(appointmentDate);
              int day = appointmentDate.day;
              return GestureDetector(
                onTap: () {
                  isFromAppointmentTabs = true;
                  appointmentsBloc.add(NavigateToAppointmentDetailsEvent(
                    doctorUid: appointment.doctorUid!,
                    appointmentUid: appointment.appointmentUid!,
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 25),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(abbreviatedMonth,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        fontSize: 22,
                                      )),
                              Text(day.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        fontSize: 20,
                                      )),
                            ],
                          ),
                          const Gap(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Dr. ${appointment.doctorName!}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        fontSize: 20,
                                      )),
                              Row(
                                children: [
                                  Text(
                                      appointment.appointmentTime!
                                          .split(' - ')[0],
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              color:
                                                  GinaAppTheme.lightOutline)),
                                  const Gap(5),
                                  Text('•',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                  const Gap(5),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: Text(
                                      appointment.modeOfAppointment == 0
                                          ? 'Online'
                                          : 'F2F',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: GinaAppTheme
                                                  .lightTertiaryContainer),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          AppointmentStatusContainer(
                            appointmentStatus: appointment.appointmentStatus,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}
