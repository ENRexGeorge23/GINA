import 'package:first_app/core/enum/enum.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/admin_features/adminDashboard/2_views/bloc/admin_dashboard_bloc.dart';
import 'package:first_app/features/admin_features/adminDashboard/2_views/widgets/approved_doctor_verification_list.dart';
import 'package:first_app/features/admin_features/adminDashboard/2_views/widgets/dashboard_summary_containers.dart';
import 'package:first_app/features/admin_features/adminDashboard/2_views/widgets/declined_doctor_verification_list.dart';
import 'package:first_app/features/admin_features/adminDashboard/2_views/widgets/pending_approved_decline_action_state.dart';
import 'package:first_app/features/admin_features/adminDashboard/2_views/widgets/pending_doctor_verification_list.dart';
import 'package:first_app/features/admin_features/adminDashboard/2_views/widgets/table_label_container.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:first_app/features/auth/0_model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AdminDashboardInitialState extends StatelessWidget {
  final List<DoctorModel> doctors;
  final List<UserModel> patients;

  const AdminDashboardInitialState({
    super.key,
    required this.doctors,
    required this.patients,
  });

  @override
  Widget build(BuildContext context) {
    final adminDashboardBloc = context.read<AdminDashboardBloc>();
    final pendingDoctorList = doctors
        .where((element) =>
            element.doctorVerificationStatus ==
            DoctorVerificationStatus.pending.index)
        .toList();
    final approvedDoctorList = doctors
        .where((element) =>
            element.doctorVerificationStatus ==
            DoctorVerificationStatus.approved.index)
        .toList();

    final declineDoctorList = doctors
        .where((element) =>
            element.doctorVerificationStatus ==
            DoctorVerificationStatus.declined.index)
        .toList();
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Overview',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const Gap(10),
            DashboardSummaryContainers(
              doctors: doctorList,
              patients: patientList,
            ),
            const Gap(30),
            Container(
              height: MediaQuery.of(context).size.height * 0.68,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: GinaAppTheme.appbarColorLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  PendingApprovedDeclineActionState(
                      context: context, adminDashboardBloc: adminDashboardBloc),
                  TableLabelContainer(
                    context: context,
                  ),
                  BlocConsumer<AdminDashboardBloc, AdminDashboardState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is PendingDoctorVerificationListState) {
                        return PendingDoctorVerificationList(
                          pendingDoctorList: pendingDoctorList,
                          context: context,
                        );
                      } else if (state is ApprovedDoctorVerificationListState) {
                        return ApprovedDoctorVerificationList(
                          approvedDoctorList: approvedDoctorList,
                          context: context,
                        );
                      } else if (state is DeclinedDoctorVerificationListState) {
                        return DeclinedDoctorVerificationList(
                          declinedDoctorList: declineDoctorList,
                          context: context,
                        );
                      }

                      return PendingDoctorVerificationList(
                        pendingDoctorList: pendingDoctorList,
                        context: context,
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
