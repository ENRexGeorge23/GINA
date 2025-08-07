import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/doctor_rating_badge/doctor_rating_badge.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:first_app/features/doctor_features/doctorProfile/2_views/bloc/doctor_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DoctorProfileScreenLoaded extends StatelessWidget {
  final DoctorModel doctorData;
  const DoctorProfileScreenLoaded({super.key, required this.doctorData});

  @override
  Widget build(BuildContext context) {
    final ginaTheme = Theme.of(context);
    final profileBloc = context.read<DoctorProfileBloc>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: GinaAppTheme.appbarColorLight,
              ),
              height: MediaQuery.of(context).size.height / 1.70,
              width: MediaQuery.of(context).size.width / 1.05,
              child: Column(
                children: [
                  const Gap(30),
                  SizedBox(
                    child: Image.asset(
                      Images.doctorProfileImagePlaceholder,
                      width: 140,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Gap(10),
                  DoctorRatingBadge(doctorRating: doctorData.doctorRatingId),
                  const Gap(10),
                  Column(
                    children: [
                      Text(
                        "Dr. ${doctorData.name}",
                        style: ginaTheme.textTheme.headlineSmall?.copyWith(
                          fontSize: 20,
                        ),
                      ),
                      Text(doctorData.email,
                          style: ginaTheme.textTheme.bodySmall
                              ?.copyWith(color: GinaAppTheme.lightOutline)),
                    ],
                  ),
                  const Gap(10),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.038,
                    child: OutlinedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        side: MaterialStateProperty.all(
                          const BorderSide(
                            width: 1.0,
                          ),
                        ),
                      ),
                      onPressed: () {
                        profileBloc.add(NavigateToEditDocotorProfileEvent());
                      },
                      child: Text('Edit Profile',
                          style: ginaTheme.textTheme.labelLarge?.copyWith(
                            color: GinaAppTheme.lightOnPrimaryColor,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ),
                  const Gap(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Office Address',
                                style: ginaTheme.textTheme.bodySmall?.copyWith(
                                    color: GinaAppTheme.lightOutline)),
                            const Gap(3),
                            Text(
                              doctorData.officeAdress,
                            ),
                            const Gap(7),
                            Text('Phone Number',
                                style: ginaTheme.textTheme.bodySmall?.copyWith(
                                    color: GinaAppTheme.lightOutline)),
                            const Gap(3),
                            Text(
                              doctorData.officePhoneNumber,
                            ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Divider(
                          thickness: 0.5,
                          color: GinaAppTheme.lightOutline,
                        ),
                      ),
                      const Gap(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                profileBloc.add(
                                    DoctorProfileNavigateToMyForumsPostEvent());
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.height * 0.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: GinaAppTheme.lightOnTertiary,
                                  image: DecorationImage(
                                    image: AssetImage(Images.patientForumPost),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'My Forum\nPosts',
                                      style: ginaTheme.textTheme.headlineMedium
                                          ?.copyWith(
                                        color: GinaAppTheme.lightOnTertiary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Gap(15),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Medical Specialty',
                  style: ginaTheme.textTheme.labelLarge?.copyWith(
                    color: GinaAppTheme.lightOnPrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'SF UI Display',
                  )),
            ),
            const Gap(10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: GinaAppTheme.lightOnTertiary,
              ),
              height: MediaQuery.of(context).size.height / 18,
              width: MediaQuery.of(context).size.width / 1.05,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        doctorData.medicalSpecialty,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(15),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('License Number',
                  style: ginaTheme.textTheme.labelLarge?.copyWith(
                    color: GinaAppTheme.lightOnPrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'SF UI Display',
                  )),
            ),
            const Gap(10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: GinaAppTheme.lightOnTertiary,
              ),
              height: MediaQuery.of(context).size.height / 18,
              width: MediaQuery.of(context).size.width / 1.05,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        doctorData.medicalLicenseNumber,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(15),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Board Certification',
                  style: ginaTheme.textTheme.labelLarge?.copyWith(
                    color: GinaAppTheme.lightOnPrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'SF UI Display',
                  )),
            ),
            const Gap(10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: GinaAppTheme.lightOnTertiary,
              ),
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width / 1.05,
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Organization',
                      style: ginaTheme.textTheme.bodySmall
                          ?.copyWith(color: GinaAppTheme.lightOutline)),
                  const Gap(3),
                  Text(
                    doctorData.boardCertificationOrganization,
                  ),
                  const Gap(10),
                  Text('Date of Certification',
                      style: ginaTheme.textTheme.bodySmall
                          ?.copyWith(color: GinaAppTheme.lightOutline)),
                  const Gap(3),
                  Text(
                    doctorData.boardCertificationDate,
                  ),
                ],
              ),
            ),
            const Gap(15),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Educational Experience',
                  style: ginaTheme.textTheme.labelLarge?.copyWith(
                    color: GinaAppTheme.lightOnPrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'SF UI Display',
                  )),
            ),
            const Gap(10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: GinaAppTheme.lightOnTertiary,
              ),
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width / 1.05,
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Medical School',
                      style: ginaTheme.textTheme.bodySmall
                          ?.copyWith(color: GinaAppTheme.lightOutline)),
                  const Gap(3),
                  Text(
                    doctorData.medicalSchool,
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Start Date',
                          style: ginaTheme.textTheme.bodySmall
                              ?.copyWith(color: GinaAppTheme.lightOutline),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'End Date',
                          style: ginaTheme.textTheme.bodySmall
                              ?.copyWith(color: GinaAppTheme.lightOutline),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  const Gap(3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          doctorData.medicalSchoolStartDate,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          doctorData.medicalSchoolEndDate,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 0.5,
                    color: GinaAppTheme.lightOutline,
                  ),
                  Text('Residency Program',
                      style: ginaTheme.textTheme.bodySmall
                          ?.copyWith(color: GinaAppTheme.lightOutline)),
                  const Gap(3),
                  Text(
                    doctorData.residencyProgram,
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Start Date',
                          style: ginaTheme.textTheme.bodySmall
                              ?.copyWith(color: GinaAppTheme.lightOutline),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'End Date',
                          style: ginaTheme.textTheme.bodySmall
                              ?.copyWith(color: GinaAppTheme.lightOutline),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  const Gap(3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          doctorData.residencyProgramStartDate,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          doctorData.residencyProgramGraduationYear,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 0.5,
                    color: GinaAppTheme.lightOutline,
                  ),
                  Text('Fellowship Program',
                      style: ginaTheme.textTheme.bodySmall
                          ?.copyWith(color: GinaAppTheme.lightOutline)),
                  const Gap(3),
                  Text(
                    doctorData.fellowShipProgram,
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Start Date',
                          style: ginaTheme.textTheme.bodySmall
                              ?.copyWith(color: GinaAppTheme.lightOutline),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'End Date',
                          style: ginaTheme.textTheme.bodySmall
                              ?.copyWith(color: GinaAppTheme.lightOutline),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  const Gap(3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          doctorData.fellowShipProgramStartDate,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          doctorData.fellowShipProgramEndDate,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  // const Divider(
                  //   thickness: 0.5,
                  //   color: GinaAppTheme.lightOutline,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
