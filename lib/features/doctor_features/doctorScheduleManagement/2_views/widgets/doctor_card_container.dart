import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/doctor_features/doctorScheduleManagement/2_views/bloc/doctor_schedule_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DoctorDetailsCard extends StatelessWidget {
  const DoctorDetailsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 6.5,
        width: MediaQuery.of(context).size.width / 1.05,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: GinaAppTheme.appbarColorLight,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Dr. ${currentActiveDoctor!.name}",
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'SF UI Display',
                                color: GinaAppTheme.lightOnPrimaryColor,
                              ),
                            ),
                            const Gap(10),
                            const SizedBox(
                                width: 5), // Adjust the width as needed
                            const Icon(
                              Icons.verified,
                              color: Colors.blue,
                            ), // Add the icon here
                          ],
                        ),
                        const Gap(2),
                        Text(
                          currentActiveDoctor!.medicalSpecialty,
                          style: const TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'SF UI Display',
                            color: GinaAppTheme.lightTertiaryContainer,
                          ),
                        ),
                        const Gap(2),
                        Text(
                          'Office Address: ${currentActiveDoctor!.officeAdress}',
                          style: const TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'SF UI Display',
                            color: GinaAppTheme.lightOnPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, right: 30.0, bottom: 20.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: CircleAvatar(
                        radius: 43,
                        backgroundImage: AssetImage(
                          Images.findDoctorImage,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
