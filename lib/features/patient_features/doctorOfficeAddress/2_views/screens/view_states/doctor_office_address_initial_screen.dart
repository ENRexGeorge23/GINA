import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/appointment_filled_button/appointment_filled_button.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:first_app/features/patient_features/appointmentDetails/2_views/widgets/doctor_card_container.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DoctorOfficeAddressInitialScreen extends StatelessWidget {
  final DoctorModel doctor;
  const DoctorOfficeAddressInitialScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DoctorCardContainer(
              doctor: doctor,
            ),
            const Gap(20),
            Text(
              'Office Address',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const Gap(10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Images.officeAddressLogo,
                  ),
                  const Gap(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          doctor.officeAdress,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                      const Gap(2),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          doctor.officeMapsLocationAddress,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      Text(
                        doctor.officePhoneNumber,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: GinaAppTheme.lightOutline,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            const BookAppointmentFilledButton(),
            const Gap(30),
          ],
        ),
      ),
    );
  }
}
