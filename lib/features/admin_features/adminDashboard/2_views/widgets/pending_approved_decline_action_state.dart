import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/admin_features/adminDashboard/2_views/bloc/admin_dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class PendingApprovedDeclineActionState extends StatelessWidget {
  const PendingApprovedDeclineActionState({
    super.key,
    required this.adminDashboardBloc,
    required this.context,
  });


  final AdminDashboardBloc adminDashboardBloc;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminDashboardBloc, AdminDashboardState>(
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
                  adminDashboardBloc.add(
                    PendingDoctorVerificationListEvent(),
                  );
                },
                child: Text(
                  'Pending',
                  style: state is PendingDoctorVerificationListState
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
                  adminDashboardBloc.add(
                    ApprovedDoctorVerificationListEvent(),
                  );
                },
                child: Text(
                  'Approved',
                  style: state is ApprovedDoctorVerificationListState
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
                  adminDashboardBloc.add(
                    DeclinedDoctorVerificationListEvent(),
                  );
                },
                child: Text(
                  'Declined',
                  style: state is DeclinedDoctorVerificationListState
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
