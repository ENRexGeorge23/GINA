import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/admin_features/adminPatientList/2_views/bloc/admin_patient_list_bloc.dart';
import 'package:first_app/features/admin_features/adminPatientList/2_views/widgets/admin_patient_appointment_status.dart';
import 'package:first_app/features/auth/0_model/user_model.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class AdminPatientDetailsState extends StatelessWidget {
  final UserModel patientDetails;
  final List<AppointmentModel> appointments;
  const AdminPatientDetailsState(
      {super.key, required this.patientDetails, required this.appointments});

  @override
  Widget build(BuildContext context) {
    final themeOfContext = Theme.of(context);
    final adminPatientListBloc = context.read<AdminPatientListBloc>();
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: GinaAppTheme.appbarColorLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //----Back Button ------
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: InkWell(
                onTap: () {
                  adminPatientListBloc.add(AdminPatientListGetRequestedEvent());
                },
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: GinaAppTheme.lightOutline,
                ),
              ),
            ),
            //------------Patient Primary Details----------------
            Padding(
              padding: const EdgeInsets.only(
                left: 60.0,
                right: 40.0,
              ),
              child: Row(
                children: [
                  Image.asset(Images.patientAdminPlaceholderImage),
                  const Gap(40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            patientDetails.name,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 27,
                                ),
                          ),
                          const Gap(20),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_pin,
                                color: GinaAppTheme.lightSecondary,
                              ),
                              Text(
                                patientDetails.address,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      color: GinaAppTheme.lightSecondary,
                                    ),
                              ),
                            ],
                          ),
                          const Gap(570),
                        ],
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'E-mail: ',
                                    style: themeOfContext.textTheme.labelMedium
                                        ?.copyWith(
                                      color: GinaAppTheme.lightOutline,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Gap(7),
                                  Text(
                                    'Gender: ',
                                    style: themeOfContext.textTheme.labelMedium
                                        ?.copyWith(
                                      color: GinaAppTheme.lightOutline,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Gap(7),
                                  Text(
                                    'Date of birth: ',
                                    style: themeOfContext.textTheme.labelMedium
                                        ?.copyWith(
                                      color: GinaAppTheme.lightOutline,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Gap(7),
                                  Text(
                                    'Address: ',
                                    style: themeOfContext.textTheme.labelMedium
                                        ?.copyWith(
                                      color: GinaAppTheme.lightOutline,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    patientDetails.email,
                                    style: themeOfContext.textTheme.labelMedium
                                        ?.copyWith(
                                      color: GinaAppTheme.lightSecondary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Gap(7),
                                  Text(
                                    patientDetails.gender,
                                    style: themeOfContext.textTheme.labelMedium
                                        ?.copyWith(
                                      color: GinaAppTheme.lightOnSecondary,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const Gap(7),
                                  Text(
                                    patientDetails.dateOfBirth,
                                    style: themeOfContext.textTheme.labelMedium
                                        ?.copyWith(
                                      color: GinaAppTheme.lightOnSecondary,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const Gap(7),
                                  Text(
                                    patientDetails.address,
                                    style: themeOfContext.textTheme.labelMedium
                                        ?.copyWith(
                                      color: GinaAppTheme.lightOnSecondary,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Gap(300),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    Images.doctorDateRegistered,
                                    height: MediaQuery.of(context).size.height *
                                        0.045,
                                    filterQuality: FilterQuality.high,
                                  ),
                                  const Gap(20),
                                  Text(
                                    'DATE REGISTERED ',
                                    style: themeOfContext.textTheme.labelLarge
                                        ?.copyWith(
                                      color: GinaAppTheme.lightOutline,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Gap(20),
                                  Text(
                                    DateFormat('MM/dd/yyyy').format(
                                        patientDetails.created!.toDate()),
                                    style: themeOfContext.textTheme.labelLarge
                                        ?.copyWith(
                                      color: GinaAppTheme.lightOnSecondary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(5),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.17,
                                child: const Divider(
                                  color: GinaAppTheme.lightOutline,
                                  thickness: 0.3,
                                ),
                              ),
                              const Gap(5),
                              Row(
                                children: [
                                  Image.asset(
                                    Images.appointmentsBooked,
                                    height: MediaQuery.of(context).size.height *
                                        0.045,
                                    filterQuality: FilterQuality.high,
                                  ),
                                  const Gap(20),
                                  Text(
                                    'APPOINTMENTS\nBOOKED ',
                                    style: themeOfContext.textTheme.labelLarge
                                        ?.copyWith(
                                      color: GinaAppTheme.lightOutline,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Gap(40),
                                  Text(
                                    appointments.length.toString(),
                                    style: themeOfContext.textTheme.labelLarge
                                        ?.copyWith(
                                      color: GinaAppTheme.lightOnSecondary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(10),
            //---------------------------------Divider--------------------------------
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: const Padding(
                  padding: EdgeInsets.only(right: 55.0),
                  child: Divider(
                    color: GinaAppTheme.lightOutline,
                    thickness: 0.3,
                  ),
                ),
              ),
            ),
            //-----------------------------------------------------------------------

            const Gap(15),
            Padding(
              padding: const EdgeInsets.only(left: 60.0),
              child: Text(
                'Consultation History (${appointments.length.toString()})',
                style: themeOfContext.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
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
                      'DOCTOR CONSULTED',
                      style: themeOfContext.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Gap(50),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: Text(
                      'DATE OF CONSULTATION',
                      style: themeOfContext.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Gap(60),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: Text(
                      'TIME OF CONSULTATION',
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
                  const Gap(60),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: Text(
                      'MODE OF APPOINTMENT',
                      style: themeOfContext.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Gap(80),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
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
                            'Dr. ${appointment.doctorName}',
                            style:
                                themeOfContext.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Gap(40),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.09,
                          child: Text(
                            appointment.appointmentDate!,
                            style: themeOfContext.textTheme.labelMedium,
                          ),
                        ),
                        const Gap(40),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.08,
                          child: Text(
                            appointment.appointmentTime!,
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
                        const Gap(70),
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
                        const Gap(20),
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
