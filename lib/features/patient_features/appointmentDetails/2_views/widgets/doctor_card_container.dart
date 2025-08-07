import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/doctor_rating_badge/doctor_rating_badge.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DoctorCardContainer extends StatelessWidget {
  final DoctorModel doctor;
  const DoctorCardContainer({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.19,
      child: Row(
        children: [
          const Gap(20),
          Image.asset(Images.doctorProfileImagePlaceholder,
              width: 120, height: 120),
          const Gap(30),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DoctorRatingBadge(
                doctorRating: doctor.doctorRatingId,
              ),
              const Gap(5),
              Row(
                children: [
                  Text(
                    'Dr. ${doctor.name}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
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
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: GinaAppTheme.lightOutline,
                      )),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Text(
                  doctor.officeMapsLocationAddress,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: GinaAppTheme.lightOutline,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
