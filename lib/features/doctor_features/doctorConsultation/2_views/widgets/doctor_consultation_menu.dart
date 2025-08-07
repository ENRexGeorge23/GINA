import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/doctor_features/doctorConsultation/2_views/bloc/doctor_consultation_bloc.dart';
import 'package:first_app/features/doctor_features/doctorUpcomingAppointments/2_views/bloc/doctor_upcoming_appointments_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DoctorConsultationMenu extends StatelessWidget {
  final String appointmentId;
  const DoctorConsultationMenu({
    required this.appointmentId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final doctorConsultationBloc = context.read<DoctorConsultationBloc>();
    return SubmenuButton(
        style: const ButtonStyle(
          padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
            EdgeInsets.all(10),
          ),
          overlayColor: MaterialStatePropertyAll(Colors.transparent),
          shape: MaterialStatePropertyAll<CircleBorder>(
            CircleBorder(
              side: BorderSide(
                color: GinaAppTheme.appbarColorLight,
              ),
            ),
          ),
        ),
        menuStyle: const MenuStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(
            GinaAppTheme.appbarColorLight,
          ),
          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
            )),
          ),
        ),
        menuChildren: [
          MenuItemButton(
            child: Row(
              children: [
                const Gap(20),
                Image.asset(
                  Images.profileUnselectedIcon,
                  width: 20,
                  color: GinaAppTheme.lightOnSecondary,
                ),
                const Gap(10),
                Text('View Patient Data',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        )),
                const Gap(10),
              ],
            ),
            onPressed: () {
              doctorConsultationBloc.add(NavigateToPatientDateEvent(
                  patientData: patientDataFromDoctorUpcomingAppointmentsBloc!,
                  appointment:
                      appointmentDataFromDoctorUpcomingAppointmentsBloc!));
            },
          ),
          MenuItemButton(
            child: Row(
              children: [
                const Gap(20),
                const Icon(Icons.phone, color: GinaAppTheme.declinedTextColor),
                const Gap(10),
                Text('End Consultation',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 15,
                          color: GinaAppTheme.declinedTextColor,
                          fontWeight: FontWeight.w500,
                        )),
                const Gap(10),
              ],
            ),
            onPressed: () {
              doctorConsultationBloc.add(CompleteDoctorConsultationButtonEvent(
                  appointmentId: appointmentId));
            },
          ),
        ],
        child: const Icon(Icons.info_outline));
  }
}
