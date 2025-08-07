import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/admin_features/adminDoctorVerification/2_views/bloc/admin_doctor_verification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AdminVerificationPendingApprovedDeclineActionState
    extends StatelessWidget {
  const AdminVerificationPendingApprovedDeclineActionState({
    super.key,
    required this.adminDoctorVerificationBloc,
    required this.context,
  });

  final AdminDoctorVerificationBloc adminDoctorVerificationBloc;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminDoctorVerificationBloc,
        AdminDoctorVerificationState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              const Gap(20),
              Text(
                'Doctor Verification',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  adminDoctorVerificationBloc.add(
                      AdminVerificationPendingDoctorVerificationListEvent());
                },
                child: Text(
                  'Pending',
                  style: state
                          is AdminVerificationPendingDoctorVerificationListState
                      ? Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: GinaAppTheme.lightSecondary,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.solid,
                            decorationColor: GinaAppTheme.lightSecondary,
                          )
                      : Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: GinaAppTheme.lightOutline,
                          ),
                ),
              ),
              const Gap(20),
              InkWell(
                onTap: () {
                  adminDoctorVerificationBloc.add(
                      AdminVerificationApprovedDoctorVerificationListEvent());
                },
                child: Text(
                  'Approved',
                  style: state
                          is AdminVerificationApprovedDoctorVerificationListState
                      ? Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: GinaAppTheme.lightSecondary,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.solid,
                            decorationColor: GinaAppTheme.lightSecondary,
                          )
                      : Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: GinaAppTheme.lightOutline,
                          ),
                ),
              ),
              const Gap(20),
              InkWell(
                onTap: () {
                  adminDoctorVerificationBloc.add(
                      AdminVerificationDeclinedDoctorVerificationListEvent());
                },
                child: Text(
                  'Declined',
                  style: state
                          is AdminVerificationDeclinedDoctorVerificationListState
                      ? Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: GinaAppTheme.lightSecondary,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.solid,
                            decorationColor: GinaAppTheme.lightSecondary,
                          )
                      : Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: GinaAppTheme.lightOutline,
                          ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
