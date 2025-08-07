import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/auth/0_model/user_model.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:first_app/features/patient_features/periodTracker/0_models/period_tracker_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class ApprovedPatientDataScreenState extends StatelessWidget {
  final UserModel patient;
  final List<PeriodTrackerModel> patientPeriods;
  final AppointmentModel patientAppointment;
  final List<AppointmentModel> patientAppointments;
  const ApprovedPatientDataScreenState({
    super.key,
    required this.patient,
    required this.patientPeriods,
    required this.patientAppointment,
    required this.patientAppointments,
  });

  @override
  Widget build(BuildContext context) {
    final ginaTheme = Theme.of(context);
    double itemHeight = MediaQuery.of(context).size.height * 0.08;
    final filteredPatientAppointments = patientAppointments
        .where((appointment) => appointment.appointmentStatus == 2)
        .toList();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.44,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    const Gap(20),
                    Image.asset(
                      Images.patientProfileImagePlaceholder,
                      width: 150, // updated width value
                    ),
                    const Gap(10),
                    Text(
                      patient.name,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                    Text(
                      patient.email,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: GinaAppTheme.lightOutline,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                    ),
                    const Gap(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Birth Date',
                                    style: ginaTheme.textTheme.bodySmall
                                        ?.copyWith(
                                            color: GinaAppTheme.lightOutline),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    patient.dateOfBirth,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Gender',
                                    style: ginaTheme.textTheme.bodySmall
                                        ?.copyWith(
                                            color: GinaAppTheme.lightOutline),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    patient.gender,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Gap(3),
                          const Divider(
                            thickness: 0.5,
                            color: GinaAppTheme.lightOutline,
                          ),
                          const Gap(5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Address',
                                  style: ginaTheme.textTheme.bodySmall
                                      ?.copyWith(
                                          color: GinaAppTheme.lightOutline),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                          const Gap(3),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Text(
                              patient.address,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                  ],
                ),
              ),
            ),
            const Gap(15),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Appointment Information',
                  style: ginaTheme.textTheme.labelLarge?.copyWith(
                    color: GinaAppTheme.lightOnPrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'SF UI Display',
                  )),
            ),
            const Gap(10),
            //appointment details here
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.14,
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Appointment ID: ",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const Gap(3),
                      Text(patientAppointment.appointmentUid.toString(),
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Date: ",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const Gap(3),
                      Text(patientAppointment.appointmentDate.toString(),
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Time: ",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const Gap(3),
                      Text(patientAppointment.appointmentTime.toString(),
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Mode of appointment: ",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const Gap(3),
                      Text(
                          patientAppointment.modeOfAppointment == 0
                              ? 'Online Consultation'
                              : 'Face to Face Consultation',
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(15),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Menstrual Cycle Information',
                  style: ginaTheme.textTheme.labelLarge?.copyWith(
                    color: GinaAppTheme.lightOnPrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'SF UI Display',
                  )),
            ),
            const Gap(10),
            // menstrual cycle
            patientPeriods.isEmpty
                ? Center(
                    child: Text(
                      "No menstrual cycle data available",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: GinaAppTheme.lightOutline,
                          ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: patientPeriods.length * itemHeight,
                    padding: const EdgeInsets.all(15.0),
                    child: ListView.builder(
                      itemCount: patientPeriods.length,
                      itemBuilder: (context, index) {
                        final period = patientPeriods[index];
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                    DateFormat('MMM dd')
                                        .format(period.startDate),
                                    style: ginaTheme.textTheme.labelLarge
                                        ?.copyWith(
                                      color:
                                          GinaAppTheme.lightTertiaryContainer,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      fontFamily: 'SF UI Display',
                                    )),
                                const Gap(10),
                                Text('-',
                                    style: ginaTheme.textTheme.labelLarge
                                        ?.copyWith(
                                      color:
                                          GinaAppTheme.lightTertiaryContainer,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      fontFamily: 'SF UI Display',
                                    )),
                                const Gap(10),
                                Text(
                                    DateFormat('MMM dd').format(period.endDate),
                                    style: ginaTheme.textTheme.labelLarge
                                        ?.copyWith(
                                      color:
                                          GinaAppTheme.lightTertiaryContainer,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      fontFamily: 'SF UI Display',
                                    )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.calendar_month_outlined,
                                  color: GinaAppTheme.lightOutline,
                                ),
                                const Gap(5),
                                Text(
                                  period.cycleLength.toString(),
                                ),
                                const Text(" day cycle"),
                              ],
                            ),
                            const Divider(
                              thickness: 0.5,
                              color: GinaAppTheme.lightOutline,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
            const Gap(15),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Consultation History',
                  style: ginaTheme.textTheme.labelLarge?.copyWith(
                    color: GinaAppTheme.lightOnPrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'SF UI Display',
                  )),
            ),
            const Gap(10),
            filteredPatientAppointments.isEmpty
                ? Center(
                    child: Text(
                      "No consultation history available yet",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: GinaAppTheme.lightOutline,
                          ),
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.04 *
                        patientAppointments
                            .length, // Set a specific height here
                    child: ListView.builder(
                      itemCount: filteredPatientAppointments.length,
                      itemBuilder: (context, index) {
                        final patientAppointment =
                            filteredPatientAppointments[index];
                        String appointmentData =
                            patientAppointment.appointmentDate!;
                        DateTime appointmentDate =
                            DateFormat('MMMM dd, yyyy').parse(appointmentData);
                        String abbreviatedMonth =
                            DateFormat('MMM').format(appointmentDate);
                        int day = appointmentDate.day;
                        return Padding(
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
                                  const Gap(30),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(patientAppointment.doctorName!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(
                                                fontSize: 20,
                                              )),
                                      Row(
                                        children: [
                                          Text(
                                              patientAppointment
                                                  .appointmentTime!
                                                  .split(' - ')[0],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                      color: GinaAppTheme
                                                          .lightOutline)),
                                          const Gap(5),
                                          Text('•',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium),
                                          const Gap(5),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            child: Text(
                                              patientAppointment
                                                          .modeOfAppointment ==
                                                      0
                                                  ? 'Online'
                                                  : 'F2F',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: GinaAppTheme
                                                          .lightTertiaryContainer),
                                              overflow: TextOverflow.ellipsis,
                                            ),
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
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
