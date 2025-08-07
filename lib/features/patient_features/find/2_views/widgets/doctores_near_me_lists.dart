import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:first_app/features/patient_features/find/2_views/bloc/find_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DoctorsNearMeList extends StatelessWidget {
  final List<DoctorModel> doctorLists;
  const DoctorsNearMeList({
    super.key,
    required this.doctorLists,
  });

  @override
  Widget build(BuildContext context) {
    final findBloc = context.read<FindBloc>();
    final fixHeight = MediaQuery.of(context).size.height * 0.1;

    return SizedBox(
      height: doctorLists.isEmpty
          ? MediaQuery.of(context).size.height * 0.2
          : fixHeight * doctorLists.length,
      child: doctorLists.isEmpty
          ? const Center(
              child: Text('No doctors found near your area'),
            )
          : ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemExtent: 90,
              itemCount: doctorLists.length,
              itemBuilder: (context, index) {
                final doctor = doctorLists[index];
                return GestureDetector(
                  onTap: () {
                    findBloc
                        .add(FindNavigateToDoctorDetailsEvent(doctor: doctor));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: GinaAppTheme.lightOnTertiary,
                      ),
                      child: Row(
                        children: [
                          const Gap(10),
                          Image.asset(
                            Images.findDoctorImage,
                            width: 70,
                            height: 70,
                          ),
                          const Gap(10),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Dr. ${doctor.name}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    const Gap(3),
                                    const Icon(
                                      Icons.verified_rounded,
                                      color: Color(0xff29A5FF),
                                      size: 15,
                                    )
                                  ],
                                ),
                                const Gap(3),
                                Container(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  height: MediaQuery.of(context).size.height *
                                      0.020,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: GinaAppTheme.lightSurface,
                                  ),
                                  child: Center(
                                    child: Text(
                                        doctor.medicalSpecialty.toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                fontSize: 8.5,
                                                fontWeight: FontWeight.w800)),
                                  ),
                                ),
                                const Gap(3),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Text(doctor.officeAdress,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            letterSpacing: -0.05,
                                            fontSize: 12,
                                          )),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
