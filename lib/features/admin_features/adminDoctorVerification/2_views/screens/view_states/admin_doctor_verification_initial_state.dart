import 'package:first_app/core/enum/enum.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/admin_features/adminDashboard/2_views/widgets/approved_doctor_verification_list.dart';
import 'package:first_app/features/admin_features/adminDashboard/2_views/widgets/declined_doctor_verification_list.dart';
import 'package:first_app/features/admin_features/adminDashboard/2_views/widgets/pending_doctor_verification_list.dart';
import 'package:first_app/features/admin_features/adminDoctorVerification/2_views/bloc/admin_doctor_verification_bloc.dart';
import 'package:first_app/features/admin_features/adminDoctorVerification/2_views/widgets/admin_verification_pending_approved_decline_action_state.dart';
import 'package:first_app/features/admin_features/adminDoctorVerification/2_views/widgets/admin_verification_table_label_container.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminDoctorVerificationInitialState extends StatelessWidget {
  final List<DoctorModel> doctorList;
  
  const AdminDoctorVerificationInitialState(
      {super.key, required this.doctorList});

  @override
  Widget build(BuildContext context) {
    final adminDoctorVerificationBloc =
        context.read<AdminDoctorVerificationBloc>();

    final pendingDoctorList = doctorList
        .where((element) =>
            element.doctorVerificationStatus ==
            DoctorVerificationStatus.pending.index)
        .toList();
    final approvedDoctorList = doctorList
        .where((element) =>
            element.doctorVerificationStatus ==
            DoctorVerificationStatus.approved.index)
        .toList();

    final declineDoctorList = doctorList
        .where((element) =>
            element.doctorVerificationStatus ==
            DoctorVerificationStatus.declined.index)
        .toList();
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
              children: [
                AdminVerificationPendingApprovedDeclineActionState(
                  adminDoctorVerificationBloc: adminDoctorVerificationBloc,
                  context: context,
                ),
                AdminVerificationTableLabelContainer(
                  context: context,
                ),
                BlocConsumer<AdminDoctorVerificationBloc,
                    AdminDoctorVerificationState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state
                        is AdminVerificationPendingDoctorVerificationListState) {
                      return PendingDoctorVerificationList(
                        pendingDoctorList: pendingDoctorList,
                        context: context,
                      );
                    } else if (state
                        is AdminVerificationApprovedDoctorVerificationListState) {
                      return ApprovedDoctorVerificationList(
                        approvedDoctorList: approvedDoctorList,
                        context: context,
                      );
                    } else if (state
                        is AdminVerificationDeclinedDoctorVerificationListState) {
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
          ),
        ],
      ),
    );
  }
}
