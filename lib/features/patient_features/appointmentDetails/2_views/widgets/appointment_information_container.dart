import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/auth/0_model/user_model.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:first_app/features/patient_features/bookAppointment/2_views/bloc/book_appointment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AppointmentInformationContainer extends StatelessWidget {
  final AppointmentModel appointmentModel;
  final UserModel currentPatient;
  const AppointmentInformationContainer({
    super.key,
    required this.appointmentModel,
    required this.currentPatient,
  });

  @override
  Widget build(BuildContext context) {
    final bookAppointmentBloc = context.read<BookAppointmentBloc>();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.43,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(' ID: ${appointmentModel.appointmentUid}',
                    style: Theme.of(context).textTheme.bodyMedium),
                const Gap(5),
                const Divider(
                  thickness: 0.2,
                  color: GinaAppTheme.lightOutline,
                ),
                const Gap(10),
                Row(
                  children: [
                    const Gap(5),
                    Image.asset(Images.doctorStethoscope),
                    const Gap(15),
                    Text(
                      'Appointment Detail',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Clinic location',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const Gap(35),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Text(
                        appointmentModel.doctorClinicAddress!,
                        style: const TextStyle(fontSize: 12),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mode of appointment',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const Gap(35),
                    Text(
                      appointmentModel.modeOfAppointment == 0
                          ? 'Online Consultation'
                          : 'Face to Face Consultation',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const Gap(20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date and time',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const Gap(35),
                    Text(
                      '${appointmentModel.appointmentDate!} \n${appointmentModel.appointmentTime!}',
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
                const Gap(10),
                const Divider(
                  thickness: 0.2,
                  color: GinaAppTheme.lightOutline,
                ),
                const Gap(10),
                Row(
                  children: [
                    const Gap(5),
                    const Icon(
                      Icons.person_rounded,
                      color: GinaAppTheme.lightOnSecondary,
                    ),
                    const Gap(5),
                    Text(
                      'Patient Personal Information',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Name',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const Gap(35),
                    Text(
                      currentPatient.name,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const Gap(20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Age',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const Gap(35),
                    Text(
                      " ${bookAppointmentBloc.calculateAge(currentPatient.dateOfBirth)} years old",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const Gap(20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Location',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const Gap(35),
                    SizedBox(
                      width: 150,
                      child: Text(
                        currentPatient.address,
                        textAlign: TextAlign.end,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
