import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/admin_features/adminDoctorList/2_views/bloc/admin_doctor_list_bloc.dart';
import 'package:intl/intl.dart';

class ListOfAllDoctors extends StatelessWidget {
  final List<DoctorModel> approvedDoctorList;
  final BuildContext context;

  const ListOfAllDoctors(
      {super.key, required this.context, required this.approvedDoctorList});

  @override
  Widget build(BuildContext context) {
    final adminDoctorListBloc = context.read<AdminDoctorListBloc>();
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          color: GinaAppTheme.lightScrim,
          thickness: 0.2,
          height: 5,
        ),
        itemCount: approvedDoctorList.length,
        itemBuilder: (context, index) {
          final doctor = approvedDoctorList[index];
          return InkWell(
            onTap: () {
              adminDoctorListBloc
                  .add(AdminDoctorDetailsEvent(doctorApproved: doctor));
            },
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
                Image.asset(
                  Images.doctorProfileIcon,
                  height: 30,
                  width: 30,
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.08,
                      child: Text(
                        'Dr. ${doctor.name}',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                    const Icon(
                      Icons.verified,
                      color: Colors.blue,
                      size: 18,
                    ),
                  ],
                ),
                const Gap(60),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.09,
                  child: Text(
                    doctor.email,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                const Gap(40),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.09,
                  child: Text(
                    doctor.medicalSpecialty,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                const Gap(50),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.09,
                  child: Text(
                    doctor.officeAdress,
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Gap(85),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.08,
                  child: Text(
                    doctor.officePhoneNumber,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                const Gap(70),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                  child: Text(
                    DateFormat('MM/dd/yyyy').format(doctor.created!.toDate()),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                const Gap(120),
                doctor.verifiedDate == null
                    ? const SizedBox()
                    : Container(
                        width: MediaQuery.of(context).size.width * 0.04,
                        height: MediaQuery.of(context).size.height * 0.025,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffFFE7EB),
                        ),
                        child: Center(
                          child: Text(
                            DateFormat('MM/dd/yyyy')
                                .format(doctor.verifiedDate!.toDate()),
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}