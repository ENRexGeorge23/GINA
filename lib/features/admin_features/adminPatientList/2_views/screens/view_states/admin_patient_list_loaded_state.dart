import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/admin_features/adminDashboard/2_views/bloc/admin_dashboard_bloc.dart';
import 'package:first_app/features/admin_features/adminPatientList/2_views/widgets/list_of_all_patients.dart';
import 'package:first_app/features/admin_features/adminPatientList/2_views/widgets/patient_list_label.dart';
import 'package:first_app/features/auth/0_model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gap/gap.dart';

class AdminPatientListLoaded extends StatelessWidget {
  final List<UserModel> patientList;
  const AdminPatientListLoaded({super.key, required this.patientList});

  @override
  Widget build(BuildContext context) {
    final adminDashboardBloc = context.read<AdminDashboardBloc>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: GinaAppTheme.appbarColorLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Text(
                        'List of all Patients',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                    BlocBuilder<AdminDashboardBloc, AdminDashboardState>(
                      builder: (context, state) {
                        if (state is NavigateToPatientsList) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 40.0),
                            child: InkWell(
                              onTap: () {
                                adminDashboardBloc
                                    .add(AdminDashboardGetRequestedEvent());
                              },
                              child: const Icon(
                                Icons.close_rounded,
                                color: GinaAppTheme.lightOutline,
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
                const Gap(20),
                PatientListLabel(
                  context: context,
                ),
                ListOfAllPatients(
                  patientList: patientList,
                  context: context,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
