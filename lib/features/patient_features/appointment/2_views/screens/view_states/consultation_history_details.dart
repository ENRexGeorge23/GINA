import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:first_app/features/auth/0_model/user_model.dart';
import 'package:first_app/features/patient_features/appointment/2_views/bloc/appointment_bloc.dart';
import 'package:first_app/features/patient_features/appointmentDetails/2_views/widgets/appointment_information_container.dart';
import 'package:first_app/features/patient_features/appointmentDetails/2_views/widgets/doctor_card_container.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ConsultationHistoryDetailScreen extends StatelessWidget {
  final DoctorModel doctorDetails;
  final AppointmentModel appointment;
  final UserModel currentPatient;
  final List<String> prescriptionImages;
  const ConsultationHistoryDetailScreen(
      {super.key,
      required this.doctorDetails,
      required this.appointment,
      required this.currentPatient,
      required this.prescriptionImages});

  @override
  Widget build(BuildContext context) {
    final appointmentBloc = context.read<AppointmentBloc>();
    return RefreshIndicator(
      onRefresh: () async {
        appointmentBloc.add(NavigateToConsultationHistoryEvent(
            doctorUid: doctorDetails.uid,
            appointmentUid: appointment.appointmentUid!));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              DoctorCardContainer(
                doctor: doctorDetails,
              ),
              const Gap(10),
              AppointmentInformationContainer(
                appointmentModel: appointment,
                currentPatient: currentPatient,
              ),
              const Gap(15),
              prescriptionImages.isEmpty
                  ? const SizedBox()
                  : Text(
                      'Attachment(s)',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
              const Gap(15),
              prescriptionImages.isEmpty
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          'No attachment(s) available for this appointment.',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: GinaAppTheme.lightOutline)),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(20),
                          Expanded(
                            child: ListView.builder(
                                itemCount: prescriptionImages.length,
                                itemBuilder: (context, index) {
                                  final image = prescriptionImages[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Image.network(
                                        image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
              const Gap(15)
            ],
          ),
        ),
      ),
    );
  }
}
