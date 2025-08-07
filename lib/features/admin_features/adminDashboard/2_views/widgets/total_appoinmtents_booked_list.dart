import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/admin_features/adminDashboard/2_views/bloc/admin_dashboard_bloc.dart';
import 'package:first_app/features/admin_features/adminPatientList/2_views/widgets/admin_patient_appointment_status.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class AdminDashboardTotalAppointmentsBooked extends StatelessWidget {
  final List<AppointmentModel> appointments;
  const AdminDashboardTotalAppointmentsBooked(
      {super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    final themeOfContext = Theme.of(context);
    final adminDashboardBloc = context.read<AdminDashboardBloc>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: GinaAppTheme.appbarColorLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Gap(20),
            Padding(
              padding: const EdgeInsets.only(left: 60.0, right: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Appointments History',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  InkWell(
                    onTap: () {
                      adminDashboardBloc.add(AdminDashboardGetRequestedEvent());
                    },
                    child: const Icon(
                      Icons.close_rounded,
                      color: GinaAppTheme.lightOutline,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(20),
            Container(
              height: MediaQuery.of(context).size.height * 0.035,
              width: double.infinity,
              color: const Color(0xffFFE7EB),
              child: Row(
                children: [
                  const Gap(20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.09,
                    child: Text(
                      'APPOINTMENT ID',
                      style: themeOfContext.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Gap(60),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: Text(
                      'PATIENT NAME',
                      style: themeOfContext.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Gap(60),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: Text(
                      'DOCTOR CONSULTED',
                      style: themeOfContext.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Gap(60),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.12,
                    child: Text(
                      'DATE & TIME OF CONSULTATION',
                      style: themeOfContext.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Gap(60),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: Text(
                      'CLINIC ADDRESS',
                      style: themeOfContext.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Gap(80),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: Text(
                      'MODE OF APPOINTMENT',
                      style: themeOfContext.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Gap(85),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                    child: Text(
                      'STATUS',
                      style: themeOfContext.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: GinaAppTheme.lightScrim,
                  thickness: 0.2,
                  height: 5,
                ),
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  final appointment = appointments[index];
                  return InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: const VerticalDivider(
                            color: GinaAppTheme.appbarColorLight,
                            thickness: 3,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: Text(
                            appointment.appointmentUid!,
                            style:
                                themeOfContext.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Gap(50),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.09,
                          child: Text(
                            appointment.patientName!,
                            style:
                                themeOfContext.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Gap(50),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.09,
                          child: Text(
                            'Dr. ${appointment.doctorName}',
                            style:
                                themeOfContext.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Gap(40),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.12,
                          child: Text(
                            '${DateFormat('MM/dd/yyyy').format(DateFormat('MMMM d, yyyy').parse(appointment.appointmentDate!))} @ ${appointment.appointmentTime!}',
                            style: themeOfContext.textTheme.labelMedium,
                          ),
                        ),
                        const Gap(50),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: Text(
                            appointment.doctorClinicAddress!,
                            style: themeOfContext.textTheme.labelMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Gap(80),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.08,
                          child: Text(
                            appointment.modeOfAppointment == 0
                                ? 'Online'
                                : 'Face-to-Face',
                            style: themeOfContext.textTheme.labelMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Gap(30),
                        AdminPatientAppointmentStatus(
                          themeOfContext: themeOfContext,
                          appointmentStatus: appointment.appointmentStatus,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
