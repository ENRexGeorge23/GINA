import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/auth/0_model/user_model.dart';
import 'package:first_app/features/doctor_features/doctorViewPatients/2_views/bloc/doctor_view_patients_bloc.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DoctorViewPatientsScreenLoaded extends StatelessWidget {
  final List<UserModel> patientList;
  final List<AppointmentModel> patientAppointments;

  const DoctorViewPatientsScreenLoaded({
    super.key,
    required this.patientList,
    required this.patientAppointments,
  });

  @override
  Widget build(BuildContext context) {
    final patientDetailsBloc = context.read<DoctorViewPatientsBloc>();
    return patientList.isEmpty
        ? Column(
            children: [
              const Gap(150),
              Center(
                child: Text(
                  "You don't have any patients yet",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: GinaAppTheme.lightOutline),
                ),
              ),
            ],
          )
        : ListView.builder(
            itemCount: patientList.length,
            itemBuilder: (context, index) {
              final patient = patientList[index];
              return GestureDetector(
                onTap: () {
                  patientDetailsBloc.add(FindNavigateToPatientDetailsEvent(
                    patient: patient,
                  ));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: GinaAppTheme.appbarColorLight,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25.0,
                              backgroundImage: AssetImage(
                                Images.patientProfileImagePlaceholder,
                              ),
                            ),
                            const Gap(10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  patient.name,
                                  style: const TextStyle(
                                    color: GinaAppTheme.lightInverseSurface,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "SF UI Display",
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  patient.email,
                                  style: const TextStyle(
                                    color: GinaAppTheme.lightOutline,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "SF UI Display",
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
