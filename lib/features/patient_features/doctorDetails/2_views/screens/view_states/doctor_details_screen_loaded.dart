import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/doctor_rating_badge/doctor_rating_badge.dart';
import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/appointment_filled_button/appointment_filled_button.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:first_app/features/patient_features/doctorAvailability/2_views/bloc/doctor_availability_bloc.dart';
import 'package:first_app/features/patient_features/doctorDetails/2_views/widgets/container_doctor_details.dart';
import 'package:first_app/features/patient_features/find/2_views/bloc/find_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DoctorDetailsScreenLoaded extends StatelessWidget {
  final DoctorModel doctor;
  const DoctorDetailsScreenLoaded({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final ginaTheme = Theme.of(context);
    final doctorAvailabilityBloc = context.read<DoctorAvailabilityBloc>();

    return Column(
      children: [
        const Gap(20),
        Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.34,
            child: Column(
              children: [
                const Gap(20),
                Image.asset(Images.doctorProfileImagePlaceholder),
                const Gap(10),
                DoctorRatingBadge(doctorRating: doctor.doctorRatingId),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dr. ${doctor.name}',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                    const Gap(5),
                    const Icon(
                      Icons.verified_rounded,
                      color: Color(0xff29A5FF),
                      size: 20,
                    )
                  ],
                ),
                const Gap(2),
                Text(doctor.medicalSpecialty,
                    style: ginaTheme.textTheme.bodyMedium
                        ?.copyWith(color: GinaAppTheme.lightOutline)),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(doctor.officeMapsLocationAddress,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: ginaTheme.textTheme.bodyMedium
                          ?.copyWith(color: GinaAppTheme.lightOutline)),
                ),
              ],
            ),
          ),
        ),
        const Gap(20),
        const BookAppointmentFilledButton(),
        const Gap(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Row(
                children: [
                  ContainerDoctorDetails(
                      onTap: () {
                        Navigator.pushNamed(context, '/appointmentDetails');
                      },
                      ginaTheme: ginaTheme,
                      containerText: 'Appointment \nDetails',
                      containerImage: Images.appointmentDetails),
                  const Gap(20),
                  ContainerDoctorDetails(
                      onTap: () {
                        Navigator.pushNamed(context, '/consultationFeeDetails');
                      },
                      ginaTheme: ginaTheme,
                      containerText: 'Consultation\n Fee Details',
                      containerImage: Images.consultationFee),
                ],
              ),
              const Gap(20),
              Row(
                children: [
                  ContainerDoctorDetails(
                      onTap: () {
                        doctorAvailabilityBloc.add(GetDoctorAvailabilityEvent(
                            doctorId: doctorDetails!.uid));
                        Navigator.pushNamed(context, '/doctorAvailability');
                      },
                      ginaTheme: ginaTheme,
                      containerText: 'Doctor \nAvailability',
                      containerImage: Images.doctorAvailabilty),
                  const Gap(20),
                  ContainerDoctorDetails(
                      onTap: () {
                        Navigator.pushNamed(context, '/doctorOfficeAddress');
                      },
                      ginaTheme: ginaTheme,
                      containerText: 'Office \nAddress',
                      containerImage: Images.officeAddress),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
