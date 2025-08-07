import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/admin_features/adminPatientList/2_views/bloc/admin_patient_list_bloc.dart';
import 'package:first_app/features/auth/0_model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class ListOfAllPatients extends StatelessWidget {
  final List<UserModel> patientList;
  final BuildContext context;
  const ListOfAllPatients(
      {super.key, required this.context, required this.patientList});

  @override
  Widget build(BuildContext context) {
    final adminPatientListBloc = context.read<AdminPatientListBloc>();

    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          color: GinaAppTheme.lightScrim,
          thickness: 0.2,
          height: 5,
        ),
        itemCount: patientList.length,
        itemBuilder: (context, index) {
          final patient = patientList[index];
          return InkWell(
            onTap: () {
              adminPatientListBloc.add(AdminPatientDetailsEvent(
                patientDetails: patient,
              ));
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
                  Images.profileIcon,
                  height: 30,
                  width: 30,
                ),
                const Gap(10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.08,
                  child: Text(
                    patient.name,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const Gap(60),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: Text(
                    patient.email,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                const Gap(60),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                  child: Text(
                    patient.gender,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                const Gap(40),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: Text(
                    patient.address,
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Gap(95),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.08,
                  child: Text(
                    patient.dateOfBirth,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                const Gap(70),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                  child: Text(
                    DateFormat('MM/dd/yyyy').format(patient.created!.toDate()),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                const Gap(160),
                Container(
                  width: MediaQuery.of(context).size.width * 0.02,
                  height: MediaQuery.of(context).size.height * 0.025,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffFFE7EB),
                  ),
                  child: Center(
                    child: Text(
                      patient.appointmentsBooked.length.toString(),
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
